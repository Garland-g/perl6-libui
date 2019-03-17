use v6;

my $VERSION = "alpha4.1";

my $WIN-URL = "https://github.com/andlabs/libui/releases/download/$VERSION/libui-{$VERSION}-windows-amd64-shared.zip";

my $WIN-FILE = "libui-windows.zip";

my $MAC-URL = "https://github.com/andlabs/libui/releases/download/$VERSION/libui-{$VERSION}-darwin-amd64-shared.tgz";

my $MAC-FILE = "libui-darwin.tgz";

class Build {
  method build($dir) {
    my $ext = DateTime.now.Str.subst(/':'/, "", :g);
    mkdir "$dir/resources" unless "$dir/resources".IO.e;
    mkdir "$dir/resources/libraries" unless "$dir/resources/libraries".IO.e;
    #Acquire the shared library for the user's platform
    given $*DISTRO {
      when $*KERNEL ~~ 'linux' {
        say "linux";
        #If the library already exists on the system
        if "/usr/lib/libui.so".IO.e {
            unless "$dir/resources/libraries/libui.so".IO.e {
              run "ln", "-s", "/usr/lib/libui.so", "$dir/resources/libraries/libui.so";
             }
              proceed;
            }
        try {
          run("cmake", "--help"); 
          CATCH{ default { die "You must have CMake installed and in your PATH";} }
        }
          run("git", "clone", "https://github.com/andlabs/libui.git", "/tmp/libui-$ext") or die "git clone failed";
          chdir("/tmp/libui-$ext");
          run("git", "checkout", $VERSION) or die "could not check out $VERSION";
          mkdir "/tmp/libui-$ext/build" unless "$dir/libui-$ext/build".IO.e;
          chdir("/tmp/libui-$ext/build");
          run("cmake", "..", :out, :err) or die "Cmake failed";
          run("make", :out, :err) or die "make failed";
          copy("out/libui.so.0", "$dir/resources/libraries/libui.so");
          chdir "$dir";
      }
      when "macosx" {
        say "macos";
        mkdir "$*TMPDIR/libui-$ext";
        chdir "$*TMPDIR/libui-$ext";
        run("curl", "-L", $MAC-URL, "-o", $MAC-FILE, :out, :err);
        run("tar", "-xvf", $MAC-FILE, :out, :err);
        copy("libui.A.dylib", "$dir/resources/libraries/libui.dylib");
        chdir "$dir";
      }
      when $*DISTRO.is-win {
        say "windows";
        mkdir "$*TMPDIR/libui-$ext";
        chdir "$*TMPDIR/libui-$ext";
        my $proc = run("powershell", "--version", :out) or die("Need powershell");
        #Check if powershell is version 5.0.0 or higher (needed for Expand-Archive)
        die("Need Powershell 5.0.0") unless $proc.out.slurp(:close).split(' ')[1].split('.')[0] >= 5;
        run("powershell", "-command", "Invoke-WebRequest -Uri $WIN-URL -OutFile $WIN-FILE");
        run("powershell", "-command", "Expand-Archive -Path $WIN-FILE");
        copy("libui-windows/libui.dll", "$dir/resources/libraries/ui.dll");
        chdir "$dir";
      }
    }
    return 1;
  }
}

#vi syntax=perl6
