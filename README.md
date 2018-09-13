Libui
=====

Perl6 binding to [andlabs/libui](https://github.com/andlabs/libui)
------------------------------------------------------------------

andlabs/libui is currently alpha software. This binding works with the current release, 0.4.1. It does not have full functionality, and is subject to change as andlabs/libui changes underneath it. The raw bindings accessible in Libui::Raw should be feature-complete, but only some widgets have an object-oriented implementation.

### Cross-platform: Windows, Mac, Linux

This library provides an object-oriented interface to libui. Shared libraries ui.dll, libui.dylib, and libui.so are provided in resources.

Windows requires the [64-bit 2015 Visual C++ Redistributable](https://www.microsoft.com/en-us/download/details.aspx?id=53587) to properly function.

### Basic Use:

    use Libui;

    Libui::Init;
    my Libui::App $app .= new("test");

    #This allows the window to be closed
    #when the titlebar's close button is clicked
    $app.window.closing.tap({$app.exit});

    $app.run();

### Widgets Provided:

<table class="pod-table">
<thead><tr>
<th>Widget</th> <th>Description</th>
</tr></thead>
<tbody>
<tr> <td>Button</td> <td>A button with a label</td> </tr> <tr> <td>Checkbox</td> <td>A checkbox with a label</td> </tr> <tr> <td>Combobox</td> <td>A simple combobox</td> </tr> <tr> <td>ColorButton</td> <td>A button for selecting a color</td> </tr> <tr> <td>EditableCombobox</td> <td>A combobox that can be edited</td> </tr> <tr> <td>Entry</td> <td>Text input, can be disabled</td> </tr> <tr> <td>FontButton</td> <td>A button for selecting a font (Incomplete: Cannot set programmatically)</td> </tr> <tr> <td>Form</td> <td>A container that takes labels for its contents</td> </tr> <tr> <td>Grid</td> <td>A container that aligns widgets for window design</td> </tr> <tr> <td>Group</td> <td>A container that provides a title for a set of items</td> </tr> <tr> <td>Label</td> <td>Displays a single line of text</td> </tr> <tr> <td>Menu</td> <td>Creates a single column of an application menu</td> </tr> <tr> <td>MultilineEntry</td> <td>An entry that allows multiple lines</td> </tr> <tr> <td>Time and Date Pickers</td> <td>Allows choosing of a date and/or time</td> </tr> <tr> <td>ProgressBar</td> <td>Displays a progress bar</td> </tr> <tr> <td>RadioButton</td> <td>A set of radio buttons</td> </tr> <tr> <td>Separator</td> <td>A simple vertical or horizontal separator</td> </tr> <tr> <td>Slider</td> <td>A draggable slider for choosing a value in a range</td> </tr> <tr> <td>Spinbox</td> <td>A numerical input with a minimum and maximum range</td> </tr> <tr> <td>Tab</td> <td>A set named tabs for placing items in</td> </tr> <tr> <td>Window</td> <td>Contains any other widget, cannot be embedded in a container</td> </tr> <tr> <td>VBox, HBox</td> <td>A vertical or horizontal box for grouping items</td> </tr>
</tbody>
</table>

#### Install from CPAN with:

`zef install Libui`

#### Documentation

View on the web: [https://github.com/Garland-g/perl6-libui/wiki](https://github.com/Garland-g/perl6-libui/wiki)

Use p6doc: e.g. `p6doc Libui::Button`

Examples:
---------

### Controlgallery Tab: Basic Controls

#### Linux

[./examples/controlgallery-linux.png](./examples/controlgallery-linux.png)

#### Windows

[./examples/controlgallery-windows.png](./examples/controlgallery-windows.png)

#### Macos

[./examples/controlgallery-macos.png](./examples/controlgallery-macos.png)

### License

[Artistic License 2.0](./LICENSE)

### Author

Travis Gibson

