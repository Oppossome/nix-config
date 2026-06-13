{ self, inputs, ... }: {
	flake.nixosModules.programsGPUScreenRecorder = { pkgs, ... }: {
		services.flatpak.packages = [
			"com.dec05eba.gpu_screen_recorder"
		];
	};
}