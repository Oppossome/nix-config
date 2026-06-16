{ self, inputs, ... }: {
	flake.nixosModules.programsMakerAnkerCtl = { pkgs, helpers, ... }:
	let
		printerIp = "192.168.0.113";

		tinyecPkg = pkgs.python3Packages.buildPythonPackage rec {
			pname = "tinyec";
			version = "0.4.0";
			pyproject = true;

			src = pkgs.fetchPypi {
				inherit pname version;
				hash = "sha256-sDZKqzua9jK2TyTq+uDI5WzGS0hFZIdSYQ9I8qsFR6M=";
			};

			build-system = [ pkgs.python3Packages.setuptools ];
		};

		ankerctlSrc = pkgs.fetchFromGitHub {
			owner = "anselor";
			repo = "ankermake-m5-protocol";
			rev = "88131a559fdd43105f16fb7d464e662b678cda19";
			hash = "sha256-ckxWNUgTAGa94v1lBabZrY44AHqJijf5nB5P4pdWp/Y=";
		};

		pythonEnv = pkgs.python3.withPackages (ps: [
			ps.paho-mqtt
			ps.pycryptodomex
			ps.rich
			ps.requests
			ps.click
			ps.platformdirs
			tinyecPkg
			ps.crcmod
			ps.tqdm
			ps.flask
			ps.flask-sock
			ps.user-agents
			ps.ifaddr
			ps.python-dotenv
		]);

		ankerctlPkg = pkgs.writeShellApplication {
			name = "ankerctl";
			runtimeInputs = [ pythonEnv ];
			text = ''
				python "${ankerctlSrc}/ankerctl.py" "$@"
			'';
		};
	in {
		home-manager.users = helpers.mapUsers (_: {
			home.packages = [ ankerctlPkg ];
		}) [ "maker" ];

		networking.firewall = {
			allowedUDPPorts = [ 32108 ];

			# Rules specific to my setup. 
			extraCommands = ''
				iptables -A nixos-fw -p udp -s ${printerIp} -j nixos-fw-accept
    			iptables -A nixos-fw -p udp -d 224.0.0.0/4 -j nixos-fw-accept
			'';
			extraStopCommands = ''
				iptables -D nixos-fw -p udp -s ${printerIp} -j nixos-fw-accept 2>/dev/null || true
				iptables -D nixos-fw -p udp -d 224.0.0.0/4 -j nixos-fw-accept 2>/dev/null || true
			'';
		};
	};
}