# rileycat nixos configuration

A (relatively) simple flake-based nixos configuration for all of the hosts I've moved to be nix-based in my home lab.

This configuration has three design goals:

* files such as `home.nix` and `conf.nix` should be *completely vanilla* home manager and nixos configurations (respectively)
* flake logic should reside entirely in `default.nix`es and not bleed into other pieces of nix code
* the above two stipulations should not prevent usage from all the usual flake shenanigans (mixing stable and unstable, building nightly packages, overlays,  etc.)

As such, the way to read this repository, as with any flake-based configuration, is to start with `flake.nix`. This file mostly just imports other `default.nix`es.

*However*, it is equally valid to start with a host's `conf.nix` or a user's `home.nix`, letting the `default.nix` files acting merely as "glue".
Because the modules are vanilla, additional arguments are expressly forbidden. No additional information is required to grok.

## A note on flake parts

This repository uses [flake parts](https://flake.parts/). This is an alternative to the ubiquitious [flake utils](https://github.com/numtide/flake-utils).
Sufficient justification can be found in this [blog post on the subject](https://ayats.org/blog/no-flake-utils#user-content-fn-3), but for the purposes of this repo,
it enables splitting part flakes more easily (something I find desireable owing to their inherent complexity).

## Structure

* `/hosts/*.nix` - nixos modules
* `/users/*.nix` - home manager modules
* `/*/*/default.nix` - flake part modules
* `/hosts/*/{conf,hardware}.nix` - configuration for a specific host (resembling a fresh nix install)
* `/users/*/{home}.nix` - configuration for a specific user (resembling a fresh hm install)

A new user creates a folder with their `home.nix` in a self-named folder. A sister `default.nix` part must then be created to import that file and  to add it to the flake.

A new host creates a folder with their `conf.nix` and `hardware.nix`. A sister `default.nix` part must then be created to import that file, all relevant nixos modules, and add it to the flake.

## Home manager

There are [several ways to install](https://nix-community.github.io/home-manager/index.xhtml#ch-installation) and use home manager. This configuration uses home manager as part of the nixos configuration.

This means everything is handled by `nixos-rebuild switch`. I do not change the programs I use often enough that a standalone installation saves me meaningful time. Adjust to taste.
