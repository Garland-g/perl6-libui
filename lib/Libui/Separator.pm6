use Libui::Raw :lib;
use Libui::Control;

use NativeCall;

class uiSeparator is repr('CStruct') is export(:raw) {
  also does autocast;
  has Pointer $.uiNewHorizontalSeparator;
  has Pointer $.uiNewVerticalSeparator;
}

sub uiNewHorizontalSeparator()
  returns uiSeparator
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewVerticalSeparator()
  returns uiSeparator
  is native(LIB)
  is export(:raw)
  { * }



role Libui::Separator does Libui::Control {
  has $!separator;

  method !WIDGET() {
    return $!separator;
  }
}

class Libui::HSeparator does Libui::Separator {
  submethod BUILD() {
    $!separator = uiNewHorizontalSeparator();
  }
}

class Libui::VSeparator does Libui::Separator {
  submethod BUILD() {
    $!separator = uiNewVerticalSeparator();
  }
}

=begin Separator
=head2 Libui::HSeparator, Libui::VSeparator

Separator widget. Adds a horizontal or vertical line.
=end Separator
