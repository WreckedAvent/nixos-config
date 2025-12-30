# rileycat nixos configuration

All of the systems I've moved to nix live here.

## *for beginners*

#### Welcome! 

* You can read each system's `conf.nix` and `hardware.nix` and compare it to your own.
* If you have home manager installed, you can additionally look at `home.nix` files and do the same.
* If your configuration is flake-based *and* you are feeling ambitious, you can look at the respective `default.nix` files.
* You can ignore the rest of this readme.

## *layout*

#### Downwards is less opinionated.

* `flake.nix` - the *flake's* entry point.
  * The entire configuration with all imports and everything included. Not designed to be re-used.
  
* `**/*/default.nix` - a *flake parts'* entry point.
  * A smaller, more specialized part of the flake. Given the right inputs, these can be re-used.

* `**/*.flake-part.nix` - a *flake part*.
  * The smallest piece of a flake. Only requiring a few specific inputs, these are reusable. 

* `hosts/*.nix` - a *nixos module*.
  * Small chunks of code for nixos configurations. All namespaced to `rcat`. Import and re-use freely.

* `users/*.nix` - a *home manager module*.
  * Small chunks of code for home configurations. All namespaced to `rcat`. Import and re-use freely.

* `hosts/*/{conf, hardware}.nix` - a *vanilla nixos configuration*.
  * Designed to be drop-in replacements for `nixos-generate-config`. These should not rely on flake inputs.

* `users/*/home.nix` - a *vanilla home configuration*.
  * No tool generates these, but these should not rely on flake inputs.
