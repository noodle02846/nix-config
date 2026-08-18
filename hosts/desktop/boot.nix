{ pkgs, ... }: {
  boot = {
    kernelParams = [
      "intel_idle.max_cstate=1" # Fix kernel panic issue from hardware defects
    ];

    kernelModules = [ ];
    kernelPackages = pkgs.linuxPackages_latest;

    kexec.enable = false;

    consoleLogLevel = 3;

    kernel.sysctl = {
      # kernel
      "kernel.sysrq" = 4;
      "kernel.kptr_restrict" = 2;
      "kernel.dmesg_restrict" = 1;

      # kernel.yama
      "kernel.yama.ptrace_scope" = 2;

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

      # vm
      "vm.mmap_rnd_bits" = 32;
      "vm.mmap_rnd_compat_bits" = 16;
    };

    plymouth = {
      enable = true;
      theme = "rings";

      themePackages = with pkgs; [
        adi1090x-plymouth-themes
      ];
    };

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };

      efi.canTouchEfiVariables = true;
    };
  };
}
