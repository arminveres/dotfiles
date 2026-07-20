{
  description = "A basic flake with a shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        lsp-tree-sitter = pkgs.python3.pkgs.buildPythonPackage  {
          pname = "lsp-tree-sitter";
          version = "0.2.3";
          format = "wheel";

          src = pkgs.fetchurl {
            url = "https://files.pythonhosted.org/packages/ad/fc/5a2a08649a183bdece99ef937e60a9c06cd5532aaa045c03d8980198212b/lsp_tree_sitter-0.2.3-py3-none-any.whl";
            hash = "sha256-M9rZM7IYIW4udGaR4l+s4NLdPvZzPXM4wDF99ghMb90=";
          };

          dontCheckRuntimeDeps = true;

          dependencies = with pkgs.python3.pkgs; [
            jq
            jsonschema
            pygls
            tree-sitter
          ];
        };

        tree-sitter-tmux = pkgs.python3.pkgs.buildPythonPackage  {
          pname = "tree-sitter-tmux";
          version = "0.1.1";
          format = "wheel";

          src = pkgs.fetchurl {
            url = "https://files.pythonhosted.org/packages/08/dc/752a2ed8ca8c2d01bf6c9adeaa8d5204dd78c6c2e66a5859d8b0eb1a9769/tree_sitter_tmux-0.1.1-cp310-abi3-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl";
            hash = "sha256-VHmoyMMaemd0W81AZPnDRdoDHMf9DGoI9cQ0Q0N/Lnk=";
          };

          dependencies = [ pkgs.python3.pkgs.tree-sitter ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            tmux
            (python3.withPackages (ps: [
              (ps.buildPythonPackage  {
                pname = "tmux-language-server";
                version = "0.1.0";

                src = pkgs.fetchFromGitHub {
                  owner = "Freed-Wu";
                  repo = "tmux-language-server";
                  rev = "b42a4dc7bb4aed634eacf1f6cc1b231e374f8037";
                  hash = "sha256-2avKCv9rSSiBvzwx7NWnY1+ciRidKOhURcHe2EQL0jA=";
                };

                pyproject = true;

                dontCheckRuntimeDeps = true;

                build-system = with ps; [
                  uv-build
                ];

                dependencies = [
                  lsp-tree-sitter
                  tree-sitter-tmux
                ];
              })
            ]))
          ];

          shellHook = ''

            echo "tmux-language-server available in this shell"
          '';
        };
      }
    );

}
