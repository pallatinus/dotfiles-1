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

## partitioning

you can already figure this out from the device-specific configuration files, but here is an
easier-to-understand breakdown of how the individual devices are partitioned, along with
justification of various design choices and documentation of how things were done

### owo

owo---my pi3---currently has a partition layout that looks a little like this (on a 32gb sdcard)

| partition | filesystem | size      | purpose                                                  |
| --------- | ---------- | --------- | -------------------------------------------------------- |
| 0         | fat32      | 30m       | boot partition containing u-boot for the pi's bootloader |
| 1         | swap       | 4gb       | to allow for system rebuilds to be done on-device        |
| 2         | ext4       | remainder | root partition                                           |

i've found throughout my usage of nixos on it that swap space is **very** necessary, due to the
lack of sufficient ram to complete system upgrades without any

i feel that it's also necessary to note that this was not installed using the official sdcard
image, it was instead generated using a tweaked configuration (not in this repository, but the only
change was enabling root login in sshd, iirc) and [this
tool](https://github.com/nix-community/nixos-generators)

### uwu

uwu---my thinkpad t440p---has a partition layout lacking any swap whatsoever

| partition | filesystem | size      | purpose                 |
| --------- | ---------- | --------- | ----------------------- |
| 0         | fat32      | 500m      | efi system partition    |
| 1         | luks2      | remainder | partial disk encryption |
| 1.0       | ext4       | remainder | root partition          |

keep in mind that this is on a 500gb samsung ssd. that, along with the fact that i already have
16gb of ram, is why there is no swap partition

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

