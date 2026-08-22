{ self, inputs, ... }: {
	flake.nixosModules.programsGamingLutris = { pkgs, helpers, lib, ... }: {
		home-manager.users = helpers.mapUsers (_: {
			home.packages = with pkgs; [ lutris gamescope ];
		}) ["gaming"];
	};
}