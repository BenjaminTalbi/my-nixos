{...}:

{
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
    };

    nix.optimise = {
        automatic = true;
        dates = [ "01:00" ];
    };
}