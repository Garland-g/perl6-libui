use Libui::Raw :group;
use Libui::Container;

unit class Libui::Group;
also does Libui::Container;

has uiGroup $!group;

submethod BUILD(Str :$title) {
	$!group = uiNewGroup($title);
}

multi method new(Str $title) {
	self.bless(:$title);
}

multi method title() returns Str {
	uiGroupTitle($!group);
}

method set-title(Str $title) {
	uiGroupSetTitle($!group, $title);
}

multi method title(Str $title) {
	self.set-title($title);
}

method set-child(Libui::Control $control) {
	if $control.top-level {			
		note "cannot place {$control.WHAT} into a Libui::Container";
	} else {
		uiGroupSetChild($!group, $control.Control)
	}
}

method set-content(Libui::Control $control) {
	self.set-child($control);
}

multi method margined() returns int32 {
	return uiGroupMargined($!group);
}

method set-margined(int32 $margined) {
	uiGroupSetMargined($!group, $margined);
}

multi method margined(Int $margined) {
	self.set-margined($margined);	
}

method !WIDGET() {
	return $!group;
}
