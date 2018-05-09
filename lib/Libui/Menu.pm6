use Libui::Raw;
use Libui::MenuItem;
use Libui::Control;
unit class Libui::Menu does Libui::Control;

has uiMenu $!menu;

submethod BUILD(Str:D :$name) {
	$!menu = uiNewMenu($name);
}

multi method new(Str:D $name) {
	self.bless(:$name);
}

method append-item(Str:D $name) returns Libui::MenuItem {
	return Libui::MenuItem.new(uiMenuAppendItem($!menu, $name));
}

method append-check-item(Str:D $name) returns Libui::MenuItem {
	return Libui::MenuItem.new(uiMenuAppendCheckItem($!menu, $name));
}

method append-quit-item() returns Libui::MenuItem {
	return Libui::MenuItem.new(uiMenuAppendQuitItem($!menu));
}

method append-preferences-item() returns Libui::MenuItem {
	return Libui::MenuItem.new(uiMenuAppendPreferencesItem($!menu));
}

method append-about-item() returns Libui::MenuItem {
	return Libui::MenuItem.new(uiMenuAppendAboutItem($!menu));
}

method append-separator() {
	uiMenuAppendSeparator($!menu);
}

method !WIDGET() {
	return $!menu;
}
