use Libui::Raw :lib;
use Libui::Control;
use Libui::Container;

use NativeCall;

unit class Libui::Group;
also does Libui::Container;

class uiGroup is repr('CStruct') is export(:raw) {
  also does autocast;
  has Pointer $.uiGroupTitle;
  has Pointer $.uiGroupSetTitle;
  has Pointer $.uiGroupSetChild;
  has Pointer $.uiGroupMargined;
  has Pointer $.uiGroupSetMargined;
  has Pointer $.uiNewGroup;
}

sub uiGroupTitle(uiGroup $g)
  returns Str
  is native(LIB)
  is export(:raw)
  { * }


sub uiGroupSetTitle(uiGroup $g, Str $title)
  is native(LIB)
  is export(:raw)
  { * }


sub uiGroupSetChild(uiGroup $g, uiControl $c)
  is native(LIB)
  is export(:raw)
  { * }


sub uiGroupMargined(uiGroup $g)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiGroupSetMargined(uiGroup $g, int32 $margined)
  is native(LIB)
  is export(:raw)
  { * }


sub uiNewGroup(Str $title)
  returns uiGroup
  is native(LIB)
  is export(:raw)
  { * }



has uiGroup $!group;

submethod BUILD(Str:D :$title) {
  $!group = uiNewGroup($title);
}

multi method new(Str $title) {
  self.bless(:$title);
}

multi method new(Str :$title) {
  self.bless(:$title);
}

multi method title() returns Str {
  uiGroupTitle($!group);
}

method set-title(Str:D $title) {
  uiGroupSetTitle($!group, $title);
}

multi method title(Str:D $title) {
  self.set-title($title);
}

method set-child(Libui::Control $control) {
  if $control.top-level {
    note "cannot place {$control.WHAT} into a Libui::Container";
  } else {
    uiGroupSetChild($!group, $control.Control)
  }
}

method set-content(Libui::Control $control) {
  self.set-child($control);
}

multi method margined() returns Bool {
  return uiGroupMargined($!group).Bool;
}

method set-margined(Bool:D(Int) $margined) {
  uiGroupSetMargined($!group, $margined);
}

multi method margined(Bool:D(Int) $margined) {
  self.set-margined($margined);
}

method !WIDGET() {
  return $!group;
}
=begin Group
=head2 Libui::Group

A container that provides a title for a set of items. Can only have one child, which can be a container like a L<Box|https://github.com/Garland-g/perl6-libui/wiki/Box>.

=head3 Methods

C<new(Str $title)>

Creates a Group.

C<title() returns Str>

Gets the title of the Group.

C<set-title(Str $title)> or C<title(Str $title)>

Sets the title of the Group.

C<set-child(Libui::Control $control)> or C<set-content(Libui::Control $control)>

Sets $control as the child of the Group.

C<margined() returns Bool>

Returns the value of the margined property.

C<set-margined(Bool:D(Int) $margined)> or C<margined(Bool:D(Int) $margined)>

Sets the value of the margined property.

=end Group
