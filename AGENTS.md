# AGENTS.md

## 1. Project Description

This is a NixOS configuration repository for managing system configuration + home-manager configuration and needed dotfiles & assets.

## 2. Project Guardrails & AGENT Boundries

Rules defining the limits and constraints of AI AGENTs for this repository:
* **NEVER:** Execute or run any shell command or script located within or targeting this repository, unless given explicit and exact permission for the command by the human operator.
* **ASK:** Before attempting to run or execute any shell command or script targeting this repository or any files located within.
* **ALWAYS:** Make sure to the follow the project structure as closely as possible, within the given context of said structure. And always suggest to the human operator better or more architecturally bound file/folder/asset locations.
* **ALWAYS:** Leave testing and building commands to the user instead of the AGENT

## 3. Project Architecture

* `flake.nix` - The top flake for this project
* `flake.lock`- Automatically generated lockfile
* `hosts/` - Directory containing the system host configurations
    * `desktop/` - Named directory containing specific `desktop` configuration files
* `modules/` - Directory containing reusable configuration modules & units
    > NOTE: THESE MUST NEVER CONTAIN A `default.nix` FILE OR AUTOMATICALLY IMPORTABLE FORMAT THROUGH `imports = [];`
    * `nixos/` - Directory containing system specific modules
    * `home-manager/` - Directory containing home-manager specific modules
* `users/` - Directory containing home-manager user configurations
    * `user/` - Named directory containing specific `user` home-manager configuration files
