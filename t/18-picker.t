use v6;
use Test;
use Libui;

Libui::Init();

plan *;

lives-ok {
	my Libui::DateTimePicker $dtpicker .= new;
}

lives-ok {
	my Libui::TimePicker $dpicker .= new;
}

lives-ok {
	my Libui::DatePicker $tpicker .= new;
}


done-testing;
# vi:syntax=perl6
