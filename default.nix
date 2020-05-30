self: super: 
{
	consulmux = super.callPackage ./consulmux {};
	
	inherit (super.callPackage ./uboot.nix {})
		ubootRaspberryPi3_32bit
		ubootRaspberryPi4_64bit; 
}
