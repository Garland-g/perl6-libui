use Libui::Raw;
use Libui::Control;

unit class Libui::ProgressBar does Libui::Control;

has uiProgressBar $!pbar;
has $!value-changed;

submethod BUILD() {
	$!pbar = uiNewProgressBar();
}

#Method not implemented in upstream
# TODO Enable when implemented
#method value() returns int32 { 
#	uiProgressBarValue($!pbar);
#}


method set-value(int32 $value) {
	uiProgressBarSetValue($!pbar, $value);
}

method !WIDGET() {
	return $!pbar;
}
