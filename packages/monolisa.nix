{
  stdenv,
  requireFile,
  unzip,
  lib,
}:
stdenv.mkDerivation {
  name = "monolisa";
  version = "2.015";

  src = requireFile rec {
    name = "MonoLisa.zip";
    sha256 = "15s05lmrky0yaic5mwdn76qpbamhwcmr2i9qykfll6chmrdlynrd";
    message = ''
      ${name} font not found in nix store, to add it run:
      $ nix-store --add-fixed sha256 /path/to/${name}

      Did you change the file? maybe you need to update the sha256
      $ nix-hash --flat --base32 --type sha256 /path/to/${name}'';
  };

  buildInputs = [ unzip ];
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  pathsToLink = [ "/share/fonts/truetype/" ];
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    install_path=$out/share/fonts/truetype
    mkdir -p $install_path
    find -name "MonoLisa*.ttf" -exec cp {} $install_path \;

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://monolisa.dev";
    description = ''
      As software developers, we always strive for better tools but rarely consider font as such. Yet we spend most of our days looking at screens reading and writing code. Using a wrong font can negatively impact our productivity and lead to bugs. MonoLisa was designed by professionals to improve developers’ productivity and reduce fatigue.
    '';
    platforms = platforms.all;
    licence = licences.unfree;
  };
}
