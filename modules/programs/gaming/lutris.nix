{ self, inputs, ... }: {
	flake.nixosModules.programsGamingLutris = { pkgs, helpers, lib, ... }: {
		home-manager.users = helpers.mapUsers (_: {
			services.flatpak.packages = [ "net.lutris.Lutris" ];
		}) ["gaming"];
	};
}