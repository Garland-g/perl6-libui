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

multi method text() returns Str {
	return uiLabelText($!label);
}

method set-text(Str $text) {
	uiLabelSetText($!label, $text);
}

multi method text(Str $text) {
	self.set-text($text);
}

method !WIDGET() {
	return $!label;
}
