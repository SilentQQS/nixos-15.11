{nixpkgs24, ...}: {
  home.packages = with nixpkgs24; [
    (blender.override {
      cudaSupport = true;
    })
  ];
}
