use Libui::Raw :entry;
use Libui::Control;

role Libui::Entry-Common does Libui::Control {

  has uiEntry $!entry;
  has $!changed-supply;


  multi method text() returns Str {
    return uiEntryText($!entry);
  }

  method set-text(Str $text) {
    uiEntrySetText($!entry, $text);
  }

  multi method text(Str $text) {
    self.set-text($text);
  }

  method changed() returns Supply {
    $!changed-supply //= do {
      my $s = Supplier.new;
      uiEntryOnChanged($!entry, -> $, $ {
        $s.emit(self);
        CATCH { default { note $_ } }
      },
      Str);
      return $s.Supply;
    }
  }


  multi method read-only() returns int32 {
    return uiEntryReadOnly($!entry);
  }

  method set-read-only(int32 $read-only) {
    uiEntrySetReadOnly($!entry, $read-only);
  }

  multi method read-only(Int $read-only) {
    self.set-read-only($read-only);
  }

  method !WIDGET() {
    return $!entry;
  }
}

class Libui::Entry does Libui::Entry-Common is export {

  submethod BUILD() {
    $!entry = uiNewEntry();
  }
}

class Libui::PasswordEntry does Libui::Entry-Common is export {
  submethod BUILD() {
    $!entry = uiNewPasswordEntry;
  }
}

class Libui::SearchEntry does Libui::Entry-Common is export {
  submethod BUILD() {
    $!entry = uiNewSearchEntry();
  }
}


=begin Entry
=head2 Libui::Entry, Libui::PasswordEntry, Libui::SearchEntry

A text field to input and display text.

=head3 Methods

C<new()>

Creates a Libui::Entry.

C<text() returns Str>

Returns the text content of the Entry.

C<set-text(Str $text)` or `text(Str $text)>

Sets the text content of the Entry.

C<`changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the text is changed.

C<read-only() returns int32>

Returns 1 if the Entry is read-only.

C<set-read-only(int32 $read-only)> or C<read-only(Int $read-only)>

Sets the read-only property of the Entry.

=end Entry
