use Libui::Raw :form;
use Libui::Container;

unit class Libui::Form;
also does Libui::Container;

has uiForm $!form;

submethod BUILD() {
	$!form = uiNewForm();
}

method append(Str $label, Libui::Control $c, int32 $stretchy) {
	if $c.top-level() {
		note "cannot place {$c.WHAT} into a Libui::Container";
	} else {
		uiFormAppend($!form, $label, $c.Control, $stretchy);
	}
}

method set-content(Str $label, Libui::Control $c, Int $stretchy) {
	self.append($label, $c, $stretchy);
}

method delete(int32 $index) {
	uiFormDelete($!form, $index);
}

multi method padded() returns int32 {
	return uiFormPadded($!form);
}

method set-padded(int32 $padded) {
	uiFormSetPadded($!form, $padded);
}

multi method padded(Int $padded) {
	self.set-padded($padded);
}

method !WIDGET() {
	return $!form;
}
