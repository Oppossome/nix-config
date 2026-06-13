{ self, inputs, ... }: {
	flake.nixosModules.userCommon = { lib, config, helpers, ... }: {
		imports = [ inputs.home-manager.nixosModules.home-manager ];

		options.managedUsers = lib.mkOption {
			type = lib.types.attrsOf (lib.types.listOf (lib.types.enum [ "gaming" "development" ]));
			description = "Managed users and their application kinds.";
			default = {};
		};

		config = {
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.sharedModules = [ 
				inputs.plasma-manager.homeModules.plasma-manager
				inputs.nix-flatpak.homeManagerModules.nix-flatpak
			];

			_module.args.helpers = {
				mapUsers =  callback: types:
					lib.genAttrs (lib.attrNames (
						lib.filterAttrs (_: kinds:
							types == [] || lib.any (type: lib.elem type kinds) types
						) config.managedUsers
					)) callback;
			};
		};
	};
}