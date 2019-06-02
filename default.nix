self: super: 
{
    consulmux = super.callPackage ./consulmux {};

    import ./modules/services/consul.nix
}
