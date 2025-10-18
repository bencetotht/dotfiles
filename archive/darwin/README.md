# Commands
## Install Nix:
```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

## Init:
```sh
nix flake init -t nix-darwin --extra-experimental-features "nix-command flakes"
```

## Build for the first time: 
```sh
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix#m1
```
## Validate:
```sh
which darwin-rebuild
```

## Rebuild:
```sh
darwin-rebuild swtich --flake ~/.config/nix#m1
```

## Upgrading packages:
```sh
nix flake update 
darwin-rebuild swtich --flake ~/.config/nix#m1
```