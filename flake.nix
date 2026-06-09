{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-parts.url = "github:hercules-ci/flake-parts";
		import-tree.url = "github:denful/import-tree";
		
		nix-flatpak.url = "github:gmodena/nix-flatpak";
	};
	outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; }
	(inputs.import-tree ./modules);
}