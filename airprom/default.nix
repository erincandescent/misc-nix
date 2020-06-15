{ pkgs, fetchFromGitHub }:
let 
  python = import ./requirements.nix { inherit pkgs; };
in python.mkDerivation rec {
  name = "airprom";
  src = fetchFromGitHub {
  	owner = "erincandescent";
  	repo = "airprom";
  	rev = "822f57da7d804453479acbe6b0f9aa5abf2aeb97";
  	sha256 = "1gfvc5v72xzr2vyyi5p99848bgi3b8rk32iykilkz6gyr0iihkah";
  };

  propagatedBuildInputs = [ 
    python.packages.py-air-control
    python.packages.pycryptodomex
    python.packages.coapthon3
    python.packages.flask
    python.packages.prometheus-client
  ];
  buildInputs = [];
}