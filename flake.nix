{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    libsvm = {
      url = "github:LeixB/libsvm";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ...}:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        inherit (inputs.libsvm.packages.${system}) libsvm;

        LocalPreferences = pkgs.writeText "LocalPreferences.toml" ''
          [libsvm_jll]
          libsvm_path = "${libsvm.out}/lib/libsvm.so"
          svm_predict_path = "${libsvm.bin}/bin/svm-predict"
          svm_scale_path = "${libsvm.bin}/bin/svm-scale"
          svm_train_path = "${libsvm.bin}/bin/svm-train"
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          LOCAL_PREFERENCES = LocalPreferences;
          buildInputs = with pkgs; [
            hyperfine
            julia
          ];
          shellHook = ''
            if [ -f LocalPreferences.toml ]; then
              if [ "${LocalPreferences}" != "$(readlink LocalPreferences.toml)" ]; then
                echo "LocalPreferences.toml is not a symlink to ${LocalPreferences}"
                rm LocalPreferences.toml
              else
                exit 0
              fi
            fi
            ln -s ${LocalPreferences} LocalPreferences.toml
          '';
        };
      }
    );
}
