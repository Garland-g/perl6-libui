use Libui::Raw :lib;
use Libui::Control;
use Libui::Container;

use NativeCall;

unit class Libui::Tab;
also does Libui::Container;

class uiTab is repr('CStruct') is export(:raw) {
  also does autocast;
  #has Pointer $.c;
  #has Pointer $.widget;
  #has Pointer $.container;
  #has Pointer $.notebook;
  #has Pointer $.pages;
  has Pointer $.uiTabAppend;
  has Pointer $.uiTabInsertAt;
  has Pointer $.uiTabDelete;
  has Pointer $.uiTabNumPages;
  has Pointer $.uiTabMargined;
  has Pointer $.uiNewTab;
}

sub uiTabAppend(uiTab $t, Str $name, uiControl $c)
  is native(LIB)
  is export(:raw)
  { * }


sub uiTabInsertAt(uiTab $t, Str $name, uint32 $before, uiControl $c)
  is native(LIB)
  is export(:raw)
  { * }


sub uiTabDelete(uiTab $t, uint32 $index)
  is native(LIB)
  is export(:raw)
  { * }


sub uiTabNumPages(uiTab $t)
  returns uint32
  is native(LIB)
  is export(:raw)
  { * }


sub uiTabMargined(uiTab $t, uint32 $page)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiTabSetMargined(uiTab $t, uint32 $page, int32 $margined)
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewTab()
  returns uiTab
  is native(LIB)
  is export(:raw)
  { * }




has uiTab $!tab;

submethod BUILD() {
  $!tab = uiNewTab();
}

method append(Str:D $name, Libui::Control $control) {
  if $control.top-level {
    note "cannot place {$control.WHAT} into a Libui::Container";
  } else {
    uiTabAppend($!tab, $name, $control.Control);
  }
}

method insert(Str:D $name, UInt $before, Libui::Control $control) {
  if $control.top-level {
    note "cannot place {$control.WHAT} into a Libui::Container";
  } else {
    uiTabInsertAt($!tab, $name, $before, $control.Control);
  }
}

method set-content(Str:D $name, Libui::Control $control) {
  self.append($name, $control);
}

method delete-item(UInt $page) {
  if $page < self.pages {
    uiTabDelete($!tab, $page);
  } else {
    die "This tab has {self.pages} page(s). Cannot delete page $page.";
  }
}

method pages() returns UInt {
  uiTabNumPages($!tab);
}

multi method margined(UInt $page) returns Bool {
  uiTabMargined($!tab, $page).Bool;
}

method set-margined(UInt $page, Bool:D(Int) $margined) {
  uiTabSetMargined($!tab, $page, $margined);
}

multi method margined(Int $page, Bool:D(Int) $margined) {
  self.set-margined($page, $margined);
}
method !WIDGET() {
  return $!tab;
}

=begin Tab
=head2 Libui::Tab

A set of named pages for placing items in.

=head3 Methods

C<new()>

Creates a Tab.

C<set-content(Str:D $name, Libui::Control $control> or C<append(Str $name, Libui::Control $control)>

Appends a new page and places the widget $control inside it.

C<insert(Str:D $name, UInt $before, Libui::Control $control)>

Inserts a new page into slot $before and places the widget $control inside it.

C<delete-item(UInt $page)>

Deletes the page in slot $page.

C<pages() returns UInt>

Returns the number of pages.

C<margined(UInt $page) returns Bool>

Returns the margined property of page $page.

C<set-margined(UInt $page, Bool:D(Int) $margined)> or C<margined(Int $page, Bool:D(Int) $margined)>

Sets the margined property of page $page.
=end Tab
