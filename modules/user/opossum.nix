{ self, inputs, ... }: {
	flake.nixosModules.userOpossum = { pkgs, ... }: {
		managedUsers = { opossum = [ "development" "gaming" "maker" ]; };
		
		users.users.opossum = {
			description = "Sera";
			extraGroups = [ "networkmanager" "wheel" ];
			isNormalUser = true;
		};

		home-manager.users.opossum = { pkgs, ... }: {
			home.username = "opossum";
			home.homeDirectory = "/home/opossum";
			home.stateVersion = "26.05";
		};
	};
}
