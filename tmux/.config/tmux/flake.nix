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
          version = "0.2.19";
          format = "wheel";

          src = pkgs.fetchurl {
            url = "https://files.pythonhosted.org/packages/c3/3b/5e3eccab0f59ab7523efe31469903147cdd24b02880fbc725e37245a9840/lsp_tree_sitter-0.2.19-py3-none-any.whl";
            hash = "sha256-vkcoImOyM9kaVKqBdbrFuN9aA5Y/0C76Km8k6xdwl0U=";
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
                version = "0.1.3";

                src = pkgs.fetchFromGitHub {
                # TODO: reset once fixed upstream
                  owner = "arminveres";
                  repo = "tmux-language-server";
                  rev = "cfe283dda882a912c712c76d5348f7b28c09fed3";
                  hash = "sha256-m06iVn3iDS5BXzFQzhrcl+CYcO0pPSZUJ8f9ybeLcLI=";
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
