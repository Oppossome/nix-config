{ self, inputs, ... }: {
	flake.nixosModules.programsGamingSteam = { pkgs, ... }: {
		imports = [ self.nixosModules.programsFlatpak ];
		services.flatpak.packages = [
			"com.valvesoftware.Steam"
		];

		programs.steam.remotePlay.openFirewall = true;
		programs.steam.dedicatedServer.openFirewall = true;		
		programs.gamemode.enable = true;

		# Enable uinput kernel module (required for many controllers)
		hardware.uinput.enable = true;

		# Add udev rules for Steam input devices
		services.udev.packages = with pkgs; [
			steam-devices-udev-rules
		];
	};
}