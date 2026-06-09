{ self, inputs, ... }: {
	flake.nixosModules.programsDevelopmentVSCode = { pkgs, ... }: {
		environment.systemPackages = with pkgs; [
			ghostty
			kdePackages.sddm-kcm # KDE SDDM Manager
			vscode
		];
	};
}