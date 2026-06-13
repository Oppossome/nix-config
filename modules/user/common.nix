{ self, inputs, ... }: {
	flake.nixosModules.userCommon = { lib, config, helpers, ... }: {
		options.managedUsers = lib.mkOption {
			type = lib.types.attrsOf (lib.types.listOf (lib.types.enum [ "gaming" "development" ]));
			description = "Managed users and their application kinds.";
			default = {};
		};

		config = {
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