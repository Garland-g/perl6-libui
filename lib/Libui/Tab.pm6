use Libui::Raw :tab;
use Libui::Container;

unit class Libui::Tab;
also does Libui::Container;

has uiTab $!tab;

submethod BUILD() {
  $!tab = uiNewTab();
}

method append(Str $name, Libui::Control $control) {
  if $control.top-level {
    note "cannot place {$control.WHAT} into a Libui::Container";
  } else {
    uiTabAppend($!tab, $name, $control.Control);
  }
}

method insert(Str $name, int32 $before, Libui::Control $control) {
  if $control.top-level {
    note "cannot place {$control.WHAT} into a Libui::Container";
  } else {
    uiTabInsertAt($!tab, $name, $before, $control.Control);
  }
}

method set-content(Str $name, Libui::Control $control) {
  self.append($name, $control);
}

method delete-item(int32 $page) {
  uiTabDelete($!tab, $page);
}

method pages() returns int32 {
  uiTabNumPages($!tab);
}

method !margined(int32 $page) returns int32 {
  uiTabMargined($!tab, $page);
}

method set-margined(int32 $page, int32 $margined) {
  uiTabSetMargined($!tab, $page, $margined);
}

multi method margined(Int $page) returns int32 {
  self!margined($page);
}

multi method margined(Int $page, Int $margined) {
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

C<set-content(Str $name, Libui::Control $control> or C<append(Str $name, Libui::Control $control)>

Appends a new page and places the widget $control inside it.

C<insert(Str $name, int32 $before, Libui::Control $control)>

Inserts a new page into slot $before and places the widget $control inside it.

C<delete-item(int32 $page)>

Deletes the page in slot $page.

C<pages() returns int32>

Returns the number of pages.

C<margined(Int $page) returns int32>

Returns the margined property of page $page.

C<set-margined(int32 $page, int32 $margined)> or C<margined(Int $page, Int $margined)>

Sets the margined property of page $page.
=end Tab
