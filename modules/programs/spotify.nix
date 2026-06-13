{ self, inputs, ... }: {
	flake.nixosModules.programsSpotify = { pkgs, ... }: {
		imports = [ self.nixosModules.programsFlatpak ];
		services.flatpak.packages = [
			"com.spotify.Client"
		];
		
		# Allow local device discovery.
		networking.firewall = {
			allowedTCPPorts = [ 57621 ];
			allowedUDPPorts = [ 5353 ];
		};
	};
}