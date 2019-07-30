use v6;

class Build {
  method build($dir) {
    mkdir "$dir/resources/libraries" unless "$dir/resources/libraries".IO.e;
    #Copy in the shared library for the user's platform,
    given $*DISTRO {
      when $*KERNEL ~~ 'linux' {
        return copy("$dir/resources/shared/libui.so.0", "$dir/resources/libraries/libui.so");
      }
      when "macosx" {
        return copy("$dir/resources/shared/libui.A.dylib", "$dir/resources/libraries/libui.dylib");
      }
      when $*DISTRO.is-win {
        return copy("$dir/resources/shared/libui.dll", "$dir/resources/libraries/ui.dll");
      }
    }
  }
}

#vi syntax=perl6
