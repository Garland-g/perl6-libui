use Libui::Raw;

unit class Libui::MenuItem;

has uiMenuItem $!item;
has $!clicked-supply;

#uiMenuItems are returned by the uiMenu methods
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
		my $s = Supply.new;
		uiMenuItemOnClicked($!item, -> $, $ {
			$s.emit(self);
			CATCH { default { note $_; } }
		},
		Str);
		$s.Supply;
	}
}

method checked() returns int32 {
	uiMenuItemChecked($!item);
}

method set-checked(int32 $checked) {
	uiMenuItemSetChecked($!item, $checked);
}

method WIDGET() {
	return $!item;
}
