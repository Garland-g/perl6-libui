use Libui::Raw;
#use Libui::Control;
use Libui::Container;

unit class Libui::Grid is export;
#also does Libui::Control;
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
 uiGridAppend($!grid
							, $control.Control
							, $left, $top
							, $xspan, $yspan
							, $hexpand, $halign
							, $vexpand, $valign
							);
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
	uiGridInsertAt($!grid
							 , $control.Control
							 , $existing.Control
							 , $at
							 , $xspan, $yspan
							 , $hexpand, $halign
							 , $vexpand, $valign
							 );
}	

method padded() returns int32 {
	return uiGridPadded($!grid);
}

method set-padded(int32 $padded) {
	uiGridSetPadded($!grid, $padded);
}

method !WIDGET() {
	return $!grid;
}



