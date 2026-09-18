{
  lib,
  python3,
  fetchPypi,
  versionCheckHook,
  versionCheckHomeHook,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "hol-guard";
  version = "3.0.189";
  pyproject = true;

  src = fetchPypi {
    pname = "hol_guard";
    inherit version;
    hash = "sha256-XlKxbWpA6eAfVMENfg6M+pdsLmxT0U13RPh9u+MF8Iw=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail 'hatchling<1.31' 'hatchling'
  '';

  build-system = with python3.pkgs; [
    hatchling
  ];

  dependencies = with python3.pkgs; [
    cryptography
    idna
    jsonschema
    keyring
    mcp
    packaging
    publicsuffixlist
    pyyaml
    regex
    requests
    rich
  ];

  pythonRelaxDeps = [
    "idna"
    "publicsuffixlist"
    "rich"
  ];

  pythonImportsCheck = [ "codex_plugin_scanner" ];

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    versionCheckHook
    versionCheckHomeHook
  ];
  versionCheckProgramArg = "--version";

  passthru.category = "Utilities";

  meta = {
    description = "Open-source antivirus and runtime protection for AI agents";
    homepage = "https://hol.org/guard";
    downloadPage = "https://pypi.org/project/hol-guard/";
    changelog = "https://github.com/hashgraph-online/hol-guard/releases";
    license = lib.licenses.asl20;
    sourceProvenance = with lib.sourceTypes; [ fromSource ];
    maintainers = [
      {
        github = "kantorcodes";
        githubId = 6068672;
        name = "Michael Kantor";
      }
    ];
    mainProgram = "hol-guard";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };
}
