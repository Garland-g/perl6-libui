use Libui::Raw;
use Libui::Control;

unit class Libui::Label
	does Libui::Control;

has uiLabel $!label;

submethod BUILD(Str :$text) {
	$!label = uiNewLabel($text);
}

multi method new(Str $text){
	self.bless(:$text);
}

method text() returns Str {
	return uiLabelText($!label);
}

method set-text(Str $text) {
	uiLabelSetText($!label, $text);
}

method !WIDGET() {
	return $!label;
}
