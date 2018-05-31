use Libui::Raw :picker, :time;
use Libui::Control;

role Libui::Picker does Libui::Control {
	has uiDateTimePicker $!picker;
	has Supply $!changed-supply;

	multi method time() {
		my Time $time;
		uiDateTimePickerTime($!picker, $time);
		return $time;
	}

	method set-time(Time $time) {
		uiDateTimePickerSetTime($!picker, $time);
	}

	multi method time(Time $time) {
		self.set-time($time);
	}

	method changed() returns Supply {
		$!changed-supply //= do {
			my $s = Supplier.new;
			uiDateTimePickerOnChanged($!picker, -> $, $ {
				$s.emit(self);
				CATCH { default { note $_ } }
			},
			Str);
			return $s.Supply;
		}
	}

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
