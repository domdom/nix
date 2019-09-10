{stdenv, fetchurl, perl, zlib, makeWrapper }:

let ccache = stdenv.mkDerivation rec {
  name = "ccache-${version}";
  version = "3.7.1";

  src = fetchurl {
    sha256 = "010fcg45saxnh5frrdl2i3c47d3rlxs6j0q4cfakpzglzilyrlkk";
    url = "https://github.com/ccache/ccache/releases/download/v3.7.3/ccache-3.7.3.tar.xz";
  };

  nativeBuildInputs = [ perl ];

  buildInputs = [ zlib ];

  outputs = [ "out" "man" ];

  # non to be fail on filesystems with unconventional blocksizes (zfs on Hydra?)
  patches = [
    #./fix-debug-prefix-map-suite.patch
    #./skip-fs-dependent-test.patch
  ];

  postPatch = ''
    substituteInPlace Makefile.in --replace 'objs) $(extra_libs)' 'objs)'
  '';

  doCheck = !stdenv.isDarwin;

  passthru = {
    # A derivation that provides gcc and g++ commands, but that
    # will end up calling ccache for the given cacheDir
    links = {unwrappedCC, extraConfig}: stdenv.mkDerivation rec {
      name = "ccache-links";
      passthru = {
        isClang = unwrappedCC.isClang or false;
        isGNU = unwrappedCC.isGNU or false;
      };
      inherit (unwrappedCC) lib;
      nativeBuildInputs = [ makeWrapper ];
      buildCommand = ''
        mkdir -p $out/bin

        wrap() {
          local cname="$1"
          if [ -x "${unwrappedCC}/bin/$cname" ]; then
            makeWrapper ${ccache}/bin/ccache $out/bin/$cname \
              --run ${stdenv.lib.escapeShellArg extraConfig} \
              --add-flags ${unwrappedCC}/bin/$cname
          fi
        }

        wrap cc
        wrap c++
        wrap gcc
        wrap g++
        wrap clang
        wrap clang++

        for executable in $(ls ${unwrappedCC}/bin); do
          if [ ! -x "$out/bin/$executable" ]; then
            ln -s ${unwrappedCC}/bin/$executable $out/bin/$executable
          fi
        done
        for file in $(ls ${unwrappedCC} | grep -vw bin); do
          ln -s ${unwrappedCC}/$file $out/$file
        done
      '';
    };
  };

  meta = with stdenv.lib; {
    description = "Compiler cache for fast recompilation of C/C++ code";
    homepage = http://ccache.samba.org/;
    downloadPage = https://ccache.samba.org/download.html;
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
  };
};
in ccache
