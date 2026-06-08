{ self, inputs, ... }: {
	flake.nixosModules.hostCommon = { pkgs, ... }: {
		# Locale and time
		i18n.defaultLocale = "en_US.UTF-8";
		i18n.extraLocaleSettings = {
			LC_ADDRESS = "en_US.UTF-8";
			LC_IDENTIFICATION = "en_US.UTF-8";
			LC_MEASUREMENT = "en_US.UTF-8";
			LC_MONETARY = "en_US.UTF-8";
			LC_NAME = "en_US.UTF-8";
			LC_NUMERIC = "en_US.UTF-8";
			LC_PAPER = "en_US.UTF-8";
			LC_TELEPHONE = "en_US.UTF-8";
			LC_TIME = "en_US.UTF-8";
		};
		time.timeZone = "America/New_York";

		# Nix configuration
		nix.settings.experimental-features = [ "nix-command" "flakes" ];
		nixpkgs.config.allowUnfree = true;

		# Nix maintenance and updates
		system.autoUpgrade = {
			enable = true;
			flake = "/etc/nixos";
			flags = [ "--print-build-logs" "--commit-lock-file" ];
			dates = "02:00";
			randomizedDelaySec = "45min";
		};

		programs.nh = {
			enable = true;
			clean.enable = true;
			clean.extraArgs = "--keep-since 7d --keep 3";
			flake = "/etc/nixos"; # sets NH_OS_FLAKE variable for you
		};

		# Services
		services.flatpak.enable = true;
		services.printing.enable = true;
	};
}