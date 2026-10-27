{ self, inputs, ... }: {
    flake.nixosModules.programsDevelopmentOri = { pkgs, ... }: let
        ori = pkgs.stdenv.mkDerivation rec {
            pname = "ori";
            version = "0.16.0";
            src = pkgs.fetchurl {
                url = "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-${version}-a55b08b/ori-linux-x64";
                hash = "sha256-Y2RLpdrNEuTQF0R4RXsfyi/9qY6QJ3O3hCmH/5L5Zyw=";
            };
            dontUnpack = true;
            dontStrip = true; # would corrupt the appended payload
            nativeBuildInputs = [ pkgs.autoPatchelfHook ];
            buildInputs = [ pkgs.stdenv.cc.cc.lib ];
            installPhase = ''
                install -Dm755 $src $out/bin/ori
            '';
            meta.mainProgram = "ori";
        };
    in {
        environment.systemPackages = [ 
			pkgs.claude-code
			ori
		];
    };
}
