use Libui::Raw;
use Libui::Control;

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
