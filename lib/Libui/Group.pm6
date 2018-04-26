use Libui::Raw;
use Libui::Container;
#use Libui::Control;

unit class Libui::Group;
also does Libui::Container;
#also does Libui::Control;

has uiGroup $!group;

submethod BUILD(Str :$title) {
	$!group = uiNewGroup($title);
}

method title() returns Str {
	uiGroupTitle($!group);
}

method set-title(Str $title) {
	uiGroupSetTitle($!group, $title);
}

method set-child(Libui::Control $control) {
	uiGroupSetChild($!group, $control.Control)
}

method margined() returns int32 {
	return uiGroupMargined($!group);
}

method set-margined(int32 $margined) {
	uiGroupSetMargined($!group, $margined);
}

method !WIDGET() {
	return $!group;
}
