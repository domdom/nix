with import <nixpkgs> {};
with pkgs;
with stdenv;
if isDarwin then
  "darwin"
else if isLinux then
  "linux"
else
  "base"
