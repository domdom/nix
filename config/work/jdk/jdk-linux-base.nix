{ productVersion
, productUrl
, sha256
, productRSubPaths ? []
}:

{ stdenv
, fetchurl
, makeWrapper
, unzip
, file
, xorg ? null
, config
, glib
, libxml2
, libav_0_8
, ffmpeg
, libxslt
, libGL
, zlib
, freetype
, fontconfig
, gtk2
, pango
, cairo
, alsaLib
, atk
, gdk-pixbuf
, setJavaClassPath
}:

let

  /**
   * The JRE libraries are in directories that depend on the CPU.
   */
  architecture = {
    i686-linux    = "i386";
    x86_64-linux  = "amd64";
    armv7l-linux  = "arm";
    aarch64-linux = "aarch64";
  }.${stdenv.hostPlatform.system} or (throw "unsupported system ${stdenv.hostPlatform.system}");

  rSubPaths = [
    "jre/lib/${architecture}/jli"
    "jre/lib/${architecture}/server"
    "jre/lib/${architecture}/xawt"
    "jre/lib/${architecture}"
  ] ++ productRSubPaths;
in

let result = stdenv.mkDerivation rec {
  pname = "oracle-jdk";
  version = "${productVersion}";

  src =
    let
      platformName = {
        i686-linux    = "linux-i586";
        x86_64-linux  = "linux-x64";
        armv7l-linux  = "linux-arm32-vfp-hflt";
        aarch64-linux = "linux-arm64-vfp-hflt";
      }.${stdenv.hostPlatform.system} or (throw "unsupported system ${stdenv.hostPlatform.system}");
    in fetchurl {
      url = productUrl platformName;
      sha256 = sha256.${stdenv.hostPlatform.system};
    };

  nativeBuildInputs = [ file ];

  buildInputs = [ makeWrapper ];

  # See: https://github.com/NixOS/patchelf/issues/10
  dontStrip = 1;

  installPhase = ''
    cd ..

    mv $sourceRoot $out

    mkdir -p $out/nix-support
    printWords ${setJavaClassPath} > $out/nix-support/propagated-build-inputs
  '';

  postFixup = ''
    rpath+="''${rpath:+:}${stdenv.lib.concatStringsSep ":" (map (a: "$out/${a}") rSubPaths)}"

    # set all the dynamic linkers
    find $out -type f -perm -0100 \
        -exec patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "$rpath" {} \;

    find $out -name "*.so" -exec patchelf --set-rpath "$rpath" {} \;

    # Oracle Java Mission Control needs to know where libgtk-x11 and related is
    if test -x $out/bin/jmc; then
      wrapProgram "$out/bin/jmc" \
          --suffix-each LD_LIBRARY_PATH ':' "$rpath"
    fi
  '';

  /**
   * libXt is only needed on amd64
   */
  libraries =
    [stdenv.cc.libc glib libxml2 libav_0_8 ffmpeg libxslt libGL xorg.libXxf86vm alsaLib fontconfig freetype pango gtk2 cairo gdk-pixbuf atk zlib];

  rpath = stdenv.lib.strings.makeLibraryPath libraries;

  passthru.mozillaPlugin = "/jre/lib/${architecture}/plugins";

  passthru.jre = result; # FIXME: use multiple outputs or return actual JRE package

  passthru.home = result;

  passthru.architecture = architecture;

  meta = with stdenv.lib; {
    license = licenses.unfree;
    platforms = [ "i686-linux" "x86_64-linux" "armv7l-linux" "aarch64-linux" ]; # some inherit jre.meta.platforms
  };

}; in result
