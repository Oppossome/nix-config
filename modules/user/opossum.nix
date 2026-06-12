{ self, inputs, ... }: {
	flake.nixosModules.userOpossum = { pkgs, ... }: {
		managedUsers = [ "opossum" ];
		
		users.users.opossum = {
			description = "Sera Cutler";
			extraGroups = [ "networkmanager" "wheel" "docker" ];
			isNormalUser = true;
		};

		home-manager.users.opossum = { pkgs, ... }: {
			home.username = "opossum";
			home.homeDirectory = "/home/opossum";
			home.stateVersion = "26.05";
		};
	};
}