{ ... }: {
  services.ntpd-rs = {
    enable = true;
    useNetworkingTimeServers = false;

    settings = {
      synchronization.minimum-agreeing-sources = 3;

      source = [
        # Stockholm: netnod.se
        {
          mode = "nts";
          address = "sth1.nts.netnod.se";
        }
        {
          mode = "nts";
          address = "sth2.nts.netnod.se";
        }

        # NOTE: Separate energy infrastructure & IX points and
        #       large geographical distance with near denmark stability
        # Malmo: netnod.se
        {
          mode = "nts";
          address = "mmo1.nts.netnod.se";
        }
        {
          mode = "nts";
          address = "mmo2.nts.netnod.se";
        }

        # NOTE: Mostly fallback servers and reliable agreeing sources below

        # Braunschweig: ptb.de
        {
          mode = "nts";
          address = "ptbtime1.ptb.de";
        }
        {
          mode = "nts";
          address = "ptbtime2.ptb.de";
        }
        {
          mode = "server";
          address = "192.53.103.108";
        }
        {
          mode = "server";
          address = "192.53.103.104";
        }

        # Netherlands: time.nl
        {
          mode = "nts-pool";
          address = "ntspool.time.nl";
          ntp-version = "auto";
        }
      ];
    };
  };
}
