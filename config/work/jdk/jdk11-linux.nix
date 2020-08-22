import ./jdk-linux-base.nix rec {
  productVersion = "11.0.2";
  productUrl = platformName: "https://jpg-data.us.oracle.com/artifactory/re-release-local/jdk/${productVersion}/9/bundles/${platformName}/jdk-${productVersion}+9_${platformName}_bin.tar.gz";
  sha256.i686-linux = "1j6dlbirjvxrq9jsfi2nvddnnw7rmgj80jlnkmlzzsakrzzxhkvv";
  sha256.x86_64-linux = "1j6dlbirjvxrq9jsfi2nvddnnw7rmgj80jlnkmlzzsakrzzxhkvv";
  sha256.armv7l-linux = "";
  sha256.aarch64-linux = "";
  productRSubPaths = [
    "lib/jli"
    "lib/server"
    "lib/xawt"
    "lib"
  ];
}
