{ pkgs, fetchFromGitHub }:
let 
  python = import ./requirements.nix { inherit pkgs; };
in python.mkDerivation rec {
  name = "airprom";
  src = fetchFromGitHub {
  	owner = "erincandescent";
  	repo = "airprom";
  	rev = "4b4e5e502363036afd4686ca5f695a556496e54d";
  	sha256 = "0sj82qccf2ll99wqckxncv10nb00jjn7s919ccm89gzzigasaln2";
  };

  propagatedBuildInputs = [ 
    python.packages.py-air-control
    python.packages.pycryptodomex
    python.packages.coapthon3
  ];
  buildInputs = [];
}