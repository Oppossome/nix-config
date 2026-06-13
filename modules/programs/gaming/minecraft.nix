{ self, inputs, ... }: {
	flake.nixosModules.programsGamingMinecraft = { pkgs, helpers, ... }: {
		imports = [ self.nixosModules.programsFlatpak ];
		home-manager.users = helpers.mapUsers (_: {
			services.flatpak.packages = [ "org.prismlauncher.PrismLauncher" ];
		}) ["gaming"];
	};
}