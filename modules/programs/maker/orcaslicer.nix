{ self, inputs, ... }: {
	flake.nixosModules.programsMakerOrcaSlicer = { pkgs, helpers, ... }: {
		home-manager.users = helpers.mapUsers (_: {
			home.packages = with pkgs; [ orca-slicer ];
		}) ["maker"];
	};
}