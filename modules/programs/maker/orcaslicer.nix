{ self, inputs, ... }: {
	flake.nixosModules.programsMakerOrcaSlicer = { pkgs, helpers, ... }: {
		home-manager.users = helpers.mapUsers (_: {
			services.flatpak.packages = [ "com.orcaslicer.OrcaSlicer" ];
		}) ["maker"];
	};
}