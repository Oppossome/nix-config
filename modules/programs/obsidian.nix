{ self, inputs, ... }: {
	flake.nixosModules.programsObsidian = { pkgs, ... }: {
		environment.systemPackages = with pkgs; [
			obsidian
		];
	};
}