{
  description = "flake for whereami";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.access_points = 
      with import nixpkgs { system = "x86_64-linux";};
      python37Packages.buildPythonPackage rec {
        name = "access_points";
        version = "1.0";

        src = fetchFromGitHub {
          owner = "kootenpv";
          repo = "access_points";
          rev = "master";
          sha256 = "sha256-MOMRIYjZb1Au7xq3gJgcuO0Jew1ZHgIcY+8ia44l6m4=";
        };

        doCheck = false;
      };

    packages.x86_64-linux.whereami =
      with import nixpkgs { system = "x86_64-linux";};
      python37Packages.buildPythonPackage rec {
        name = "whereami";
        version = "1.0";

        src = fetchFromGitHub {
          owner = "kootenpv";
          repo = "whereami";
          rev = "master";
          sha256 = "sha256-oimO8elfsVf/62p6UphJnamFdXX6nKqJOKMxx5PJOds=";
        };
        propagatedBuildInputs = with python37Packages; [
          tqdm
          scipy
          numpy
          scikitlearn
          self.packages.x86_64-linux.access_points
        ];

        doCheck = false;

        postInstall = "";
      };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.whereami;

  };
}
