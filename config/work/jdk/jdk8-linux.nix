import ./jdk-linux-base.nix rec {
  productVersion = "8u25";
  productUrl = platformName: "http://jre.us.oracle.com/java/re/jdk/${productVersion}/latest/bundles/${platformName}/jdk-${productVersion}-${platformName}.tar.gz";
  sha256.i686-linux = "09946wmvfkzh0lvqfki1pl6d8limgm2rh86fb73sgdlqxgvk6xml";
  sha256.x86_64-linux = "09946wmvfkzh0lvqfki1pl6d8limgm2rh86fb73sgdlqxgvk6xml";
  sha256.armv7l-linux = "";
  sha256.aarch64-linux = "";
}
