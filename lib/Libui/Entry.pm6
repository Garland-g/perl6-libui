use Libui::Raw :lib;
use Libui::Control;

use NativeCall;

class uiEntry is repr('CStruct') is export(:raw) {
  also does autocast;
  has Pointer $.uiEntryText;
  has Pointer $.uiEntrySetText;
  has Pointer $.uiEntrOnChanged;
  has Pointer $.uiEntryReadOnly;
  has Pointer $.uiEntrySetReadOnly;
  has Pointer $.uiNewEntry;
  has Pointer $.uiNewPasswordEntry;
  has Pointer $.uiNewSearchEntry;
}

sub uiEntryText(uiEntry $e)
  returns Str
  is native(LIB)
  is export(:raw)
  { * }


sub uiEntrySetText(uiEntry $e, Str $text)
  is native(LIB)
  is export(:raw)
  { * }


sub uiEntryOnChanged(uiEntry $e, &f (uiEntry, Pointer), Pointer $data)
  is native(LIB)
  is export(:raw)
  { * }


sub uiEntryReadOnly(uiEntry $e)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiEntrySetReadOnly(uiEntry $e, int32 $readonly)
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewEntry()
  returns uiEntry
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewPasswordEntry()
  returns uiEntry
  is native(LIB)
  is export(:raw)
  { * }

sub uiNewSearchEntry()
  returns uiEntry
  is native(LIB)
  is export(:raw)
  { * }



role Libui::Entry-Common does Libui::Control {

  has uiEntry $!entry;
  has $!changed-supply;


  multi method text() returns Str {
    return uiEntryText($!entry);
  }

  method set-text(Str:D $text) {
    uiEntrySetText($!entry, $text);
  }

  multi method text(Str:D $text) {
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


  multi method read-only() returns Bool {
    return uiEntryReadOnly($!entry).Bool;
  }

  method set-read-only(Bool:D(Int) $read-only) {
    uiEntrySetReadOnly($!entry, $read-only);
  }

  multi method read-only(Bool:D(Int) $read-only) {
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

C<set-text(Str:D $text)> or C<text(Str:D $text)>

Sets the text content of the Entry.

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the text is changed.

C<read-only() returns Bool>

Returns True if the Entry is read-only.

C<set-read-only(Bool:D(Int) $read-only)> or C<read-only(Bool:D(Int) $read-only)>

Sets the read-only property of the Entry.

=end Entry
