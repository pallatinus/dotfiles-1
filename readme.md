# dotfiles

my dotfiles <3

## layout

- modules/ - configuration "modules"---groups of nixpkgs modules that are independent of one
another and as such, can be mixed and matched freely
	- categories/ - abstract groups of system configuration that isn't specific to any
	device
	- devices/ - system configuration used on specific hosts
	- hardware/ - system configuration related to specific configurations of hardware
	- users/ - configuration for specific user accounts

## todo

there are more goals i have listed elsewhere, but here are some big ones that i'm okay sharing

### harden the system

a good place to start would be
[here](https://madaidans-insecurities.github.io/guides/linux-hardening.html). ideally, anything
done shouldn't affect performance too much

### repartition and do tmpfs on root

one place to start looking at is [this
repository](https://github.com/nix-community/impermanence), however, an actual implementation of it
would likely **not** use this module, as i can get more flexibility handling the persistence of it
myself. after implementing persistence, i should also consider switching to zfs and having `/nix/store` or
the entirety of `/nix` stored in a compressed zpool (with zstd.)

### declarative secret configuration

ideally, everything would be configured through nix, but some things (mainly user account
passwords) have been neglected, mostly due to the problems inherent with storing any kind of secret
online. however, i feel that there is a way i could do this without exposing them in this git
repository

### fix the installer

currently, it is impossible to directly install the system from the installer iso, mainly due to
the lack of full flake support in the `nixos-install` command. find a way to circumvent this
problem, likely through supplanting the inbuilt installer with a custom one that handles flakes
correctly. a complete installer would also handle partitioning, to save even more time

