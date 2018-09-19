use Libui::Raw :multientry;
use Libui::Control;

role Libui::MultilineEntry-Common {
  also does Libui::Control;

  has uiMultilineEntry $!entry;
  has $!changed-supply;

  multi method text() returns Str {
    uiMultilineEntryText($!entry);
  }

  method set-text(Str:D $text) {
    uiMultilineEntrySetText($!entry, $text);
  }

  multi method text(Str:D $text) {
    self.set-text($text);
  }

  method append(Str:D $text) {
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

  multi method read-only() returns Bool {
    return uiMultilineEntryReadOnly($!entry).Bool;
  }

  method set-read-only(Bool:D(Int) $read-only) {
    uiMultilineEntrySetReadOnly($!entry, $read-only);
  }

  multi method read-only(Bool:D(Int) $read-only) {
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

C<set-text(Str:D $text)> or C<text(Str:D $text)>

Sets the text content of the MultilineEntry.

C<append(Str:D $text)>

Appends $text to the MultilineEntry.

C<changed() returns Supply>

Returns a Supply. An event is emitted whenever the text is changed.

C<read-only() returns Bool>

Returns True if the Entry is read-only.

C<set-read-only(Bool:D(Int) $read-only)> or C<read-only(Bool:D(Int) $read-only)>

Sets the read-only property of the Entry.
=end MultilineEntry
