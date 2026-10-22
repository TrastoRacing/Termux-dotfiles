# Auditoría de Seguridad y Calidad — `termux-dotfiles`

> **Fecha:** 2026-10-20 · **Ámbito:** repositorio completo (56 ficheros) en estado pre-publicación (0 commits, todo staged) · **Objetivo:** verificar que el repo es seguro para publicar en GitHub y que dotfiles/scripts son correctos y coherentes con su propósito.
>
> **Método:** revisión estática de todos los ficheros + verificación en vivo sobre el propio dispositivo Termux (shellcheck, `zsh -n`, servidor tmux de prueba, `jq`, ejecución de `btm`, `chezmoi managed`) + contraste con documentación oficial de chezmoi y atuin (Context7) + verificación web de licencias (MesloLGS NF, LazyVim).

---

## Veredicto

**No hay secretos, credenciales ni PII en el repositorio. Nada que rotar.** El historial git está vacío (0 commits, 56 ficheros staged), así que tampoco existen fugas pasadas. La arquitectura zero-secrets declarada en el README **es real y está bien construida**.

El repositorio es publicable tras corregir los 4 hallazgos **Medium** (todos de hardening o atribución; ninguno es una fuga).

---

## 1. Seguridad

### Medium

| ID | Hallazgo | Evidencia | Corrección propuesta |
| :--- | :--- | :--- | :--- |
| **M1** | Binario de `bottom` descargado del alias mutable `releases/latest`, sin pin de versión ni verificación de checksum, y extraído a `~/.local/bin` (primera entrada de `PATH`). Un release upstream comprometido enviaría un ejecutable arbitrario a todo clonador en el `chezmoi apply` inicial. | `run_once_after_02-setup-environment.sh:67-71`; `private_dot_zshrc:6`. URL verificada: responde HTTP 200. | Pinear tag exacto (`.../download/<ver>/bottom_aarch64-linux-android.tar.gz`), embeber su SHA256 en el script y verificar antes de `tar`; abortar si no coincide. |
| **M2** | `npm install -g` de 13 paquetes resueltos a *latest* en cada provisione limpia. Un paquete npm comprometido o typosquatteado ejecutaría en las máquinas de los clonadores (son LSPs/formatters que procesan ficheros de proyecto). | `run_once_before_01-install-packages.sh:114` (mapa en `:88-102`). | Fijar versiones en las claves de `NPM_BINS` (p. ej. `["pyright@1.1.x"]`) y bump deliberado en commits revisados. |
| **M3** | Fuente binaria de 2.5 MB sin atribución de licencia. **Licencia confirmada durante la auditoría: MesloLGS NF es Apache-2.0** (© André Berg, distribuida vía `romkatv/powerlevel10k-media`). La redistribución está permitida **solo con inclusión de la licencia y atribución**; el repo se declara MIT-only. | `private_dot_termux/private_font.ttf`; `README.md:23`, `README.md:78-80`; `docs/ReadmeChezmoi.md:18`. | Incluir el texto Apache-2.0 junto a la fuente + entrada de atribución en README (nombre, autor, licencia, URL origen), siguiendo el patrón ya correcto del flavor de Yazi (`private_yazi/private_flavors/private_tokyo-night.yazi/private_readonly_LICENSE*`). |
| **M4** | `.gitignore` y `.chezmoiignore` no cubren Atuin: los propios scripts crean `~/.atuin/data/key` (clave que protege el historial completo). Un `chezmoi add ~/.atuin` futuro stagearía clave y `history.db` sin ningún freno. Compárese con `.ssh`, `.gnupg`, `.config/gh`, `.netrc`, `.npmrc`, que sí están bloqueados. | `.gitignore` (sin patrón atuin); `.chezmoiignore` (sin entrada `.atuin`); `run_once_after_02-setup-environment.sh:79-84`. | Añadir `.atuin` + `.atuin/**` a `.chezmoiignore` y `*dot_atuin*` (opcionalmente `*history.db*`) a `.gitignore`. |

### Low

| ID | Hallazgo | Evidencia | Corrección propuesta |
| :--- | :--- | :--- | :--- |
| **L1** | Plugins de zsh clonados a HEAD mutable y ejecutados por cada shell. Riesgo limitado a compromiso del org `zsh-users` (reputable). | `run_once_after_02-setup-environment.sh:49,53`; sources en `private_dot_zshrc:232,239`. | Clonar tag pineado (`--branch v0.7.1` / `v0.8.0`) o verificar commit registrado tras el clone. |
| **L2** | Código de bootstrap/build sin pin: `lazy.nvim` al tag móvil `stable` y `npx --yes yarn install` ejecuta la versión de `yarn` que esté de moda en npm en el momento del build. Mitigante: los 47 plugins reales están pineados a commit exacto en `lazy-lock.json` y se restauran con `Lazy! restore`. | `private_nvim/private_lua/private_config/private_lazy.lua:3-4`; `private_nvim/private_lua/private_plugins/private_markdown-preview.lua:7`. | `npx --yes yarn@1.22.22 install`; el tag `stable` de lazy.nvim es default aceptado de LazyVim — documentarlo en el modelo de confianza. |
| **L3** | La provisione escribe fuera de `$HOME`, en almacenamiento compartido Android (`/storage/emulated/0/Documents`), legible por cualquier app con permiso de storage. Sin sobrescritura (guard `[[ ! -f ]]`). | `run_once_after_02-setup-environment.sh:24-31`. | Hacerlo opt-in (gate por env var) o eliminar el paso. |
| **L4** | En máquinas con Atuin en layout antiguo (`~/.local/share/atuin`), crear `~/.atuin/data/key` hace que Atuin "encuentre" `~/.atuin` y pase al layout nuevo → el historial previo queda oculto (db aparentemente vacía). Confirmado contra docs oficiales: Atuin usa el layout antiguo solo si no encuentra nada en `~/.atuin`. | `run_once_after_02-setup-environment.sh:79-84`; docs.atuin.sh (config > upgrading). | Guard: omitir la generación si `~/.local/share/atuin` existe. |

### Info

| ID | Hallazgo | Nota |
| :--- | :--- | :--- |
| **I1** | Los `run_once_*.sh` son la superficie de supply-chain del repo: `chezmoi init --apply` los ejecuta con privilegios de usuario, y cualquier commit futuro que modifique un script lo re-dispara en los clonadores. Hoy todos los URLs apuntan a fuentes reputadas, todo es HTTPS, no hay `curl\|bash` ni `sudo`/`tsu`. | Documentar en README la expectativa de confianza ("revisa `run_once_*.sh` antes de aplicar"). |
| **I2** | `LICENSE` sin titular: "Copyright (c) 2026" a secas. | Decidir nombre/handle del titular antes de publicar. |
| **I3** | Patrones de `.gitignore` excesivamente anchos (`*history*`, `*token*`, `*secret*`…): dirección segura (sobre-ignorar), pero un futuro `docs/history.md` jamás se commitearía. Opcional: acotar a prefijos chezmoi (`*private_token*`). | `.gitignore:33-42`. |

### Verificado y limpio (con evidencia, no asumido)

- **Secretos/credenciales:** barrido regex de `ghp_…`, `github_pat_`, `AKIA…`, `xox…`, `sk-…`, `AIza…`, `BEGIN … PRIVATE KEY`, `api_key[:=]`, `password[:=]`, `bearer` → cero matches. Sin claves SSH, sin `hosts.yml`, sin `.netrc`/`.npmrc`.
- **PII:** cero emails, cero `user.name`/`user.email`. `private_git/private_config` solo contiene delta/pager/merge — sin bloque `[user]`. Fastfetch y el tema omp renderizan usuario/host dinámicamente en runtime. Las afirmaciones zero-secrets del README son exactas.
- **Atuin:** clave generada localmente con `openssl rand`, `chmod 600`, nunca trackeada; `secrets_filter` + `history_filter` activos en `private_atuin/private_config.toml`.
- **Patrones de instalación:** sin `curl | bash`; `pkg`/`dpkg` provienen de repos Termux firmados; `tldr --update` es el updater oficial; ningún contexto elevado; nada escribe fuera de `$HOME` salvo el paso L3 (guardado).
- **Pineado positivo:** 47 plugins de Neovim a commit exacto (`lazy-lock.json`); flavor Yazi pineado con `rev` + `hash` (`private_package.toml`); licencias de terceros retenidas donde corresponden (Apache-2.0 en nvim — coherente con la licencia de LazyVim, confirmada; MIT en el flavor de Yazi).
- **Termux:** `allow-external-apps` sigue des comentado/desactivado; `private_empty_dot_hushlogin` vacío como corresponde.

---

## 2. Corrección (verificación en vivo en el dispositivo)

| Check | Resultado |
| :--- | :--- |
| `shellcheck` sobre ambos `run_once_*.sh` | ✅ 0 hallazgos |
| `zsh -n private_dot_zshrc` | ✅ sintaxis válida |
| `tmux -f private_dot_tmux.conf` en servidor de prueba | ✅ parsea sin errores |
| `jq` sobre tema omp y `lazyvim.json` | ✅ JSON válido |
| `btm` ejecutando exactamente la config del repo (diff byte a byte) | ✅ arranca sin error de parseo |
| `chezmoi managed` sobre el source | ✅ estado fuente válido; convenciones `private_`/`dot_`/`empty_` correctas |
| Semántica `run_once_before_` / `run_once_after_` | ✅ correcta por diseño: docs oficiales confirman el orden `before_scripts → archivos → after_scripts`; los paquetes se instalan antes de desplegar configs y el setup corre con todo en su sitio |
| Path `~/.atuin/data/key` | ✅ correcto — es el layout moderno por defecto de Atuin (docs oficiales); caveat L4 solo para layouts antiguos |
| Flag `--disable-ai` de atuin | ✅ existe en la versión instalada (18.24.1) |
| Mapa `NPM_BINS` → binarios reales | ✅ los 13 pares package↔bin son correctos (`ngserver`, `astro-ls`, `vtsls`, `docker-langserver`, `tsc`, …) |
| `nvim --headless "+Lazy! restore" +qa` | ✅ sintaxis moderna válida, restauración por lockfile |
| Staging git | ✅ 56 ficheros staged incl. fuente binaria y flavor; sin omisiones |

**Notas positivas de diseño:** el filtro de `private_mason.lua` (instala solo lo ausente de `$PATH`) es la adaptación Termux correcta para evitar binarios de Mason no compatibles con Android; `docs/` se despliega a `~/docs/` de forma intencional y coherente con el script §3; `markdown-preview` redirige a `termux-open-url` (adaptación Android correcta); el guard `[[ -d ... ]]`/`[[ -x ... ]]` hace los scripts idempotentes y seguros de re-ejecutar.

---

## 3. Coherencia docs ↔ configs

Las guías de **tmux, yazi y chezmoi son exactas** (binds, aliases, flujos y claims verificados uno a uno contra las configs). Desajustes encontrados:

1. **El tema del prompt no es Tokyo Night** — `private_powerlevel10k_classic.omp.json` usa los colores stock del tema omp (#546E7A / #26C6DA / #D4E157), pero `README.md:5` promete "consistent Tokyo Night styling across all tools" y `docs/ReadmeZsh.md:11` afirma que la paleta coincide. → Re-colorear los segmentos del tema o suavizar la afirmación.
2. **`<Space>gh` contradicho** — `docs/ReadmeNeovim.md:109` documenta "Git hunk operations", pero `private_diffview.lua:8` liga `<leader>gh` a `DiffviewFileHistory %`, sombreándolo.
3. **Menores:**
   - `docs/ReadmeZsh.md:29`: el ejemplo `lt 3` es imposible — el alias fija `--level=2` y `3` se pasaría como ruta.
   - `docs/ReadmeChezmoi.md:91`: dice que el script 02 "sets up the MesloLGS font"; en realidad la despliega chezmoi como fichero y el script solo hace `termux-reload-settings`.
   - `README.md:26`: "Generate a local encryption key" sobre-promete — sin `atuin register` el historial local no va cifrado; la clave solo interviene al sincronizar (inferencia).
   - `private_termux/private_termux.properties` es la plantilla stock 100 % comentada (5.9 KB no-op): recortar o activar ajustes reales (p. ej. `extra-keys` para tablet).
   - `LICENSE` sin titular (ver I2).
   - Al no llevar `[user]` el git config (correcto para zero-secrets), el README debería incluir un paso post-install: `git config --global user.name/email`.

---

## 4. Orden recomendado antes del push inicial

1. **M1 + M2** — pinear versión + checksum (superficie de supply-chain hacia quien clone).
2. **M3** — atribución Apache-2.0 de la fuente (licencia ya confirmada; solo falta texto + mención).
3. **M4** — ignores de Atuin en `.gitignore`/`.chezmoiignore`.
4. **L4** + ajustes de coherencia de docs (1–2 líneas cada uno).
5. Tras el push: verificar que GitHub secret scanning no reporta nada.

---

## Apéndice — Cobertura

Los 56 ficheros del repo fueron examinados: ambos `run_once_*.sh` completos, `README.md`, `LICENSE`, los 5 `docs/*.md`, `.gitignore`, `.chezmoiignore`, `private_dot_zshrc`, `private_dot_tmux.conf`, `private_dot_markdownlint.json`, todo `private_dot_termux/` y todo `private_dot_config/` (fastfetch, atuin, bottom, git, nvim incl. lua/plugins, oh-my-posh, tealdeer, yazi incl. flavor, htop, lazygit). Binarios (`private_font.ttf`, `private_readonly_preview.png`) inspeccionados mediante barridos de patrones. Verificaciones dinámicas ejecutadas en el dispositivo Termux del propio entorno.

*Este informe vive solo en el repositorio (excluido del despliegue de chezmoi vía `.chezmoiignore`).*
