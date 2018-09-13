use Libui::Raw :grid;
use Libui::Container;

unit class Libui::Grid is export;
also does Libui::Container;


has uiGrid $!grid;

submethod BUILD() {
  $!grid = uiNewGrid();
}

method append(Libui::Control $control
             , int32 $left
             , int32 $top
             , int32 $xspan
             , int32 $yspan
             , int32 $hexpand
             , int32 $halign
             , int32 $vexpand
             , int32 $valign
             ) {
  if $control.top-level {
    note "cannot place {$control.WHAT} into a Libui::Container";
  } else {
  uiGridAppend($!grid
              , $control.Control
              , $left, $top
              , $xspan, $yspan
              , $hexpand, $halign
              , $vexpand, $valign
              );
  }
}

method insert(Libui::Control $control
             , Libui::Control $existing
             , int32 $at
             , int32 $xspan
             , int32 $yspan
             , int32 $hexpand
             , int32 $halign
             , int32 $vexpand
             , int32 $valign
           ) {
  if $control.top-level {
    note "cannot place {$control.WHAT} into a Libui::Container";
  } else {
  uiGridInsertAt($!grid
               , $control.Control
               , $existing.Control
               , $at
               , $xspan, $yspan
               , $hexpand, $halign
               , $vexpand, $valign
               );
  }
}

multi method padded() returns int32 {
  return uiGridPadded($!grid);
}

method set-padded(int32 $padded) {
  uiGridSetPadded($!grid, $padded);
}

method set-content(Libui::Control $control
             , int32 $left
             , int32 $top
             , int32 $xspan
             , int32 $yspan
             , int32 $hexpand
             , int32 $halign
             , int32 $vexpand
             , int32 $valign
             )  {
self.append($control, $left, $top, $xspan, $yspan, $hexpand, $halign, $vexpand, $valign);
}

multi method padded(Int $padded) {
  self.set-padded($padded);
}

method !WIDGET() {
  return $!grid;
}

=begin Grid
=head2 Libui::Grid

A grid to lay out Widgets on.

=head3 Methods

C<new()>

Creates a Grid.

C<append(Libui::Control $control, int32 $left, int32 $top, int32 $xspan, int32 $yspan, int32 $hexpand, int32 $halign, int32 $vexpand, int32 $valign)>

Appends a widget to the Grid:
=item $left columns from the left
=item $top rows from the right
=item stretches across $xspan columns
=item stretches across $yspan rows
=item expand horizontally if $hexpand == 1
=item set horizontal L<alignment|#alignment> to $halign
=item expand vertically if $vexpand == 1
=item set vertical L<alignment|#alignment> to $valign


C<set-content(Libui::Control $control, int32 $left, int32 $top, int32 $xspan, int32 $yspan, int32 $hexpand, int32 $halign, int32 $vexpand, int32 $valign)>

Appends a widget to the Grid:
=item $left columns from the left
=item $top rows from the right
=item stretches across $xspan columns
=item stretches across $yspan rows
=item expand horizontally if $hexpand == 1
=item set horizontal L<alignment|#Alignment> to $halign
=item expand vertically if $vexpand == 1
=item set vertical L<alignment|#Alignment> to $valign


C<insert(Libui::Control $control, Libui::Control $existing, int32 $at, int32 $xspan, int32 $yspan, int32 $hexpand, int32 $halign, int32 $vexpand, int32 $valign)>

Inserts a widget to the Grid near $existing:
=item Positioned next to $existing based on the L<value|#positioning> of $at
=item stretches across $xspan columns
=item stretches across $yspan rows
=item expand horizontally if $hexpand == 1
=item set horizontal L<alignment|#alignment> to $halign
=item expand vertically if $vexpand == 1
=item set vertical L<alignment|#alignment> to $valign

C<padded() returns int32>

Returns the value of the padded property.

C<set-padded(int32 $padded)> or C<padded(Int $padded)>

Sets the value of the padded property.

=head4 Alignment:
=item 0: Fill
=item 1: Start
=item 2: Center
=item 3: End

=head4 Positioning:
=item 0: Left
=item 1: Top
=item 2: Right
=item 3: Bottom
=end Grid
