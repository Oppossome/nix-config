{ self, inputs, ... }: {
	flake.nixosModules.hostsCommon = { pkgs, config, ... }: {
		imports = [ inputs.home-manager.nixosModules.home-manager ];

		# Home Manager
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];

		# Enable NUR from flake input (pure and pinned by flake.lock)
		nixpkgs.overlays = [ inputs.nur.overlays.default ];

		# Locale and time
		i18n.defaultLocale = "en_US.UTF-8";
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

		# Keep nixos config tree writable for wheel users
		system.activationScripts.nixosWheelOwnership.text = ''
			chgrp -R wheel /etc/nixos
		'';

		# Services
		services.printing.enable = true;
	};
}