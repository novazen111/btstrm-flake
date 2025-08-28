{ lib
, fetchFromGitHub
, ffmpeg
, fzf
, mpv
, btfs
, python3
, pkgs
, jackett
, chafa
}:

let
  pname = "btstrm";
  version = "0.1.7";
in
python3.pkgs.buildPythonPackage {
  inherit pname version;
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Ajatt-Tools";
    repo = "btstrm";
    rev = version;
    sha256 = "KsVxpyGJCQyMRUPylBBs60vRjoKbzVYGKBTMYm7gR7o=";


  };

  propagatedBuildInputs = with python3.pkgs; [
    beautifulsoup4
    colorama
    requests
    tqdm
    unidecode
    setuptools
  ];

 # nativeBuildInputs = [
  #  python3.pkgs.pythonRelaxDepsHook
  #];

  #pythonRelaxDeps = [
   # "httpx"
    #"tldextract"
  #];

  makeWrapperArgs = let
    binPath = lib.makeBinPath [
      #ffmpeg
      fzf
      mpv
      btfs
      jackett
      chafa
    ];
  in [
    "--prefix PATH : ${binPath}"
  ];

  meta = with lib; {
    homepage = "https://github.com/Ajatt-Tools/btstrm";
    description = "stream torrents without soy webtorrent (and with some features) ";
    license = with lib.licenses; [ gpl3Only ];
    mainProgram = "btstrm";
    maintainers = with lib.maintainers; [ asakura42 ];

  };

}


