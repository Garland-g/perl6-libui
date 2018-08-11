use Libui::Raw :tab;
use Libui::Container;

unit class Libui::Tab;
also does Libui::Container;

has uiTab $!tab;

submethod BUILD() {
	$!tab = uiNewTab();
}

method append(Str $name, Libui::Control $control) {
	if $control.top-level {
		note "cannot place {$control.WHAT} into a Libui::Container";
	} else {
		uiTabAppend($!tab, $name, $control.Control);
	}
}

method insert(Str $name, int32 $before, Libui::Control $control) {
	if $control.top-level {
		note "cannot place {$control.WHAT} into a Libui::Container";
	} else {
		uiTabInsertAt($!tab, $name, $before, $control.Control);
	}
}

method set-content(Str $name, Libui::Control $control) {
	self.append($name, $control);
}

method delete-item(int32 $page) {
	uiTabDelete($!tab, $page);
}

method pages() returns int32 {
	uiTabNumPages($!tab);
}

method !margined(int32 $page) returns int32 {
	uiTabMargined($!tab, $page);
}

method set-margined(int32 $page, int32 $margined) {
	uiTabSetMargined($!tab, $page, $margined);
}

multi method margined(Int $page) returns int32 {
	self!margined($page);
}

multi method margined(Int $page, Int $margined) {
	self.set-margined($page, $margined);
}
method !WIDGET() {
	return $!tab;
}
