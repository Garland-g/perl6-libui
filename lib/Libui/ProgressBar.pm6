use Libui::Raw :progbar;
use Libui::Control;

unit class Libui::ProgressBar does Libui::Control;

has uiProgressBar $!pbar;

submethod BUILD() {
  $!pbar = uiNewProgressBar();
}

multi method value() returns int32 {
  uiProgressBarValue($!pbar);
}

method set-value(int32 $value) {
  uiProgressBarSetValue($!pbar, $value);
}

multi method value(Int $value) {
  self.set-value($value);
}

method !WIDGET() {
  return $!pbar;
}
