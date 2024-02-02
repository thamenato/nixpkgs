{ lib
,  stdenv
, git
, fetchFromGitHub
, python39
, rustup
, protobuf
}:

stdenv.mkDerivation rec {
  pname = "pants";
  version = "2.19.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pantsbuild";
    repo = "pants";
    rev = "refs/tags/release_${version}";
    hash = "sha256-cXWchQn7doa71mR0ht5T7xpE+YBm6lYKqRCi9qOuPio=";
  };

  # preBuild = ''
  #   export HOME=$(mktemp -d)
  # '';
  buildInputs = [ git python39 rustup protobuf ];

  buildPhase = "bash pants";
  installPhase = ''
    cp -R . $out
    $out/pants
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


