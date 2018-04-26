use v6;
use Libui::Raw;
#use Libui::Control;
use Libui::Container;

role Libui::Box {
#	also does Libui::Control;
	also does Libui::Container;

	has uiBox $!box;

	#multi method append(@control, @stretchy) {
		#for @control.kv -> $i, $control {
			#if $i < @stretchy.elems {
				#	uiBoxAppend(self.WIDGET, $control.WIDGET, @stretchy[$i]);
				#}	else {
				#uiBoxAppend(self.WIDGET, $control.WIDGET, @stretchy[*-1]);
				#}
			#}
		#}

	method append(Libui::Control $control, int32 $stretchy) {
		uiBoxAppend($!box, $control.Control, $stretchy);
	}

	method delete-item(int32:D $index) {
		uiBoxDelete($!box, $index);
	}

	method content(Libui::Control $control, int32:D :$stretchy) {
		self.append($control, $stretchy);
	}

	method padded() returns int32 {
		return uiBoxPadded($!box);
	}

	method set-padded(int32:D $padded) {
		uiBoxSetPadded($!box, $padded);
	}

	method !WIDGET() {
		return $!box;
	}
}

class Libui::HBox is export {
	also does Libui::Box;

	submethod BUILD() {
		$!box = uiNewHorizontalBox();
	}
}

class Libui::VBox is export {
	also does Libui::Box;

	submethod BUILD() {
		$!box = uiNewVerticalBox();
	}
}
