{
  lib,
  stdenv,
  # fetchFromGitHub,
  cmake,
  src,
}:

stdenv.mkDerivation {
  name = "hades-saves-extractor";
  version = "v1.3";

  nativeBuildInputs = [ cmake ];
  # buildInputs = [ ];

  inherit src;
  # src = fetchFromGitHub {
  #   owner = "coldelectrons";
  #   repo = "HadesSavesExtractor";
  #   fetchSubmodules = true;
  #   rev = "f7889f781ae9c883a31d71d569e3cd2d65b94708";
  #   hash = "sha256-1XBU0UxC7jU+vt+PcidWnUOChDJ9iiez0AfhRCl9Q20=";
  # };

  # Specify cmake flags
  #cmakeFlags = [
  #  "--no-warn-unused-cli" # Supresses unused varibles warning
    # "-DMyVar=foo" # Example CMake argument
  #];

  # Nix is smart enough to detect we're using cmake to build our project
  # It will read our CMakeLists.txt file and create needed definitions
  # Alternatively, we could have been pre-defining the default phases that nix does
  # for a CMake based projects (see definitions bellow that are commented-out ###)

  ### buildDir = "build-nix-${self.name}-${self.version}";
  # buildDir = "build-nix-${self.name}-${self.version}";

  configurePhase = ''
    cmake . -B build
  '';

  buildPhase = ''
    cmake --build build --config Release
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install ./bin/HadesSavesExtractor $out/bin/HadesSavesExtractor

    runHook postInstall
  '';

  # passthru - it is meant for values that would be useful outside of the derivation
  # in other parts of a Nix expression (e.g. in other derivations)
  # passthru = {
  #   # inherit has nothing to do with OOP, it's a nix-specific syntax for
  #   # inheriting (copying) variables from the surrounding lexical scope
  #   inherit pkgs shell;
  #   # equivalent to:
  #   # pkgs = pkgs
  #   # shell = shell
  # };
  meta = with lib; {
    description = "Utility to (de)serialize Hades savefiles to/from lua";
    homepage = "https://github.com/TheNormalijt/Hades-SavesExtractor";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "HadesSavesExtractor";
    maintainers = with maintainers; [ ];
  };
}
