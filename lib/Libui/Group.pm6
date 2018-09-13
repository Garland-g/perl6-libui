use Libui::Raw :group;
use Libui::Container;

unit class Libui::Group;
also does Libui::Container;

has uiGroup $!group;

submethod BUILD(Str :$title) {
  $!group = uiNewGroup($title);
}

multi method new(Str $title) {
  self.bless(:$title);
}

multi method title() returns Str {
  uiGroupTitle($!group);
}

method set-title(Str $title) {
  uiGroupSetTitle($!group, $title);
}

multi method title(Str $title) {
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

multi method margined() returns int32 {
  return uiGroupMargined($!group);
}

method set-margined(int32 $margined) {
  uiGroupSetMargined($!group, $margined);
}

multi method margined(Int $margined) {
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

C<margined() returns int32>

Returns the value of the margined property.

C<set-margined(int32 $margined)> or C<margined(Int $margined)>

Sets the value of the margined property.

=end Group
