self: super: 
{
	consulmux = super.callPackage ./consulmux {};
	
	inherit (super.callPackage ./uboot.nix {})
		ubootRaspberryPi3_32bit
		ubootRaspberryPi4_64bit; 
	linux-minidisc = super.callPackage ./linux-minidisc {};
	py-air-control = super.callPackage ./py-air-control {};
	airprom        = super.callPackage ./airprom        {};
	hdl-dump       = super.callPackage ./hdl-dump.nix   {};
	nomad          = super.callPackage ./nomad          {};
}
