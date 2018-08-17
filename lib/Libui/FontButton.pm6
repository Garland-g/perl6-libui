use Libui::Raw :draw, :font;
use Libui::Control;

#TODO:
#SetFont is not implemented in libui yet

class Libui::FontButton does Libui::Control is export {

  has uiFontButton $!button;
  has uiFontDescriptor $!desc;
  has $!changed-supply;

  submethod BUILD() {
    $!button = uiNewFontButton();
    $!desc .= new;
  }

#  submethod DESTROY() {
#    uiFreeFontButtonFont($!desc);
#  }

  method font() {
    uiFontButtonFont($!button, $!desc);
  }
  method family() returns Str {
    return $!desc.Family();
  }

  method size() returns num64 {
    return $!desc.Size();
  }

  method weight() returns uint32 {
    return $!desc.Weight();
  }

  method italic() returns uint32 {
    return $!desc.Italic();
  }

  method stretch() returns uint32 {
    return $!desc.Stretch();
  }

  method changed() {
    $!changed-supply //= do {
      my $s = Supplier.new;
      uiFontButtonOnChanged($!button, -> $, $ {
        $s.emit(self);
        CATCH { default { note $_; } }
      },
      Str);
      return $s.Supply;
    }
  }

  method !WIDGET() {
    return $!button;
  }
}
