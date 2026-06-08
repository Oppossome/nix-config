{ self, inputs, ... }: {
	flake.nixosModules.userOpossum = { pkgs, ... }: {
		users.users."opossum" = {
			description = "Sera Cutler";
			extraGroups = [ "networkmanager" "wheel" "docker" ];
			isNormalUser = true;
		};
	};
}