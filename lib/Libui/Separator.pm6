use Libui::Raw :separator;
use Libui::Control;

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
