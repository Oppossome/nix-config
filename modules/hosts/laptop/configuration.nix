{ self, inputs, ... }: {
	flake.nixosConfigurations.hostsLaptop = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			self.nixosModules.hostsLaptopModule
			self.nixosModules.userCommon
			self.nixosModules.userOpossum
			self.nixosModules.userOdoo
			
			self.nixosModules.desktopPlasma
			self.nixosModules.shellZsh
		] ++ builtins.attrValues (
			inputs.nixpkgs.lib.filterAttrs (name: _: builtins.match "programs.*" name != null) self.nixosModules
		);
	};

	flake.nixosModules.hostsLaptopModule = { pkgs, ... }: {
		imports = [
			self.nixosModules.hostsCommon
			self.nixosModules.hostsLaptopHardware
		];

		# Boot
		boot.kernelPackages = pkgs.linuxPackages_latest;
		boot.loader.efi.canTouchEfiVariables = true;
		boot.loader.limine = {
			enable = true;
			efiSupport = true;
		};

		# Packages
		environment.systemPackages = [ 
			pkgs.solaar
			(pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
				[General]
				background = "/etc/nixos/modules/hosts/laptop/wallpaper.png"
			'')
		];

		# Hardware
		hardware.bluetooth.enable = true;

		# Networking
		networking.hostName = "laptop";
		networking.networkmanager = {
			enable = true;
			plugins = with pkgs; [ networkmanager-openvpn ];
			wifi.powersave = true;
		};

		# Services
		services.fprintd.enable = true;
		services.fwupd.enable = true;
		services.power-profiles-daemon.enable = true;

		# This value determines the NixOS release from which the default
		# settings for stateful data, like file locations and database versions
		# on your system were taken. It's perfectly fine and recommended to leave
		# this value at the release version of the first install of this system.
		# Before changing this value read the documentation for this option
		# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
		system.stateVersion = "26.05"; # Did you read the comment?
	};
}
