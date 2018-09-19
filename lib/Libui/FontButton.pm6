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

  submethod TWEAK() {
    self.font;
  }

  method font() {
    uiFontButtonFont($!button, $!desc);
    return $!desc;
  }
  method family() returns Str {
    return $!desc.Family();
  }

  method size() returns Num {
    return $!desc.Size();
  }

  method weight() returns UInt {
    return $!desc.Weight();
  }

  method italic() returns UInt {
    return $!desc.Italic();
  }

  method stretch() returns UInt {
    return $!desc.Stretch();
  }

  method changed() {
    $!changed-supply //= do {
      my $s = Supplier.new;
      uiFontButtonOnChanged($!button, -> $, $ {
        $s.emit(self);
        uiFreeFontButtonFont($!desc);
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

=begin FontButton
=head2 Libui::FontButton

A button for selecting a font.

=head3 Methods

C<new()>

Creates a FontButton.

C<font() returns uiFontDescriptor>

Gets the current font displayed by the button. Stores it for further use and returns it.

C<family() returns Str>

Returns the L<family|https://github.com/Garland-g/perl6-libui/wiki/StringStyle#family> of the font cached by C<font()>.

C<size() returns Num>

Returns the L<size|https://github.com/Garland-g/perl6-libui/wiki/StringStyle#size> of the font cached by C<font()>.

C<weight() returns UInt>

Returns the L<weight|https://github.com/Garland-g/perl6-libui/wiki/StringStyle#weight> of the font cached by C<font()>.

C<italic() returns UInt>

Returns the L<italic|https://github.com/Garland-g/perl6-libui/wiki/StringStyle#italic> property of the font cached by C<font()>.

C<stretch() returns UInt>

Returns the L<stretch|https://github.com/Garland-g/perl6-libui/wiki/StringStyle#stretch> property of the font cached by C<font()>.

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the font is changed.
=end FontButton
