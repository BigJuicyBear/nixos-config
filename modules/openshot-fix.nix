{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      libopenshot = prev.libopenshot.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          sed -i -E 's/(CMAKE_CXX_STANDARD +)[0-9]+/\120/' CMakeLists.txt
          sed -i -E 's/(^|[^:A-Za-z_])lerp\(/\1osLerp(/g' src/effects/DenoiseImage.cpp
        '';
        cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DCMAKE_CXX_STANDARD=20" ];
      });
    })
  ];
}
