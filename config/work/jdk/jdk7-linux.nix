import ./jdk-linux-base.nix rec {
  productVersion = "7u45";
  productUrl = platformName: "http://jre.us.oracle.com/java/re/jdk/${productVersion}/latest/bundles/${platformName}/jdk-${productVersion}-${platformName}.tar.gz";
  sha256.i686-linux = "041l594b26mv90m8vnfc2qs3w1qjla4b12p3m6l7r1746kkixwy8";
  sha256.x86_64-linux = "041l594b26mv90m8vnfc2qs3w1qjla4b12p3m6l7r1746kkixwy8";
  sha256.armv7l-linux = "";
  sha256.aarch64-linux = "";
}
