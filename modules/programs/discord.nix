{ self, inputs, ... }: {
	flake.nixosModules.programsDiscord = { pkgs, ... }: {
		environment.systemPackages = with pkgs; [
    		vesktop
		];
	};
}