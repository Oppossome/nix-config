{ self, inputs, ... }: {
	flake.nixosModules.programsSimpleScreenRecorder = { pkgs, helpers, lib, ... }: {
		environment.systemPackages = [
			pkgs.simplescreenrecorder
		];
	};
}