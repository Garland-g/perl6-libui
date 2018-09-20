use Libui::Raw :grid;
use Libui::Container;
use Libui::Types;

unit class Libui::Grid is export;
also does Libui::Container;


has uiGrid $!grid;

submethod BUILD() {
  $!grid = uiNewGrid();
}

method append(Libui::Control $control
             , UInt:D $left
             , UInt:D $top
             , UInt:D $xspan
             , UInt:D $yspan
             , Bool:D(Int) $hexpand
             , Align $halign
             , Bool:D(Int) $vexpand
             , Align $valign
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
             , At $at
             , UInt:D $xspan
             , UInt:D $yspan
             , Bool:D(Int) $hexpand
             , Align $halign
             , Bool:D(Int) $vexpand
             , Align $valign
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

multi method padded() returns Bool {
  return uiGridPadded($!grid).Bool;
}

method set-padded(Bool:D(Int) $padded) {
  uiGridSetPadded($!grid, $padded);
}

method set-content(Libui::Control $control
             , UInt:D $left
             , UInt:D $top
             , UInt:D $xspan
             , UInt:D $yspan
             , Bool:D(Int) $hexpand
             , Align $halign
             , Bool:D(Int) $vexpand
             , Align $valign
             )  {
self.append($control, $left, $top, $xspan, $yspan, $hexpand, $halign, $vexpand, $valign);
}

multi method padded(Bool:D(Int) $padded) {
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

C<append(Libui::Control $control, UInt:D $left, UInt:D $top, UInt:D $xspan, UInt:D $yspan, Bool:D(Int) $hexpand, Align $halign, Bool:D(Int) $vexpand, Align $valign)>

Appends a widget to the Grid:
=item $left columns from the left
=item $top rows from the right
=item stretches across $xspan columns
=item stretches across $yspan rows
=item expand horizontally if $hexpand
=item set horizontal L<alignment|#alignment> to $halign
=item expand vertically if $vexpand
=item set vertical L<alignment|#alignment> to $valign


C<set-content(Libui::Control $control, UInt:D $left, UInt:D $top, UInt:D $xspan, UInt:D $yspan, Bool:D(Int) $hexpand, Align $halign, Bool:D(Int) $vexpand, Align $valign)>

Appends a widget to the Grid:
=item $left columns from the left
=item $top rows from the right
=item stretches across $xspan columns
=item stretches across $yspan rows
=item expand horizontally if $hexpand
=item set horizontal L<alignment|#Alignment> to $halign
=item expand vertically if $vexpand
=item set vertical L<alignment|#Alignment> to $valign


C<insert(Libui::Control $control, Libui::Control $existing, At $at, UInt:D $xspan, UInt:D $yspan, Bool:D(Int) $hexpand, Align $halign, Bool:D(Int) $vexpand, Align $valign)>

Inserts a widget to the Grid near $existing:
=item Positioned next to $existing based on the L<value|#positioning> of $at
=item stretches across $xspan columns
=item stretches across $yspan rows
=item expand horizontally if $hexpand
=item set horizontal L<alignment|#alignment> to $halign
=item expand vertically if $vexpand
=item set vertical L<alignment|#alignment> to $valign

C<padded() returns Bool>

Returns the value of the padded property.

C<set-padded(Bool:D(Int) $padded)> or C<padded(Bool:D(Int) $padded)>

Sets the value of the padded property.



=head4 L<Alignment|https://github.com/Garland-g/perl6-libui/wiki/Types#align>:
=item 0: Fill
=item 1: Start
=item 2: Center
=item 3: End

=head4 L<Positioning|https://github.com/Garland-g/perl6-libui/wiki/Types#at>:
=item 0: Left
=item 1: Top
=item 2: Right
=item 3: Bottom
=end Grid
