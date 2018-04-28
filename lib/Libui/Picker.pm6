use Libui::Raw;
use Libui::Control;

############################################################
#																													 #
#									(Version 0.3.5-alpha)										 #
#					Not fully implemented in libui yet!							 #
#			Can spawn a widget, but cannot get data out.				 #
#																													 #
#																													 #
############################################################

role Libui::Picker does Libui::Control {
	has uiDateTimePicker $!picker;

	method !WIDGET() {
		return $!picker;
	}
}

class Libui::DateTimePicker does Libui::Picker is export {
	submethod BUILD() {
		$!picker = uiNewDateTimePicker();
	}
}

class Libui::DatePicker does Libui::Picker is export {
	submethod BUILD() {
		$!picker = uiNewDatePicker();
	}
}

class Libui::TimePicker does Libui::Picker is export {
	submethod BUILD() {
		$!picker = uiNewTimePicker();
	}
}
