#!/usr/bin/env perl6
use v6;
use Libui;

sub MAIN() {
  Libui::Init();
  my Libui::Menu $file .= new("File");
  my Libui::MenuItem $open = $file.append-item("Open");
  my Libui::MenuItem $save = $file.append-item("Save");
  my Libui::MenuItem $quit = $file.append-quit-item;

  my Libui::Menu $edit .= new("Edit");
  my Libui::MenuItem $checkable = $edit.append-check-item("Checkable Item");
  $edit.append-separator;
  my Libui::MenuItem $disabled = $edit.append-item("Disabled");
  $disabled.disable;
  my Libui::MenuItem $preferences = $edit.append-preferences-item;

  my Libui::Menu $help .= new("Help");
  my Libui::MenuItem $help-item = $help.append-item("Help");
  my Libui::MenuItem $about = $help.append-about-item;


  my $app = Libui::App.new(title => "libui Control Gallery", width => 640, height => 480, has-menubar => 1);
  $app.root.closing.tap({ $app.exit });
  $quit.clicked.tap({$app.exit});
  my $window = $app.root;
  $window.set-margined(1);
  $open.clicked.tap( {
    my Str $filename;

    $filename = $window.open();
    if $filename {
      $window.msg-box("File selected", $filename);
    } else {
      $window.msg-box-err("No file selected", "Don't be alarmed");
    }
  });
  $save.clicked.tap( {
    my Str $filename;

    $filename = $window.save();
    if $filename {
      $window.msg-box("File selected (don't worry, it's still there)", $filename);
    } else {
      $window.msg-box-err("No file selected", "Don't be alarmed");
    }
  });

  my Libui::VBox $box .= new;
  $box.set-padded(1);
  $app.set-content($box);

  my Libui::HBox $hbox .= new;
  $hbox.set-padded(1);
  $box.append($hbox, 1);

  my Libui::Group $group .= new("Basic Controls");
  $group.set-margined(1);
  $hbox.append($group, 0);

  my Libui::VBox $inner .= new;
  $inner.set-padded(1);
  $group.set-child($inner);

  $inner.append(Libui::Button.new("Button"), 0);
  $inner.append(Libui::Checkbox.new("Checkbox"), 0);
  my Libui::Entry $entry .= new;
  $entry.set-text("Entry");
  $inner.append($entry, 0);
  $inner.append(Libui::Label.new("Label"), 0);

  $inner.append(Libui::HSeparator.new, 0);

  $inner.append(Libui::DatePicker.new, 0);
  $inner.append(Libui::TimePicker.new, 0);
  $inner.append(Libui::DateTimePicker.new, 0);

  $inner.append(Libui::FontButton.new, 0);

  $inner.append(Libui::ColorButton.new, 0);

  my Libui::VBox $inner2 .= new;
  $inner2.set-padded(1);
  $hbox.append($inner2, 1);

  $group .= new("Numbers");
  $group.set-margined(1);
  $inner2.append($group, 0);

  $inner .= new;
  $inner.set-padded(1);
  $group.set-child($inner);

  my Libui::Spinbox $spinbox .= new(0, 100);
  my Libui::Slider $slider .= new(0, 100);
  my Libui::ProgressBar $progressbar .= new;

  $spinbox.changed.tap( -> $spin {
    $slider.set-value($spin.value);
    $progressbar.set-value($spin.value);
  });

  $slider.changed.tap( -> $slide {
    $spinbox.set-value($slide.value);
    $progressbar.set-value($slide.value);
  });

  $inner.append($spinbox, 0);
  $inner.append($slider, 0);
  $inner.append($progressbar, 0);

  $group .= new("Lists");
  $group.set-margined(1);
  $inner2.append($group, 0);

  $inner .= new;
  $inner.set-padded(1);
  $group.set-child($inner);

  my Libui::Combobox $cbox .= new;
  $cbox.append("Combobox Item 1");
  $cbox.append("Combobox Item 2");
  $cbox.append("Combobox Item 3");
  $inner.append($cbox, 0);

  my Libui::EditableCombobox $ecbox .= new;
  $ecbox.append("Editable Item 1");
  $ecbox.append("Editable Item 2");
  $ecbox.append("Editable Item 3");
  $inner.append($ecbox, 0);

  my Libui::RadioButton $rb .= new;
  $rb.append("Radio Button 1");
  $rb.append("Radio Button 2");
  $rb.append("Radio Button 3");

  my $tab = Libui::Tab.new;
  $tab.append("Page 1", Libui::HBox.new);
  $tab.append("Page 2", Libui::HBox.new);
  $tab.append("Page 3", Libui::HBox.new);
  $inner2.append($tab, 1);

  $app.run();
}
