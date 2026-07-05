{ self, inputs, ... }: {
	flake.nixosModules.programsGamingMinecraft = { pkgs, helpers, ... }: {
		home-manager.users = helpers.mapUsers (_: {
			home.packages = with pkgs; [ prismlauncher ];
		}) ["gaming"];
	};
}