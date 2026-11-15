{ self, inputs, ... }: {
	flake.nixosModules.programsGamingSteam = { pkgs, helpers, lib, ... }: {
		home-manager.users = helpers.mapUsers (_: {
			xdg.configFile."autostart/com.valvesoftware.Steam.desktop" = {
				force = true;
				text = lib.generators.toINI {} {
					"Desktop Entry" = {
						Type = "Application";
						Name = "Steam";
						Exec = "steam -silent";
						Icon = "steam";
						Terminal = false;
						StartupNotify = true;
						X-GNOME-Autostart-enabled = true;
					};
				};
			};
		}) ["gaming"];

		users.users = helpers.mapUsers (_: {
			extraGroups = [ "gamemode" ];
		}) ["gaming"];

		hardware.steam-hardware.enable = true;

		programs.gamemode = {
			enable = true;
			settings.general.renice = 10;
		};
		programs.gamescope.enable = true;
		programs.steam = {
			enable = true;
			extraCompatPackages = with pkgs; [ proton-ge-bin ];
			remotePlay.openFirewall = true;
		};
		
		boot.kernelModules = [ "ntsync" ];
		services.udev.extraRules = ''KERNEL=="ntsync", MODE="0666"'';
	};
}
