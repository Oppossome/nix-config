{ self, inputs, ... }: {
	flake.nixosModules.programsDevelopmentDocker = { pkgs, ... }: {
		virtualisation.docker = {
			# Consider disabling the system wide Docker daemon
			enable = false;

			rootless = {
				enable = true;
				setSocketVariable = true;
			};
		};
	};
}