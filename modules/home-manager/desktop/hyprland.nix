{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  wayland.windowManager.hyprland =
    let
      system = pkgs.stdenv.hostPlatform.system;

      makeModBind =
        {
          keybind,
          command,
          mouseOnly ? false,
        }:
        let
          luaInline = lib.generators.mkLuaInline;
        in
        {
          _args = [
            (luaInline ''mod .. " + ${keybind}"'')
            (luaInline "${command}")
            { mouse = mouseOnly; }
          ];
        };
    in
    {
      enable = true;

      # Use flake inputs
      package = inputs.hyprland.packages.${system}.hyprland;
      portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;

      # disabled due to UWSM
      systemd.enable = false;

      settings = {
        mod._var = "SUPER";
        terminal._var = "uwsm app -- foot";
        menu._var = "hyprlauncher";
        browser._var = "uwsm app -- chromium";

        monitor = [
          {
            output = "DP-1";
            mode = "1920x1080@144";
            position = "0x0";
            scale = "1";
          }
        ];

        bind = [
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + Escape"'')
              (lib.generators.mkLuaInline "hl.dsp.window.close()")
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + Q"'')
              (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + M"'')
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")'')
            ];
          }
          (makeModBind {
            keybind = "B";
            command = "hl.dsp.exec_cmd(browser)";
          })
          # drag/resize windows
          (makeModBind {
            keybind = "mouse:272";
            command = "hl.dsp.window.drag()";
            mouseOnly = true;
          })
          (makeModBind {
            keybind = "mouse:273";
            command = "hl.dsp.window.resize()";
            mouseOnly = true;
          })
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              (makeModBind {
                keybind = "${toString ws}";
                command = "hl.dsp.focus({ workspace = ${toString ws} })";
              })
              (makeModBind {
                keybind = "SHIFT + ${toString ws}";
                command = "hl.dsp.window.move({ workspace = ${toString ws} })";
              })
              (makeModBind {
                keybind = "plus";
                command = "hl.dsp.focus({ workspace = 'e+1' })";
                mouseOnly = true;
              })
              (makeModBind {
                keybind = "minus";
                command = "hl.dsp.focus({ workspace = 'e-1' })";
                mouseOnly = true;
              })
            ]
          ) 9
        ));

        curve = [
          {
            _args = [
              "easeOutQuint"
              (lib.generators.mkLuaInline ''
                { type = "bezier"; points = { { 0.23, 1 }, { 0.32, 1 } } }
              '')
            ];
          }
          {
            _args = [
              "easeInOutCubic"
              (lib.generators.mkLuaInline ''
                { type = "bezier"; points = { { 0.65, 0.05 }, { 0.36, 1 } } }
              '')
            ];
          }
          {
            _args = [
              "linear"
              (lib.generators.mkLuaInline ''
                { type = "bezier"; points = { { 0, 0 }, { 1, 1 } } }
              '')
            ];
          }
          {
            _args = [
              "almostLinear"
              (lib.generators.mkLuaInline ''
                { type = "bezier"; points = { { 0.5, 0.5 }, { 0.75, 1 } } }
              '')
            ];
          }
          {
            _args = [
              "quick"
              (lib.generators.mkLuaInline ''
                { type = "bezier"; points = { { 0.15, 0 }, { 0.1, 1 } } }
              '')
            ];
          }
          {
            _args = [
              "quick"
              (lib.generators.mkLuaInline ''
                { type = "spring"; mass = 1; stiffness = 71.2633; dampening = 15.8273644; }
              '')
            ];
          }
        ];

        config = {
          animations.enabled = true;

          general = {
            gaps_in = 3;
            gaps_out = 5;

            border_size = 1;

            col = {
              active_border = {
                colors = [
                  "rgba(708090ee)"
                  "rgba(7788aaee)"
                ];
                angle = 45;
              };
              inactive_border = "rgba(191919ee)";
            };

            resize_on_border = false;
            allow_tearing = false;

            layout = "dwindle";
          };

          input = {
            kb_layout = "us";
            kb_variant = "";
            kb_model = "";
            kb_options = "";
            kb_rules = "";

            follow_mouse = 1;
            sensitivity = 0;

            touchpad.natural_scroll = false;
          };

          dwindle.preserve_split = true;
          master.new_status = "master";
          scrolling.fullscreen_on_one_column = true;

          misc = {
            force_default_wallpaper = 1;
            disable_hyprland_logo = true;
          };

          decoration = {
            rounding = 0;
            rounding_power = 2;

            active_opacity = 1;
            inactive_opacity = 1;

            shadow = {
              enabled = false;
              range = 16;
              render_power = 2;
              color = "rgba(08080888)";
            };

            blur = {
              enabled = false;
              size = 8;
              passes = 4;
              vibrancy = 0.5;
            };
          };
        };
      };
    };
}
