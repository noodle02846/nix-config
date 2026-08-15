{ lib, ... }: {
  time.timeZone = "America/Chicago";

  # NOTE: Replaced with ntpd-rs for time syncing
  services.timesyncd.enable = lib.mkForce false;
}
