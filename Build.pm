use v6;

my $VERSION = "alpha4.1";

my $WIN-URL = "https://github.com/andlabs/libui/releases/download/$VERSION/libui-{$VERSION}-windows-amd64-shared.zip";

my $WIN-FILE = "libui-windows.zip";

my $MAC-URL = "https://github.com/andlabs/libui/releases/download/$VERSION/libui-{$VERSION}-darwin-amd64-shared.tgz";

my $MAC-FILE = "libui-darwin.tgz";

class Build {
  method build($dir) {
    my $ext = DateTime.now.Str.subst(/':'/, "", :g);
    mkdir "$dir/resources/libraries" unless "$dir/resources/libraries".IO.e;
    #Copy in the shared library for the user's platform
    given $*DISTRO {
      when $*KERNEL ~~ 'linux' {
        copy("$dir/resources/shared/libui.so", "$dir/resources/libraries/libui.so");
      }
      when "macosx" {
        copy("$dir/resources/shared/libui.A.dylib", "$dir/resources/libraries/libui.dylib");
      }
      when $*DISTRO.is-win {
        copy("$dir/resources/shared/libui.dll", "$dir/resources/libraries/ui.dll");
      }
    }
    return 0;
  }
}

#vi syntax=perl6
