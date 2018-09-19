use Libui::Raw :progbar;
use Libui::Control;

unit class Libui::ProgressBar does Libui::Control;

has uiProgressBar $!pbar;

submethod BUILD() {
  $!pbar = uiNewProgressBar();
}

multi method value() returns Int {
  uiProgressBarValue($!pbar);
}

method set-value(Int $value where -1 <= * <= 100) {
  uiProgressBarSetValue($!pbar, $value);
}

multi method value(Int $value) {
  self.set-value($value);
}

method !WIDGET() {
  return $!pbar;
}

=begin ProgressBar
=head2 Libui::ProgressBar

A progress bar. Shows a percentage of completion, or an indeterminate ProgressBar.

=head3 Methods

C<new()>

Creates a ProgressBar.

C<value() returns Int>

Returns the current value of the ProgressBar.

C<set-value(Int $value)> or C<value(Int $value)>

Sets the value of the ProgressBar. Values between 0 and 100 displays that percentage, and -1 displays an indeterminate ProgressBar.
=end ProgressBar
