{ stdenv, lib, fetchFromGitHub, pkgconfig, qt5, glib, libmad, libid3tag, taglib, libusb, libgcrypt }:
stdenv.mkDerivation rec {
  name = "linux-minidisc";

  src = fetchFromGitHub {
    owner = "linux-minidisc";
    repo = "linux-minidisc";
    fetchSubmodules = true;
    rev = "43a01190f819e44c5709017b889be9bf8766b989";
    sha256 = "1lhag5m94q7s1znbs53c9gapcydzcgl8zcjrbg8ry1m5i0a9qa8h";
  };

  nativeBuildInputs = [ pkgconfig qt5.qmake ];
  buildInputs = [
    glib libmad libid3tag taglib libusb libgcrypt
    qt5.full
  ];

  preConfigure = ''
    sed -i "s,/usr,$out," build/installunix.pri
    sed -i "s,/usr,$out," qhimdtransfer/qhimdtransfer.pro
  '';

  meta = with lib; {
    description = "Linux Minidisc tools";
    homepage = "https://wiki.physik.fu-berlin.de/linux-minidisc/";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}