{ lib, stdenv, ... }:

{
  imports = [ ]
  ++ lib.optionals stdenv.isLinux [ machines/linux.nix ]
  ++ lib.optionals stdenv.isDarwin [ machines/darwin.nix ];
}
