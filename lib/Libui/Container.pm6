use Libui::Raw;
use Libui::Control;
unit role Libui::Container does Libui::Control;

method set-content($control) {
	if $control.top-level() {
		die "cannot set window inside another control";
	}
	self!set-content($control);
}
