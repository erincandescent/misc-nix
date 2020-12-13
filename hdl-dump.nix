{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  name = "hdl-dump";
  src = fetchFromGitHub {
  	owner = "AKuHAK";
  	repo = "hdl-dump";
  	rev = "be37e112a44772a1341c867dc3dfee7381ce9e59";
  	sha256 = "0akxak6hm11h8z6jczxgr795s4a8czspwnhl3swqxp803dvjdx41";
  };

  installPhase = ''
    mkdir -p $out/bin
    install hdl_dump $out/bin
  '';
}