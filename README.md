[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)

# My NixOS configurations

Here's my NixOS/home-manager config files. Requires [Nix flakes](https://nixos.wiki/wiki/Flakes).

Looking for something simpler to start out with flakes? Try [this starter config repo](https://github.com/Misterio77/nix-starter-config).

## Structure

- `flake.nix`: Entrypoint for hosts and home configurations. Also exposes a
  devshell for boostrapping (`nix develop` or `nix-shell`).
- `hosts`: NixOS Configurations, accessible via `nixos-rebuild --flake`.
  - `common`: Shared configurations consumed by the machine-specific ones.
    - `global`: Configurations that are globally applied to all my machines.
    - `optional`: Opt-in configurations my machines can use.
  - `atlas`: (placeholder)
- `home`: My Home-manager configuration, acessible via `home-manager --flake`
    - Each directory here is a "feature" each hm configuration can toggle, thus
      customizing my setup for each machine (be it a server, desktop, laptop,
      anything really).
- `modules`: A few actual modules (with options).
- `overlay`: Patches and version overrides for some packages. Accessible via
  `nix build`.
- `pkgs`: My custom packages. Also accessible via `nix build`. You can compose
  these into your own configuration by using my flake's overlay, or consume them through NUR.
- `templates`: A couple project templates for different languages. Accessible
  via `nix init`.

## How to bootstrap

All you need is nix. Run:
```
nix develop
```

If you already use older nix version without `flakes` and
`nix-command` enabled, you can also use a legacy command:
```
nix-shell
```

Then:
```bash
# build system configurations
nixos-rebuild --flake .
nix build .#nixosConfigurations.rpi4.config.system.build.toplevel
nix build .#nixosConfigurations.rpi4.config.system.build.sdImage
#https://nixos.wiki/wiki/NixOS_on_ARM#Getting_the_installer
#https://nix.dev/tutorials/nixos/installing-nixos-on-a-raspberry-pi
#https://myme.no/posts/2022-12-01-nixos-on-raspberrypi.html
# do not forget to set crosscompile/qemu if building on other platform on host machine

# build and activate specific user configuration
home-manager --flake .#msekoranja@cslwsl switch

# build and use packages
nix build (or shell or run)
```

## Secrets

Currently secrets are not managed, intentionally. Passwords should not be used,
and public/private keys are easy to generate. Sharing the keys is better avoided,
since if shared key is compromised all the private keys (on all the hosts) needs
to be regenerated. If you use pair per host, then only the compromized key must be
regenerated.

To generate key pair use, e.g.
```bash
# for local machine
sh-keygen -t ed25519 -C $HOST

# for GitHub
sh-keygen -t ed25519 -C "GitHub" -f id_gh

```

To distribute machine keys easily use:
```bash
# to accept public SSH key
wormhole ssh invite

# to send public SSH key
wormhole ssh accept <code>
```

For future deployment secrets (e.g. API kets), the awesome [`sops-nix`](https://github.com/Mic92/sops-nix)
can be used.

## home-manager news issue

If you get

```bash
error: file 'home-manager/home-manager/build-news.nix' was not found in the Nix search path (add it using $NIX_PATH or -I)
```
error, rebuild again and if this does not help do:

```bash
home-manager news --flake .
```

to resolve it.