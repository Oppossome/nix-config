{ self, inputs, ... }: {
	flake.nixosModules.programsGamingSteam = { pkgs, helpers, lib, ... }: {
		home-manager.users = helpers.mapUsers (_: {
			services.flatpak.packages = [ "com.valvesoftware.Steam" ];

			xdg.configFile."autostart/com.valvesoftware.Steam.desktop" = {
				force = true;
				text = lib.generators.toINI {} {
					"Desktop Entry" = {
						Type = "Application";
						Name = "Steam";
						Exec = "flatpak run --command=steam com.valvesoftware.Steam -silent";
						Icon = "com.valvesoftware.Steam";
						Terminal = false;
						StartupNotify = true;
						X-Flatpak = "com.valvesoftware.Steam";
						X-GNOME-Autostart-enabled = true;
					};
				};
			};
		}) ["gaming"];

		programs.steam.remotePlay.openFirewall = true;
		programs.gamemode.enable = true;

		# Enable uinput kernel module (required for many controllers)
		hardware.uinput.enable = true;

		# Add udev rules for Steam input devices
		services.udev.packages = with pkgs; [
			steam-devices-udev-rules
		];
	};
}