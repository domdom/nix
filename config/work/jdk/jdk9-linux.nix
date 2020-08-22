import ./jdk-linux-base.nix rec {
  productVersion = "9";
  productUrl = platformName: "http://jre.us.oracle.com/java/re/jdk/${productVersion}/latest/bundles/${platformName}/jdk-${productVersion}+181_${platformName}_bin.tar.gz";
  sha256.i686-linux = "0vbgy7h9h089l3xh6sl57v57g28x1djyiigqs4z6gh7wahx7hv8w";
  sha256.x86_64-linux = "0vbgy7h9h089l3xh6sl57v57g28x1djyiigqs4z6gh7wahx7hv8w";
  sha256.armv7l-linux = "";
  sha256.aarch64-linux = "";
  productRSubPaths = [
    "lib/jli"
    "lib/server"
    "lib/xawt"
    "lib"
  ];
}
