use Libui::Raw;
#use Libui::Control;
use Libui::Container;

unit class Libui::Tab;
#also does Libui::Control;
also does Libui::Container;

has uiTab $!tab;

submethod BUILD() {
	$!tab = uiNewTab();
}

method append(Str $name, Libui::Control $control) {
	uiTabAppend($!tab, $name, $control.Control);
}

method insert(Str $name, int32 $before, Libui::Control $control) {
	uiTabInsertAt($!tab, $name, $before, $control.Control);
}

method delete-item(int32 $page) {
	uiTabDelete($!tab, $page);
}

method pages() returns int32 {
	uiTabNumPages($!tab);
}

method margined(int32 $page) returns int32 {
	uiTabMargined($!tab, $page);
}

method set-margined(int32 $page, int32 $margined) {
	uiTabSetMargined($!tab, $page, $margined);
}

method !WIDGET() {
	return $!tab;
}
