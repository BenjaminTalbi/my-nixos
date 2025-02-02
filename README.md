# My NixOS configs

A few bullet points:
- uses [home-manager standalone with flakes](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone)
- 

## Frija (WSL)
See the README inside the hosts/frija folder for caveats and installation instructions.


## Rebuild home-manager
```sh
home-manager switch --flake [PATH TO FLAKE.NIX]
```

## First time build
### WSL
```sh
nix-shell -p git 
sudo nixos-rebuild boot --flake /etc/nixos#frija
```
- Follow the frija folders README to complete

### Non-WSL
Clone the repo
```sh
nix-shell -p git --command "git clone https://github.com/BenjaminTalbi/nixos-configurations.git nixos-dots"
```
Generate hardware config
```sh
sudo nixos-generate-config --show-hardware-config > hosts/YOUR_HOST/hardware-configuration.nix
```
```sh
cd nixos-dots
sudo nixos-rebuild switch --flake .#[HOSTNAME]
```
- This will change your username and hostname

## Symlink /etc/nixos
```sh
cd /etc
sudo mv /etc/nixos{,.old}
sudo ln -s /home/[username]/nixos-configurations nixos
```
# my-nixos
