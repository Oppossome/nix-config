{ self, inputs, ... }: {
	flake.nixosModules.userOdoo = { pkgs, ... }: {
		managedUsers = { odoo = [ "development" ]; };
		
		users.users.odoo = {
			description = "Odoo";
			extraGroups = [ "networkmanager" "wheel" "docker" ];
			isNormalUser = true;
		};

		home-manager.users.odoo = { pkgs, ... }: {
			home.username = "odoo";
			home.homeDirectory = "/home/odoo";
			home.stateVersion = "26.05";
		};
	};
}