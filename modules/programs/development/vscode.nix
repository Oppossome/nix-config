{ self, inputs, ... }: {
	flake.nixosModules.programsDevelopmentVSCode = { pkgs, ... }: {
		environment.systemPackages = with pkgs; [
			vscode
		];
	};
}