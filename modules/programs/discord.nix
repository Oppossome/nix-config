{ self, inputs, ... }: {
	flake.nixosModules.programsDiscord = { pkgs, helpers, lib, ... }: {
		nixpkgs.config.permittedInsecurePackages = [
			"pnpm-10.29.2"
		];
		
		environment.systemPackages = with pkgs; [
			vesktop
		];

		home-manager.users = helpers.mapUsers (_: {
			xdg.configFile."autostart/vesktop.desktop" = {
				force = true;
				text = lib.generators.toINI {} {
					"Desktop Entry" = {
						Type = "Application";
						Name = "Vesktop";
						Exec = "vesktop --start-minimized";
						Icon = "vesktop";
						Terminal = false;
						StartupNotify = false;
					};
				};
			};
		}) [];
	};
}