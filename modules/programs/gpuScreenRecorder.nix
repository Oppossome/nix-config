{ self, inputs, ... }: {
	flake.nixosModules.programsGPUScreenRecorder = { pkgs, ... }: {
		programs.gpu-screen-recorder.enable = true;
		environment.systemPackages = with pkgs; [
			gpu-screen-recorder-gtk
		];
	};
}