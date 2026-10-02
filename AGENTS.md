# AGENTS.md

## 1. Project Description

This is a NixOS + home-manager configuration repository. It manages system (nixos)
configuration, per-user home-manager configuration, and reusable configuration
modules, plus supporting dotfiles and assets.

## 2. Guardrails

* **NEVER** run any command, script, build, or test that targets this repository or its
  files (e.g. `nix build`, `nh switch`, `nh home switch`, `nix flake check`, `just …`)
  without explicit, specific permission for that exact action.
* **ALWAYS** follow the project structure below and reuse existing modules instead of
  duplicating configuration. For any new host, user, or module, follow the existing
  split; propose structural changes to the operator before applying.
* **NEVER** write, commit, log, or expose secrets, keys, tokens, or credentials in the
  repo — keep them external (e.g. `secrets.nix`, a passphrase store, or an out-of-repo path).

## 3. Project Architecture

### Root

* `flake.nix` - Top-level flake (uses `flake-parts`). Defines the `desktop` nixos
  configuration and the `user` home-manager configuration.
* `flake.lock` - Auto-generated lockfile.
* `justfile` - Convenience commands: `update`, `check`, `home` (`nh home switch`),
  `switch` (`nh os switch`).
* `.envrc` - direnv setup (`use flake`).
* `LICENSE` - Repository license.
* `config/` - Empty, currently unused (reserved).
* `assets/` - Dotfiles and other assets.

### `hosts/` - System host configurations

* `hosts/desktop/` - The `desktop` host. `default.nix` is the entry point and uses
  `imports = []` to assemble per-topic files (`boot`, `console`, `environment`,
  `hardware`, `networking`, `security`, `time`, `users`) plus module imports from
  `modules/`.

### `modules/` - Reusable configuration modules & units

Split by target:

* `modules/nixos/` - System (nixos) modules: `desktop/`, `programs/`, `services/`.
* `modules/home-manager/` - Home-manager modules: `containers/`, `desktop/`,
  `programs/`, `services/`, plus top-level `fonts.nix`.

> Reusable modules must never contain a `default.nix` file or be made auto-importable
> via `imports = []`. They must not import other files, except an "input module" that
> must import its own required dependency inputs to function.

### `users/` - Per-user configurations

* `users/svc/` - The `svc` system/service user (home-manager, drives `podman`/`gonic`).
  Referenced by the flake as `users.svc`.
* `users/user/` - The primary `user` home-manager config (`default.nix`, `xdg.nix`).
  Referenced by the flake as the `user` home configuration.
