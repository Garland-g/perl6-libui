use Libui::Raw;
use Libui::MenuItem;
unit class Libui::Menu;

has uiMenu $menu;

submethod BUILD(Str :$name) {
	$!menu = uiNewMenu($name);
}

method append-item(Str $name) returns Libui::MenuItem {
	return Libui::MenuItem.new(uiMenuAppendItem($!menu, $name));
}

method append-check-item(Str $name) returns Libui::MenuItem {
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
