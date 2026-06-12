{ self, inputs, ... }: {
	flake.nixosConfigurations.hostDesktop = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			self.nixosModules.hostDesktopModule
			self.nixosModules.desktopPlasma
			self.nixosModules.shellZsh
			self.nixosModules.userCommon
			self.nixosModules.userOpossum
		] ++ builtins.attrValues (
			inputs.nixpkgs.lib.filterAttrs (name: _: builtins.match "programs.*" name != null) self.nixosModules
		);
	};

	flake.nixosModules.hostDesktopModule = { pkgs, ... }: {
		imports = [
			self.nixosModules.hostCommon
			self.nixosModules.hostDesktopHardware
		];

		boot.loader.grub.enable = true;
		boot.loader.grub.device = "/dev/sda";
		boot.loader.grub.useOSProber = true;
		boot.kernelPackages = pkgs.linuxPackages_latest;

		# Networking and hardware.
		networking.hostName = "desktop";
		networking.networkmanager.enable = true;
		hardware.bluetooth.enable = true;

		# This value determines the NixOS release from which the default
		# settings for stateful data, like file locations and database versions
		# on your system were taken. It's perfectly fine and recommended to leave
		# this value at the release version of the first install of this system.
		# Before changing this value read the documentation for this option
		# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
		system.stateVersion = "26.05"; # Did you read the comment?
	};
}
