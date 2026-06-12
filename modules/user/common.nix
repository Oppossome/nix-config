{ self, inputs, ... }: {
	flake.nixosModules.userCommon = { lib, config, ... }: {
		imports = [ inputs.home-manager.nixosModules.home-manager ];

		options.managedUsers = lib.mkOption {
			type = lib.types.listOf lib.types.str;
			default = [];
			description = "Usernames to apply home-manager and shared config to.";
		};

		config = {
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
		};
	};
}