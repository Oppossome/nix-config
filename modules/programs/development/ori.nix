{ self, inputs, ... }: {
    flake.nixosModules.programsDevelopmentOri = { pkgs, ... }: let
        ori = pkgs.stdenv.mkDerivation rec {
            pname = "ori";
            version = "0.15.7";
            src = pkgs.fetchurl {
                url = "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-${version}-d702b99/ori-linux-x64";
                hash = "sha256-HnveiW6CMwHTIa5bIArL8Ba12i4fn2L+7uTXuEkjkXs=";
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
