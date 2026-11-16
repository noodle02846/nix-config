_: {
  sops = {
    defaultSopsFile = ../../secrets/desktop/system.yaml;

    age = {
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = false;
      sshKeyPaths = [ ];
    };
  };
}
