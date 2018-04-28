use Libui::Raw;
use Libui::Control;

############################################################
#																													 #
#									(Version 0.3.5-alpha)										 #
#					Not fully implemented in libui yet!							 #
#			Can spawn a widget, but cannot get data out.				 #
#																													 #
#																													 #
############################################################

#class Lubui::FontDescriptor {
#	has $!desc;
#
#	submethod BUILD(uiFontDescriptor :$desc) {
#		$!desc = $desc;
#	}
#
#	method family returns Str {
#		return $!desc
#	}
#}

class Libui::FontButton does Libui::Control is export {

	has uiFontButton $!button;
	has uiDrawTextFontDescriptor $!desc;
	has $!changed-supply;

	submethod BUILD() {
		$!button = uiNewFontButton();
	}

#submethod DESTROY() {
#	uiFreeFontButtonFont($!desc);
#}
#
	method font() {
		uiDrawTextFontDescribe(uiFontButtonFont($!button), $!desc);
	}
###Current Error: Cannot look up attributes in $!desc
#	method family() returns Str {
#		return $!desc.Family();
#	}

#	method size() returns num64 {
#		return $!desc.Size();
#	}

#	method weight() returns uint32 {
#		return $!desc.Weight();
#	}

#	method italic() returns uint32 {
#		return $!desc.Italic();
#	}

#	method stretch() returns uint32 {
#		return $!desc.Stretch();
#	}

	method changed() {
		$!changed-supply //= do {
			my $s = Supplier.new;
			uiFontButtonOnChanged($!button, -> $, $ {
				$s.emit(self);
				CATCH { default { note $_; } }
			},
			Str);
			return $s.Supply;
		}
	}

	method !WIDGET() {
		return $!button;
	}
}
