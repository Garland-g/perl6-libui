use Libui::Raw :menu;
use Libui::Control;

unit class Libui::MenuItem does Libui::Control;

has uiMenuItem $!item;
has $!clicked-supply;

#uiMenuItems are returned by the uiMenu methods
#therefore
#Libui::MenuItems are returned by Libui::Menu methods
method new(uiMenuItem $item) {
	self.bless(item => $item);
}

submethod BUILD(uiMenuItem :$item) {
	$!item = $item;
}

method enable() {
	uiMenuItemEnable($!item);
}

method disable() {
	uiMenuItemDisable($!item);
}

method clicked() returns Supply {
	$!clicked-supply //= do {
		my $s = Supplier.new;
		uiMenuItemOnClicked($!item, -> $, $ {
			$s.emit(self);
			CATCH { default { note $_; } }
		},
		Str);
		$s.Supply;
	}
}

multi method checked() returns int32 {
	uiMenuItemChecked($!item);
}

method set-checked(int32 $checked) {
	uiMenuItemSetChecked($!item, $checked);
}

multi method checked(Int $checked) {
	self.set-checked($checked);
}

method !WIDGET() {
	return $!item;
}
