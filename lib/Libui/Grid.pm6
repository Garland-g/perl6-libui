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



