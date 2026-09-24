{ self, inputs, ... }: {
	flake.nixosModules.programsVLC = { pkgs, ... }: {
		environment.systemPackages = with pkgs; [
			vlc
		];
	};
}