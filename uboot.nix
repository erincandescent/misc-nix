{ fetchurl, buildUBoot }:
let 
	version = "2020.01";
	src =  fetchurl {
	    url = "ftp://ftp.denx.de/pub/u-boot/u-boot-${version}.tar.bz2";
	    sha256 = "1w9ml4jl15q6ixpdqzspxjnl7d3rgxd7f99ms1xv5c8869h3qida";
	};
	patches = [];
in
{
	ubootRaspberryPi3_32bit = buildUBoot {
		inherit version src patches;
		defconfig = "rpi_4_32b_defconfig";
		extraMeta.platforms = ["armv7l-linux"];
		filesToInstall = ["u-boot.bin"];
	};

	ubootRaspberryPi4_64bit = buildUBoot {
		inherit version src patches;
		defconfig = "rpi_4_defconfig";
		extraMeta.platforms = ["aarch64-linux"];
		filesToInstall = ["u-boot.bin"];
	};
}