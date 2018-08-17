use Libui::Raw :picker :time;
use Libui::Control;

role Libui::Picker does Libui::Control {
  has uiDateTimePicker $!picker;
  has Supply $!changed-supply;

  multi method time() {
    my Libui::Time $time .= new;
    uiDateTimePickerTime($!picker, $time);
    return $time;
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
