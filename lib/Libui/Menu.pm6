use Libui::Raw :menu;
use Libui::MenuItem;
use Libui::Control;
unit class Libui::Menu does Libui::Control;

has uiMenu $!menu;

submethod BUILD(Str:D :$name) {
  $!menu = uiNewMenu($name);
}

multi method new(Str:D $name) {
  self.bless(:$name);
}

method append-item(Str:D $name) returns Libui::MenuItem {
  return Libui::MenuItem.new(uiMenuAppendItem($!menu, $name));
}

method append-check-item(Str:D $name) returns Libui::MenuItem {
  return Libui::MenuItem.new(uiMenuAppendCheckItem($!menu, $name));
}

method append-quit-item() returns Libui::MenuItem {
  return Libui::QuitItem.new(uiMenuAppendQuitItem($!menu));
}

method append-preferences-item() returns Libui::MenuItem {
  return Libui::MenuItem.new(uiMenuAppendPreferencesItem($!menu));
}

method append-about-item() returns Libui::MenuItem {
  return Libui::MenuItem.new(uiMenuAppendAboutItem($!menu));
}

method append-separator() {
  uiMenuAppendSeparator($!menu);
}

method !WIDGET() {
  return $!menu;
}

=begin Menu

=head2 Libui::Menu

Creates a menubar. Must be fully finished creating the menu before creating the L<App|https://github.com/Garland-g/perl6-libui/wiki/App>.

Order is important. To create a single Menu e.g. "File", create a Libui::Menu with the name "File". Each new Menu created will be added to the right of the most recently created menu.

Almost all of the Menu methods return L<MenuItems|https://github.com/Garland-g/perl6-libui/wiki/MenuItem>.

Example:

=begin code
    Libui::Init();
    my Libui::Menu $file .= new("File");
    my Libui::MenuItem $open = $file.append-item("Open");
    my Libui::MenuItem $save = $file.append-item("Save");
    my Libui::MenuItem $quit = $file.append-quit-item;

    my Libui::Menu $edit .= new("Edit");
    my Libui::MenuItem $preferences = $edit.append-preferences-item;

    my Libui::Menu $help .= new("Help");
    my Libui::MenuItem $help-item = $help.append-item("Help");
    my Libui::MenuItem $about = $help.append-about-item;
=end code

This will create:
* "File" menu with "Open", "Save", and "Quit" items
* "Edit" menu with a "Preferences" item
* "Help" menu with a "Help" item and an "About" item

Laid out in the menubar like this:

C<File Edit Help>

Libui will move the "About", "Quit", and "Preferences" items to their proper spots on MacOS automatically.

=head3 Methods

C<new(Str $name)>

Creates a new Menu.

C<append-item(Str:D $name) returns Libui::MenuItem>

Appends a new Menuitem to the Menu and returns it.

C<append-check-item(Str:D $name) returns Libui::MenuItem>

Appends a new Checkable MenuItem to the Menu and returns it.

C<append-quit-item() returns Libui::MenuItem>

Appends a MenuItem with the name "Quit" to the Menu and returns it.

C<append-preferences-item() returns Libui::MenuItem>

Appends a MenuItem with the name "Preferences" to the Menu and returns it.

C<append-about-item() returns Libui::MenuItem>

Appends a MenuItem with the name "About" to the Menu and returns it.

C<append-separator()>

Appends a horizontal separator to the Menu.

=end Menu
