use Libui::Raw;
#use Libui::Control;
use Libui::Container;

unit class Libui::Form;
#also does Libui::Control;
also does Libui::Container;

has uiForm $!form;

submethod BUILD() {
	$!form = uiNewForm();
}

method append(Str $label, Libui::Control $c, int32 $stretchy) {
	uiFormAppend($!form, $label, $c.Control, $stretchy);
}

method delete(int32 $index) {
	uiFormDelete($!form, $index);
}

method padded() returns int32 {
	return uiFormPadded($!form);
}

method set-padded(int32 $padded) {
	uiFormSetPadded($!form, $padded);
}

method !WIDGET() {
	return $!form;
}
