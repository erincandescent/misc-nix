{ pkgs, fetchFromGitHub }:
let 
  python = import ./requirements.nix { inherit pkgs; };
in python.mkDerivation rec {
  name = "py-air-control";
  src = fetchFromGitHub {
  	owner = "rgerganov";
  	repo = "py-air-control";
  	rev = "33391591f317c2aa0f56d1aaa57ef3d203e9da55";
  	sha256 = "1m4qbcdcggd3rfh01xjlbl3rm8xs6yg4l57rh8b923nihjpfjkkd";
  };
  format = "setuptools";

  propagatedBuildInputs = [ 
  	python.packages.pycryptodomex
    python.packages.coapthon3
  ];
  buildInputs = [];
}