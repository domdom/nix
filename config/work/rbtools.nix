{ lib, python3Packages, ...}:

python3Packages.buildPythonApplication rec {
  pname = "RBTools";
  version = "1.0.3";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "0g78wf0xw3m46d8zna3l87lzpwa7a37j2441ddkb3ldjswxflk7z";
  };

  propagatedBuildInputs = with python3Packages; [
    texttable
    six
    tqdm
    colorama
    setuptools
  ];

  doCheck = false;

  meta = with lib; {
    description = "Command line tools and API for working with code and document reviews on Review Board";
    homepage = "https://www.reviewboard.org/";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
