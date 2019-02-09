use Libui::Raw :picker :time;
use Libui::Control;

role Libui::Picker does Libui::Control {
  has uiDateTimePicker $!picker;
  has Supply $!changed-supply;

	method !time-extract(Libui::Time $time) {...}

  method time() {

    my Libui::Time $time .= new;
    uiDateTimePickerTime($!picker, $time);
    return self!time-extract($time);
  }
#TODO: re-enable next rakudo release
#  method set-time(Libui::Time $time) {
#    uiDateTimePickerSetTime($!picker, $time);
#  }
#
#  multi method time(Libui::Time $time) {
#    self.set-time($time);
#  }

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
	method !time-extract(Libui::Time $time) {
		return DateTime.new(
			year => $time.year,
			month => $time.month,
			day => $time.day-of-month,
			hour => $time.hour,
			minute => $time.minute,
			second => $time.second,
			#Timezone is set to $*TZ by default
		);
	}
}

class Libui::DatePicker does Libui::Picker is export {
  submethod BUILD() {
    $!picker = uiNewDatePicker();
  }
	method !time-extract(Libui::Time $time) {
		return Date.new(
			year => $time.year,
			month => $time.month,
			day => $time.day-of-month,
		);
	}
}

class Libui::TimePicker does Libui::Picker is export {
  submethod BUILD() {
    $!picker = uiNewTimePicker();
  }
	method !time-extract(Libui::Time $time) {
		return DateTime.now.clone(
			hour => $time.hour,
			minute => $time.minute,
			second => $time.second,
		);
	}
}

=begin DateTimePicker
=head2 Libui::DateTimePicker, Libui::DatePicker, Libui::TimePicker

A widget to allow setting a Date and/or Time

=head3 Methods

C<new()>

Creates a Picker.

C<time() returns Libui::Time>

Returns a L<Time|https://github.com/Garland-g/perl6-libui/wiki/Time> object.

C<changed() returns Supply>

Returns a L<Supply|https://docs.perl6.org/type/Supply>. An event is emitted whenever the value is changed.
=end DateTimePicker
