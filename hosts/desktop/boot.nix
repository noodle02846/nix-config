{ pkgs, ... }: {
  boot = {
    kernelParams = [
      "intel_idle.max_cstate=1" # Fix kernel panic issue from hardware defects

      # Silent boot
      "quiet"
      "udev.log_priority=3"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"

      # Plymouth boot theme fix
      "plymouth.use-simpledrm"
    ];

    kernelModules = [
      # Preload modules for Podman
      "veth"
      "bridge"
      "br_netfilter"

      # Preload modules for Netavark
      "nft_ct"
      "nft_nat"
      "nft_masq"
      "nft_fib_ipv4"
      "nft_fib_ipv6"
      "nft_chain_nat"

      # Preload tun module for Mullvad and Podman
      "tun"

      # Preload packet module for dhcpcd
      "af_packet"

      # Preload zram module for swap
      "zram"

      # Filesystems
      "ntfs3"
    ];

    kernelPackages = pkgs.linuxPackages_latest;

    kexec.enable = false;

    consoleLogLevel = 3;

    kernel.sysctl = {
      # kernel
      "kernel.sysrq" = 4;
      "kernel.kptr_restrict" = 2;
      "kernel.dmesg_restrict" = 1;

      # kernel.yama
      "kernel.yama.ptrace_scope" = 1;

      # net.ipv4
      # TODO: Review modern day security benefits and performance losses
      # "net.ipv4.tcp_sack" = 0;
      # "net.ipv4.tcp_dsack" = 0;
      # "net.ipv4.tcp_fack" = 0;

      "net.ipv4.tcp_syncookies" = 1;
      "net.ipv4.tcp_rfc1337" = 1;

      # net.ipv4.conf.*.send_redirects
      "net.ipv4.conf.*.send_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;

      # net.ipv4.conf.*.secure_redirects
      "net.ipv4.conf.*.secure_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;

      # net.ipv4.conf.*.accept_redirects
      "net.ipv4.conf.*.accept_redirects" = 0;
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;

      # net.ipv4.conf.*.rp_filter
      "net.ipv4.conf.*.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;

      # net.ipv4.conf.*.src_valid_mark
      # NOTE: Supposedly fixes mullvad daemon error
      "net.ipv4.conf.all.src_valid_mark" = 1;
      "net.ipv4.conf.default.src_valid_mark" = 1;

      # vm
      "vm.mmap_rnd_bits" = 32;
      "vm.mmap_rnd_compat_bits" = 16;
    };

    plymouth =
      let
        ecorpGlitch = pkgs.stdenvNoCC.mkDerivation {
          pname = "plymouth-theme-ecorp-glitch";
          version = "0-unstable-2026-08-14";

          src = pkgs.fetchFromGitHub {
            owner = "RuVl";
            repo = "plymouth-theme-ecorp-glitch-luks";
            rev = "62749e530fc74e9f6a199cbb551a49e2019a3f7b";
            hash = "sha256-ZU6fQwRvMC4OSWadoO23IOiKqqfSn7+WRH1q+IV2Z+w=";
          };

          dontBuild = true;
          dontConfigure = true;

          installPhase = ''
            runHook preInstall

            themeDir="$out/share/plymouth/themes/ecorp-glitch-luks"
            mkdir -p "$themeDir"

            # Copy only the theme itself, not README.md, demo.gif or install.sh.
            cp "$src"/{*.png,*.script,*.plymouth} "$themeDir/"

            substituteInPlace "$themeDir/ecorp-glitch-luks.plymouth" \
              --replace-fail \
                "/usr/share/plymouth/themes/ecorp-glitch-luks" \
                "$themeDir"

            runHook postInstall
          '';
        };
      in
      {
        enable = true;

        theme = "ecorp-glitch-luks";
        themePackages = [ ecorpGlitch ];

        showDelay = 0;

        extraConfig = ''
          UseSimpledrm=1
        '';
      };

    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 10;

        bootCounting.enable = true;
      };

      timeout = 0;
      efi.canTouchEfiVariables = true;
    };
  };
}
