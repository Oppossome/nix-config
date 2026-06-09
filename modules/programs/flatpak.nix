{ self, inputs, ... }: {
	flake.nixosModules.programsFlatpak = { pkgs, ... }: {
		imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
		services.flatpak = {
			enable = true;
			packages = [
				"com.github.tchx84.Flatseal"
			];
			update.auto = {
				enable = true;
				onCalendar = "weekly"; # Default value
			};
		};
	};
}