{ self, inputs, ... }: {
	flake.nixosModules.programsMochi = { pkgs, ... }: {
		environment.systemPackages = with pkgs; [
			mochi
		];
	};
}