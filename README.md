Libui
=====

Perl6 binding to [andlabs/libui](https://github.com/andlabs/libui)
------------------------------------------------------------------

### Cross-platform: Windows, Mac, Linux

This library provides an object-oriented interface to libui.

### Basic Use:

    use Libui;

    Libui-Init();
    my Libui::App $app .= new("test");
    $app.window.closing.tap({$app.exit});
    $app.run();

### Widgets Provided:

<table class="pod-table">
<thead><tr>
<th>Widget</th> <th>Description</th>
</tr></thead>
<tbody>
<tr> <td>Button</td> <td>A simple button with a label and a callback</td> </tr> <tr> <td>Checkbox</td> <td>A checkbox with a label and a callback</td> </tr> <tr> <td>Combobox</td> <td>A simple combobox with a callback</td> </tr> <tr> <td>ColorButton</td> <td>A button for selecting a color</td> </tr> <tr> <td>EditableCombobox</td> <td>A combobox that can be edited</td> </tr> <tr> <td>Entry</td> <td>Text input, can be disabled</td> </tr> <tr> <td>FontButton</td> <td>A button for selecting a font (incomplete, cannot get data out)</td> </tr> <tr> <td>Form</td> <td>A container that takes labels for its contents</td> </tr> <tr> <td>Grid</td> <td>A container that aligns widgets for window design</td> </tr> <tr> <td>Group</td> <td>A container that provides a title for a set of items</td> </tr> <tr> <td>Label</td> <td>Displays a single line of text</td> </tr> <tr> <td>Menu</td> <td>Creates a single column of an application menu</td> </tr> <tr> <td>MultilineEntry</td> <td>An entry that allows multiple lines</td> </tr> <tr> <td>Time and Date Choosers</td> <td>Allows choosing of a date and/or time (incomplete, cannot get data out)</td> </tr> <tr> <td>ProgressBar</td> <td>Displays a progress bar (incomplete, can only set progress)</td> </tr> <tr> <td>RadioButton</td> <td>A set of radio buttons with a callback</td> </tr> <tr> <td>Separator</td> <td>A simple vertical or horizontal separator</td> </tr> <tr> <td>Slider</td> <td>A draggable slider for choosing a value in a range</td> </tr> <tr> <td>Spinbox</td> <td>A numerical input with a minimum and maximum range</td> </tr> <tr> <td>Tab</td> <td>A set named tabs for placing items in</td> </tr> <tr> <td>Window</td> <td>Contains all the other widgets, cannot be embedded in a container</td> </tr> <tr> <td>VBox, HBox</td> <td>A vertical or horizontal box for grouping items</td> </tr>
</tbody>
</table>

#### Install from CPAN with:

`zef install Libui`

Examples:
---------

### Controlgallery Tab: Basic Controls

#### Linux

![](./examples/controlgallery-linux.png)

#### Windows

![](./examples/controlgallery-windows.png)

#### Macos

![](./examples/controlgallery-macos.png)

### License

[Artistic License 2.0](./LICENSE)

