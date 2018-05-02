use Libui::Raw;
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
