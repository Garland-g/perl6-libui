use Libui::Raw :multientry;
use Libui::Control;

role Libui::MultilineEntry-Common {
  also does Libui::Control;

  has uiMultilineEntry $!entry;
  has $!changed-supply;

  multi method text() returns Str {
    uiMultilineEntryText($!entry);
  }

  method set-text(Str $text) {
    uiMultilineEntrySetText($!entry, $text);
  }

  multi method text(Str $text) {
    self.set-text($text);
  }

  method append(Str $text) {
    uiMultilineEntryAppend($!entry, $text);
  }

  method changed() {
    $!changed-supply //= do {
      my $s = Supplier.new;
      uiMultilineEntryOnChanged($!entry, -> $, $ {
        $s.emit(self);
        CATCH { default { note $_; } }
      },
      Str);
      return $s.Supply;
    }
  }

  multi method read-only() returns int32 {
    return uiMultilineEntryReadOnly($!entry);
  }

  method set-read-only(int32 $read-only) {
    uiMultilineEntrySetReadOnly($!entry, $read-only);
  }

  multi method read-only(Int $read-only) {
    self.read-only($read-only);
  }

  method !WIDGET() {
    return $!entry;
  }
}

class Libui::MultilineEntry does Libui::MultilineEntry-Common {

  submethod BUILD() {
    $!entry = uiNewMultilineEntry();
  }
}

class Libui::NonWrappingMultilineEntry does Libui::MultilineEntry-Common {

  submethod BUILD() {
    $!entry = uiNewNonWrappingMultilineEntry();
  }
}

=begin MultilineEntry
=head2 Libui::MultilineEntry Libui::NonWrappingMultilineEntry

An entry that spans multiple lines.

=head3 Methods

C<new()>

Creates a MultilineEntry.

C<text() returns Str>

Returns the text content of the MultilineEntry.

C<set-text(Str $text)> or C<text(Str $text)>

Sets the text content of the MultilineEntry.

C<append(Str $text)>

Appends $text to the MultilineEntry.

C<changed() returns Supply>

Returns a Supply. An event is emitted whenever the text is changed.

C<read-only() returns int32>

Returns 1 if the Entry is read-only.

C<set-read-only(int32 $read-only)> or C<read-only(Int $read-only)>

Sets the read-only property of the Entry.
=end MultilineEntry
