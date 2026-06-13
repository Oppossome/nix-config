{ self, inputs, ... }: {
	flake.nixosModules.programsFlatpak = { pkgs, helpers, ... }: {
		imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
		home-manager.sharedModules = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

		services.flatpak = {
			enable = true;
			packages = [
				"com.github.tchx84.Flatseal"
			];
			update.auto = {
				enable = true;
				onCalendar = "daily";
			};
		};

		home-manager.users = helpers.mapUsers (_: {
			services.flatpak = {
				enable = true;
				packages = [ "com.github.tchx84.Flatseal" ];
				update.auto = {
					enable = true;
					onCalendar = "daily";
				};
			};
		}) [];
	};
}