{ lib
,  stdenv
, git
, fetchurl
 , python39
#  , autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "pants";
  version = "2.19.0";

  dontStrip = true;
  doInstallCheck = true;

  src = fetchurl {
    url = "https://github.com/pantsbuild/pants/releases/download/release_2.19.0/pants.2.19.0-cp39-linux_x86_64.pex";
    sha256 = "sha256-XClhLcOjHd1c9FN7SKxeA06DFLhtlDgeRl9UlZ1JE6Q=";
  };

  # nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ python39 ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp $src $out/bin/pants
    chmod +x $out/bin/pants

    runHook postInstall
  '';

  installCheckPhase = ''
    export HOME=$(mktemp -d)
    touch pants.toml
    $out/bin/pants --version
  '';


  meta = with lib; {
    description = "Pants is a fast, scalable, user-friendly build system for codebases of all sizes.";
    homepage = "https://github.com/pantsbuild/pants";
    changelog = "https://github.com/pantsbuild/pants/releases/tag/release_${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ thamenato ];
    mainProgram = "pants";
    platforms = platforms.linux;
  };
}


