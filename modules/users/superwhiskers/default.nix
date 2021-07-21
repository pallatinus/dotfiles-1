# default.nix - system configuration of the superwhiskers account
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

{ utils, ... }:
utils.lib.createUser {
  username = "superwhiskers";
  extraUserConfiguration = { pkgs, ... }: {
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYr+N1FPSqWiVZudCa1rok6x2ifpEy8yqkdTuB2iLJexwU3NmhsqStpj1EAwltt3WEtesSliw8mrE9nQZD2BipKNZh3iPTKlg6wFyhy+ptnGftDBShTd5dfK+Mwehx7KK9+K5lYD0Nv8RJIltPMHBU6vAEtU+borx8QMBq2JTPWEBhoqJd44EmhaaRRfMbuOrEkish79rnQs4MKVF9YZqMOJOioJeN0W0C1npYddMLUP+tKZOfYYWIQuE+Y8lfpqTG7lSRK6EYWkM5JeP0gRTsET3RojXgbs81kkUKrRBHsvjHZyxsEoxIA1BqFmz+GrOJhreBheYV1rrdB8ohC4+eb+NuGp2cbYuYcxKVxsqZqAz1qcgSs3iBuMTQoiKQPbA1NPEzAqzTe8tfNiahM04FLlogyerrjkyU7HNZa6r+bnEf+tu32F08v3/4SZwf3kbgXXt9ot5U91b1PGXdmSSd33zIWo0Dh3/9+RJ2uuJX+w8im21mXegZHUKYIA1kRmDE1fWOKD6oHAX1zUmqzAqrYKZ/AxB+xQSFrCn0/CYMig0Ddix0LtJ1D4F8p8SPQGq78u+1q/uVQQJVYGhIjf20h2gdsDhUWAhJhVwm26VfEr8O02BskW2hkA6le7xJH8/cG6wB7N2a66zeoPZcW/5PDYtzYp19WCftB8z35lXUpQ== superwhiskers@uwu"
    ];
  };
  modules = {
    directories = ./directories.nix;
    graphical = ./graphical.nix;
    shell = ./shell.nix;
    multimedia = ./multimedia.nix;
    packages = ./packages.nix;
    neovim = ./neovim.nix;
    gnome = ./gnome.nix;
    nyxt = ./nyxt.nix;
    headless = ./headless.nix;
  };
}
