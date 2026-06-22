{ self, inputs, ... }: {
	flake.nixosModules.programsVideoTrimmer = { pkgs, ... }: {
		environment.systemPackages =  with pkgs; [
			video-trimmer
		];
	};
}