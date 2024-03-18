# schlunzis Nix Channel
This repository is a channel, which you can use to install our projects using nix.

## Usage
To add the channel run the following command.

``` bash
nix-channel --add https://github.com/schlunzis/nix-channel/archive/main.tar.gz schlunzis
```

### On NixOS:

You can use the channel either in `nix-shell` or in your configuration file.
#### Nix-Shell
TODO

#### Configuration File
Add the channel to your configuration by adding the following to your `configuration.nix`.

``` nix
schlunzpkgs = import <schlunzis> {};
```

and refer to the packages with `schlunzpkgs.package-name`. So you can install packages globally by adding this to your 
`configuration.nix` See the [packages](#packages) to see which packages are available.

``` nix
environment.systemPackages = [
  schlunzpkgs.package-name
];
```

### Not on NixOS
TODO

## Packages

### Kurtama Client
> Package name: `kurtama-client`

The client of the first implementation of the well known board game Kurtama.
