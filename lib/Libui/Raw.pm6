use v6;

unit module Libui::Raw;

use NativeCall;

constant \LIB = %?RESOURCES<libraries/ui>;

## Enumerations

enum uiDrawBrushType is export(:draw) (
   uiDrawBrushTypeSolid => 0,
   uiDrawBrushTypeLinearGradient => 1,
   uiDrawBrushTypeRadialGradient => 2,
   uiDrawBrushTypeImage => 3
);
enum uiDrawLineCap is export(:draw) (
   uiDrawLineCapFlat => 0,
   uiDrawLineCapRound => 1,
   uiDrawLineCapSquare => 2
);
enum uiDrawLineJoin is export(:draw) (
   uiDrawLineJoinMiter => 0,
   uiDrawLineJoinRound => 1,
   uiDrawLineJoinBevel => 2
);
enum uiDrawFillMode is export(:draw) (
   uiDrawFillModeWinding => 0,
   uiDrawFillModeAlternate => 1
);
enum uiDrawTextWeight is export(:draw) (
   uiDrawTextWeightThin => 0,
   uiDrawTextWeightUltraLight => 1,
   uiDrawTextWeightLight => 2,
   uiDrawTextWeightBook => 3,
   uiDrawTextWeightNormal => 4,
   uiDrawTextWeightMedium => 5,
   uiDrawTextWeightSemiBold => 6,
   uiDrawTextWeightBold => 7,
   uiDrawTextWeightUtraBold => 8,
   uiDrawTextWeightHeavy => 9,
   uiDrawTextWeightUltraHeavy => 10
);
enum uiDrawTextItalic is export(:draw) (
   uiDrawTextItalicNormal => 0,
   uiDrawTextItalicOblique => 1,
   uiDrawTextItalicItalic => 2
);
enum uiDrawTextStretch is export(:draw) (
   uiDrawTextStretchUltraCondensed => 0,
   uiDrawTextStretchExtraCondensed => 1,
   uiDrawTextStretchCondensed => 2,
   uiDrawTextStretchSemiCondensed => 3,
   uiDrawTextStretchNormal => 4,
   uiDrawTextStretchSemiExpanded => 5,
   uiDrawTextStretchExpanded => 6,
   uiDrawTextStretchExtraExpanded => 7,
   uiDrawTextStretchUltraExpanded => 8
);
enum uiModifier is export(:DEFAULT) (
   uiModifierCtrl => 1,
   uiModifierAlt => 2,
   uiModifierShift => 4,
   uiModifierSuper => 8
);
enum uiExtKey is export(:DEFAULT) (
   uiExtKeyEscape => 1,
   uiExtKeyInsert => 2,
   uiExtKeyDelete => 3,
   uiExtKeyHome => 4,
   uiExtKeyEnd => 5,
   uiExtKeyPageUp => 6,
   uiExtKeyPageDown => 7,
   uiExtKeyUp => 8,
   uiExtKeyDown => 9,
   uiExtKeyLeft => 10,
   uiExtKeyRight => 11,
   uiExtKeyF1 => 12,
   uiExtKeyF2 => 13,
   uiExtKeyF3 => 14,
   uiExtKeyF4 => 15,
   uiExtKeyF5 => 16,
   uiExtKeyF6 => 17,
   uiExtKeyF7 => 18,
   uiExtKeyF8 => 19,
   uiExtKeyF9 => 20,
   uiExtKeyF10 => 21,
   uiExtKeyF11 => 22,
   uiExtKeyF12 => 23,
   uiExtKeyN0 => 24,
   uiExtKeyN1 => 25,
   uiExtKeyN2 => 26,
   uiExtKeyN3 => 27,
   uiExtKeyN4 => 28,
   uiExtKeyN5 => 29,
   uiExtKeyN6 => 30,
   uiExtKeyN7 => 31,
   uiExtKeyN8 => 32,
   uiExtKeyN9 => 33,
   uiExtKeyNDot => 34,
   uiExtKeyNEnter => 35,
   uiExtKeyNAdd => 36,
   uiExtKeyNSubtract => 37,
   uiExtKeyNMultiply => 38,
   uiExtKeyNDivide => 39
);

enum uiAlign is export(:DEFAULT) (
	uiAlignFill => 0,
	uiAlignStart => 1,
	uiAlignCenter => 2,
	uiAlignEnd => 3
);

enum uiAt is export(:DEFAULT) (
   uiAtLeading => 0,
   uiAtTop => 1,
   uiAtTrailing => 2,
   uiAtBottom => 3
);

enum uiTextWeight is export(:text) (
	uiTextWeightMinimum => 0,
	uiTextWeightThin => 100,
	uiTextWeightUltraLight => 200,
	uiTextWeightLight => 300,
	uiTextWeightBook => 350,
	uiTextWeightNormal => 400,
	uiTextWeightMedium => 500,
	uiTextWeightSemiBold => 600,
	uiTextWeightBold => 700,
	uiTextWeightUltraBold => 800,
	uiTextWeightHeavy => 900,
	uiTextWeightUltraHeavy => 950,
	uiTextWeightMaximum => 1000,
);

enum uiTextItalic is export(:text) (
	uiTextItalicNormal => 0,
	uiTextItalicOblique => 1,
	uiTextItalicItalic => 2,
);

enum uiTextStretch is export(:text) (
	uiTextStretchUltraCondensed => 0,
	uiTextStretchExtraCondensed => 1,
	uiTextStretchCondensed => 2,
	uiTextStretchSemiCondensed => 3,
	uiTextStretchNormal => 4,
	uiTextStretchSemiExpanded => 5,
	uiTextStretchExpanded => 6,
	uiTextStretchExtraExpanded => 7,
	uiTextStretchUltraExpanded => 8,
);

## Structures

class uiInitOptions is repr('CStruct') is export(:init) {
	has size_t                        $.Size; # Typedef<size_t>->«long unsigned int» Size
}
class uiControl is repr('CStruct') is export(:MANDATORY) {
	has uint32                      $.Signature; # Typedef<uint32_t>->«unsigned int» Signature
	has uint32                    $.OSSignature; # Typedef<uint32_t>->«unsigned int» OSSignature
	has uint32                      $.TypeSignature; # Typedef<uint32_t>->«unsigned int» TypeSignature
	has Pointer                       $.Destroy; # F:void ( )* Destroy
	has Pointer                       $.Handle; # F:Typedef<uintptr_t>->«long unsigned int» ( )* Handle
	has Pointer                       $.Parent; # F:uiControl* ( )* Parent
	has Pointer                       $.SetParent; # F:void ( )* SetParent
	has Pointer                       $.Toplevel; # F:int ( )* Toplevel
	has Pointer                       $.Visible; # F:int ( )* Visible
	has Pointer                       $.Show; # F:void ( )* Show
	has Pointer                       $.Hide; # F:void ( )* Hide
	has Pointer                       $.Enabled; # F:int ( )* Enabled
	has Pointer                       $.Enable; # F:void ( )* Enable
	has Pointer                       $.Disable; # F:void ( )* Disable
}

role autocast {
	also is uiControl;
	method uiControl() {
		return nativecast(uiControl, self);
	}
}

class uiWindow is repr('CStruct') is export(:window) {
	also does autocast;
	has Str $.uiWindowTitle;
	has Pointer $.uiWindowSetTitle; # F:
	has Pointer $.uiWindowContentSize;
	has Pointer $.uiWindowSetContentSize;
	has Pointer $.uiWindowFullScreen;
	has Pointer $.uiWindowSetFullScreen;
	has Pointer $.uiWindowOnContentSizeChanged;
	has Pointer $.uiWindowOnClosing;
	has Pointer $.uiWindowBorderless;
	has Pointer $.uiWindowSetBorderless;
	has Pointer $.uiWindowSetChild;
	has Pointer $.uiWindowMargined;
	has Pointer $.uiWindowSetMargined;
	has Pointer $.uiNewWindow;

}
class uiButton is repr('CStruct') is export(:button) {
	also does autocast;
	has Pointer $.uiButtonText;
	has Pointer $.uiSetText;
	has Pointer $.uiButtononClicked;
	has Pointer $.onClicked;
	has Pointer $.onClickedData;
}
class uiBox is repr('CStruct') is export(:box) {
	also does autocast;
	has Pointer $.uiBoxAppend;
	has Pointer $.uiBoxDelete;
	has Pointer $.uiBoxPadded;
	has Pointer $.uiBoxSetPadded;
	has Pointer $.uiNewHorizontalBox;
	has Pointer $.uiNewVerticalBox;
}
class uiCheckbox is repr('CStruct') is export(:checkbox) {
	also does autocast;
	has Pointer $.uiCheckboxText;
	has Pointer $.uiCheckboxSetText;
	has Pointer $.uiCheckboxOnToggled;
	has Pointer $.uiCheckboxChecked;
	has Pointer $.uiCheckboxSetChecked;
	has Pointer $uiNewCheckbox;
}
class uiEntry is repr('CStruct') is export(:entry) {
	also does autocast;
	has Pointer $.uiEntryText;
	has Pointer $.uiEntrySetText;
	has Pointer $.uiEntrOnChanged;
	has Pointer $.uiEntryReadOnly;
	has Pointer $.uiEntrySetReadOnly;
	has Pointer $.uiNewEntry;
	has Pointer $.uiNewPasswordEntry;
	has Pointer $.uiNewSearchEntry;
}
class uiForm is repr('CStruct') is export(:form) {
	also does autocast;
	has Pointer $.uiFormAppend;
	has Pointer $.uiFormDelete;
	has Pointer $.uiFormPadded;
	has Pointer $.uiFormSetPadded;
	has Pointer $.uiNewForm;
}
	#Unix
#	has Pointer $.c;
#	has Pointer $.widget;
#	has Pointer $.container;
#	has Pointer $.grid;
#	has Pointer $.children;
#	has int32 $.padded;
#	has Pointer $.stretchygroup;
	#Windows
	#has Pointer $.c;
#	has Pointer $.hwnd;
#	has Pointer $.controls;
	#has int32 $.padded;
	#Darwin
	#has Pointer $.c;
#	has Pointer $.view;
#}
class uiLabel is repr('CStruct') is export(:label) {
	also does autocast;
	#has Pointer $.c;
	#has Pointer $.widget;
	#has Pointer $.misc;
	#has Pointer $.label;
	has Pointer $.uiLabelText;
	has Pointer $.uiLabelSetText;
	has Pointer $.uiNewLabel;
}
class uiTab is repr('CStruct') is export(:tab) {
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
class uiGroup is repr('CStruct') is export(:group) {
	also does autocast;
	has Pointer $.uiGroupTitle;
	has Pointer $.uiGroupSetTitle;
	has Pointer $.uiGroupSetChild;
	has Pointer $.uiGroupMargined;
	has Pointer $.uiGroupSetMargined;
	has Pointer $.uiNewGroup;
}
class uiSpinbox is repr('CStruct') is export(:spinbox) {
	also does autocast;
	has Pointer $.uiSpinboxValue;
	has Pointer $.uiSpinboxSetValue;
	has Pointer $.uiSpinboxOnChanged;
	has Pointer $.uiNewSpinbox;
}
class uiSlider is repr('CStruct') is export(:slider) {
	also does autocast;
#	has Pointer $.widget;
#	has Pointer $.range;
#	has Pointer $.scale;
	has Pointer $.uiSliderValue;
	has Pointer $.uiSliderSetValue;
#	has Pointer $.uiSliderOnChanged;
	has Pointer $.onChangedData;
	has Pointer $.uiNewSlider;
}
class uiProgressBar is repr('CStruct') is export(:progbar) {
	also does autocast;
	has Pointer $.uiProgressBarValue;
	has Pointer $.uiProgressBarSetValue;
	has Pointer $.uiNewProgressBar;
}
class uiSeparator is repr('CStruct') is export(:separator) {
	also does autocast;
	has Pointer $.uiNewHorizontalSeparator;
	has Pointer $.uiNewVerticalSeparator;
}
class uiCombobox is repr('CStruct') is export(:combobox) {
	also does autocast;
	has Pointer $.uiComboboxAppend;
	has Pointer $.uiComboboxSelected;
	has Pointer $.uiComboboxSetSelected;
	has Pointer $.uiComboBoxOnSelected;
	has Pointer $.uiNewCombobox;
}
class uiEditableCombobox is repr('CStruct') is export(:e-combobox) {
	also does autocast;
	has Pointer $.uiEditableComboboxAppend;
	has Pointer $.uiEditableComboboxText;
	has Pointer $.uiEditableComboboxSetText;
	has Pointer $.uiEditableComboboxOnChanged;
	has Pointer $.uiNewEditableCombobox;
}
class uiRadioButtons is repr('CStruct') is export(:radiobutton) {
	also does autocast;
	has Pointer $.uiRadioButtonsAppend;
	has Pointer $.uiRadioButtonsSelected;
	has Pointer $.uiRadioButtonsSetSelected;
	has Pointer $.uiRadioButtonsOnSelected;
	has Pointer $.uiNewRadioButtons;
}
class uiDateTimePicker is repr('CStruct') is export(:picker) {
	also does autocast;
	has Pointer $.uiNewDateTimePicker;
	has Pointer $.uiNewDatePicker;
	has Pointer $.uiNewTimePicker;
}
class uiMultilineEntry is repr('CStruct') is export(:multientry) {
	also does autocast;
	has Pointer $.uiMultilineEntryText;
	has Pointer $.uiMultilineEntrySetText;
	has Pointer $.uiMultilineEntrAppend;
	has Pointer $.uiMultilineEntryOnChanged;
	has Pointer $.uiMultilineEntryReadOnly;
	has Pointer $.uiMultilineEntrySetReadOnly;
	has Pointer $.uiNewMultilineEntry;
	has Pointer $.uiNewNonWrappingMultilineEntry;
}
class uiMenuItem is repr('CStruct') is export(:menu) {
	has Str $.name;
	has int $.type;
	has Pointer $.onClicked;
	has Pointer $.onClickedData;
	has Pointer $.gtype;
	has Pointer $.disabled;
	has Pointer $.checked;
	has Pointer $.windows;
	has Pointer $.uiMenuItemEnable;
	has Pointer $.uiMenuItemDisable;
	has Pointer $.uiMenuItemOnClicked;
	has Pointer $.uiMenuItemChecked;
	has Pointer $.uiMenuItemSetChecked;
}
class uiMenu is repr('CStruct') is export(:menu) {
	has Str $.name;
	has Pointer $.items;
	has Pointer $.uiMenuAppendItem;
	has Pointer $.uiMenuAppendCheckItem;
	has Pointer $.uiMenuAppendQuitItem;
	has Pointer $.uiMenuAppendPreferencesItem;
	has Pointer $.uiMenuAppendAboutItem;
	has Pointer $.uiMenuAppendSeparator;
	has Pointer $.uiNewMenu;

	has Pointer $.uiOpenFile;
	has Pointer $.uiSaveFile;
	has Pointer $.uiMsgBox;
	has Pointer $.uiMsgBoxError;
}
class uiArea is repr('CStruct') is export(:area) {
	also does autocast;
	#Unix
	#has Pointer $.c;
	#has Pointer $.widget;
	#has Pointer $.swidget;
	#has Pointer $.scontainer;
	#has Pointer $.sw;
	#has Pointer $.areaWidget;
	#has Pointer $.drawingArea;
	#has Pointer $.area;
	#has Pointer $.ah;
	#has bool $.scrolling;
	#has int32 $.scrollWidth;
	#has int32 $.scrollHeight;
	#has Pointer $.cc;
	#Windows
	has Pointer $.c;
	has Pointer $.hwnd;
	has Pointer $.ah;
	has bool $.scrolling;
	has int32 $.scrollWidth;
	has int32 $.scrollHeight;
	has int32 $.hscrollpos;
	has int32 $.vscrollpos;
	has int32 $.hwheelCarry;
	has int32 $.vwheelCarry;
	has Pointer $.cc;
	has bool $.capturing;
	has bool $.tracking;
	has Pointer $.rt;
	#Darwin
	#has Pointer $.c;
	#has Pointer $.view;
	#has Pointer $.sv;
	#has Pointer $.area;
	#has Pointer $.d;
	#has Pointer $.ah;
	#has bool $.scrolling;
	#has Pointer $.dragevent;
}
class uiDrawContext is repr('CStruct') is export(:draw) {
	also does autocast;
	#macos
	#has Pointer $c;
	#has Pointer $height;
	#unix
	#has Pointer $cr;
	#windows
	has Pointer $rt;
	has Pointer $states;
	has Pointer $currentClip;
}
class uiAreaHandler is repr('CStruct') is export(:area) {
	has Pointer                       $.Draw; # F:void ( )* Draw
	has Pointer                       $.MouseEvent; # F:void ( )* MouseEvent
	has Pointer                       $.MouseCrossed; # F:void ( )* MouseCrossed
	has Pointer                       $.DragBroken; # F:void ( )* DragBroken
	has Pointer                       $.KeyEvent; # F:int ( )* KeyEvent
}
class uiAreaDrawParams is repr('CStruct') is export(:draw) {
	has uiDrawContext                 $.Context; # Typedef<uiDrawContext>->«uiDrawContext»* Context
	has num64                         $.AreaWidth; # double AreaWidth
	has num64                         $.AreaHeight; # double AreaHeight
	has num64                         $.ClipX; # double ClipX
	has num64                         $.ClipY; # double ClipY
	has num64                         $.ClipWidth; # double ClipWidth
	has num64                         $.ClipHeight; # double ClipHeight
}
class uiDrawPath is repr('CStruct') is export(:draw) {
	#macos
	#has Pointer $path;
	#has int32 $fillMode;
	#has bool $ended;
	#unix
	#has Pointer $pieces;
	#has int32 $fillMode; #repeated, but included for documentation
	#has bool $ended; #repeated, but included for documentation
	#windows
	has Pointer $path; #repeated, but included for documentation
	has Pointer $sink;
	has bool $inFigure;
}
class uiDrawMatrix is repr('CStruct') is export(:draw) {
	has num64                         $.M11; # double M11
	has num64                         $.M12; # double M12
	has num64                         $.M21; # double M21
	has num64                         $.M22; # double M22
	has num64                         $.M31; # double M31
	has num64                         $.M32; # double M32
}
class uiDrawBrush is repr('CStruct') is export(:draw) {
	has uint32               $.Type; # Typedef<uiDrawBrushType>->«unsigned int» Type
	has num64                         $.R; # double R
	has num64                         $.G; # double G
	has num64                         $.B; # double B
	has num64                         $.A; # double A
	has num64                         $.X0; # double X0
	has num64                         $.Y0; # double Y0
	has num64                         $.X1; # double X1
	has num64                         $.Y1; # double Y1
	has num64                         $.OuterRadius; # double OuterRadius
	has Pointer       $.Stops; # Typedef<uiDrawBrushGradientStop>->«uiDrawBrushGradientStop»* Stops
	has size_t                        $.NumStops; # Typedef<size_t>->«long unsigned int» NumStops
}
class uiDrawBrushGradientStop is repr('CStruct') is export(:draw) {
	has num64                         $.Pos; # double Pos
	has num64                         $.R; # double R
	has num64                         $.G; # double G
	has num64                         $.B; # double B
	has num64                         $.A; # double A
}
class uiDrawStrokeParams is repr('CStruct') is export(:draw) {
	has uint32                 $.Cap; # Typedef<uiDrawLineCap>->«unsigned int» Cap
	has uint32                $.Join; # Typedef<uiDrawLineJoin>->«unsigned int» Join
	has num64                         $.Thickness; # double Thickness
	has num64                         $.MiterLimit; # double MiterLimit
	has num64                $.Dashes; # double* Dashes
	has size_t                        $.NumDashes; # Typedef<size_t>->«long unsigned int» NumDashes
	has num64                         $.DashPhase; # double DashPhase
}
class uiDrawFontFamilies is repr('CStruct') is export(:draw) {
	#Windows
	has Pointer $.fontCollection;
	#Unix
	has Pointer $.f;
	has int32 $.n;
	#Darwin
	has Pointer $.fonts;
}
class uiDrawTextLayout is repr('CStruct') is export(:draw) {
	#Unix
	has Str $.s;
	has Pointer $.graphemes; #ptdiff_t is implementation-dependent: offload problem until resolution can be found
	has Pointer $.defaultFont;
	has num64 $.width;
	has Pointer $.attrs;
}
class uiDrawTextFont is repr('CStruct') is export(:draw) {
	#Darwin
	has Pointer $.f;
	#Windows
	#has Pointer $.f;
	has uint16 $.family;
	has num64 $.size;
	#Unix
	#has Pointer $.f;
}
class uiDrawTextFontDescriptor is repr('CStruct') is export(:draw) {
	has Str                           $.Family; # const char* Family
	has num64                         $.Size; # double Size
	has uint32              					$.Weight; # Typedef<uiDrawTextWeight>->«unsigned int» Weight
	has uint32												$.Italic; # Typedef<uiDrawTextItalic>->«unsigned int» Italic
	has uint32												$.Stretch; # Typedef<uiDrawTextStretch>->«unsigned int» Stretch
}
class uiDrawTextFontMetrics is repr('CStruct') is export(:draw) {
	has num64                         $.Ascent; # double Ascent
	has num64                         $.Descent; # double Descent
	has num64                         $.Leading; # double Leading
	has num64                         $.UnderlinePos; # double UnderlinePos
	has num64                         $.UnderlineThickness; # double UnderlineThickness
}
class uiAreaMouseEvent is repr('CStruct') is export(:area) {
	has num64                         $.X; # double X
	has num64                         $.Y; # double Y
	has num64                         $.AreaWidth; # double AreaWidth
	has num64                         $.AreaHeight; # double AreaHeight
	has ulong                     $.Down; # Typedef<uintmax_t>->«long unsigned int» Down
	has ulong                     $.Up; # Typedef<uintmax_t>->«long unsigned int» Up
	has ulong                     $.Count; # Typedef<uintmax_t>->«long unsigned int» Count
	has uint                   $.Modifiers; # Typedef<uiModifiers>->«unsigned int» Modifiers
	has uint64                      $.Held1To64; # Typedef<uint64_t>->«long unsigned int» Held1To64
}
class uiAreaKeyEvent is repr('CStruct') is export(:area) {
	has int8                          $.Key; # char Key
	has uint32                     $.ExtKey; # Typedef<uiExtKey>->«unsigned int» ExtKey
	has uint32                   $.Modifier; # Typedef<uiModifiers>->«unsigned int» Modifier
	has uint32                   $.Modifiers; # Typedef<uiModifiers>->«unsigned int» Modifiers
	has int32                         $.Up; # int Up
}
# TODO Redo uiFontButton when libui 0.0.4 is released
#class uiFontDescriptor is repr('CStruct') is export(:font) {
#	has Str $.Family;
#	has num64 $.Size;
#	has uint32 $.Weight; #Typedef<uiTextWeight> -> unsigned int
#	has uint32 $.Italic; #Typedef<uiTextItalic> -> unsigned int
#	has uint32 $.Stretch; #Typedef<uiTextStretch> -> unsigned int
#}

class uiFontButton is repr('CStruct') is export(:font) {
	also does autocast;
	#Unix
	has Pointer $.c;
	has Pointer $.widget;
	has Pointer $.button;
	has Pointer $.fb;
	has Pointer $.fc;
	has Pointer $.onChanged;
	has Pointer $.onChangedData;
	#Windows 
	#has Pointer $.c;
	has Pointer $.hwnd;
	has Pointer $.params;
	has bool $.already;
	#has Pointer $.onChanged;
	#has Pointer $.onChangedData;
	#Darwin
	#has Pointer $.c;
	#has Pointer $.button;
	#has Pointer $.onChanged;
	#has Pointer $.onChangedData;
}
class uiColorButton is repr('CStruct') is export(:color) {
	also does autocast;
	#Unix
	has Pointer $.c;
	has Pointer $.widget;
	has Pointer $.button;
	has Pointer $.cb;
	has Pointer $.cc;
	has Pointer $.onChanged;
	has Pointer $.onChangedData;
	#Windows 
	#has Pointer $.c;
	has Pointer $.hwnd;
	has num64 $.r;
	has num64 $.g;
	has num64 $.b;
	has num64 $.a;
	#has Pointer $.onChanged;
	#has Pointer $.onChangedData;
	#Darwin
	#has Pointer $.c;
	#has Pointer $.button;
	#has Pointer $.onChanged;
	#has Pointer $.onChangedData;
}

class uiGrid is repr('CStruct') is export(:grid) {
	also does autocast;
	has Pointer $.uiGridAppend;
	has Pointer $.uiGridInsertAt;
	has int32 $.uiGridPadded;
	has Pointer $.uiGridSetPadded;
	has uiGrid $.uiNewGrid;
}


# Functions



sub uiInit(uiInitOptions $options)
	returns Str 
	is native(LIB)
	is export(:init)
	{ * }


sub uiUninit()
	is native(LIB)
	is export
	{ * }


sub uiFreeInitError(Str $err)
	is native(LIB)
	is export
	{ * }


sub uiMain()
	is native(LIB)
	is export
	{ * }


sub uiMainStep(int32 $wait)
	returns int32
	is native(LIB) 
	is export
	{ * }


sub uiQuit()
	is native(LIB)
	is export
	{ * }


sub uiQueueMain(&f (Pointer), Pointer  $data)
	is native(LIB)
	is export
	{ * }


sub uiOnShouldQuit(&f (Pointer --> int32), Pointer $data) 
	is native(LIB)
	is export(:quit)
	{ * }


sub uiFreeText(Str $text)
	is native(LIB)
	is export 
	{ * }



sub uiControlDestroy(uiControl)
	is native(LIB)
	is export 
	{ * }


sub uiControlHandle(uiControl)
	returns uint32
	is native(LIB)
	is export 
	{ * }


sub uiControlParent(uiControl)
	returns uiControl
	is native(LIB)
	is export 
	{ * }


sub uiControlSetParent(uiControl, uiControl)
	is native(LIB)
	is export 
	{ * }


sub uiControlToplevel(uiControl)
	returns int32
	is native(LIB)
	is export 
	{ * }


sub uiControlVisible(uiControl)
	returns int32
	is native(LIB)
	is export 
	{ * }


sub uiControlShow(uiControl)
	is native(LIB)
	is export 
	{ * }


sub uiControlHide(uiControl)
	is native(LIB)
	is export 
	{ * }


sub uiControlEnabled(uiControl)
	returns int32
	is native(LIB)
	is export 
	{ * }


sub uiControlEnable(uiControl)
	is native(LIB)
	is export 
	{ * }


sub uiControlDisable(uiControl)
	is native(LIB)
	is export 
	{ * }



sub uiAllocControl(size_t $n, uint32 $OSsig, uint32 $typesig , Str $typenamestr)
	returns uiControl
	is native(LIB)
	is export 
	{ * }


sub uiFreeControl(uiControl)
	is native(LIB)
	is export 
	{ * }



sub uiControlVerifySetParent(uiControl, uiControl)
	is native(LIB)
	is export(:control) 
	{ * }


sub uiControlEnabledToUser(uiControl)
	returns int32
	is native(LIB)
	is export(:control) 
	{ * }



sub uiUserBugCannotSetParentOnToplevel(Str $type)
	is native(LIB)
	is export(:control) 
	{ * }



sub uiWindowTitle(uiWindow $w)
	returns Str
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowSetTitle(uiWindow $w, Str $title)
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowContentSize(uiWindow $w, int32 $width is rw, int32 $height is rw)
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowSetContentSize(uiWindow $w, int32 $width, int32 $height)
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowFullscreen(uiWindow $w)
	returns int32
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowSetFullscreen(uiWindow $w, int32 $fullscreen)
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowOnContentSizeChanged(uiWindow $w, &f (uiWindow, Pointer --> int32), Pointer $data)
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowOnClosing(uiWindow $w, &f (uiWindow, Pointer --> int32), Pointer $data)
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowBorderless(uiWindow $w)
	returns int32
	is native(LIB)
	is export(:window) 
	{ * }

sub uiWindowSetBorderless(uiWindow $w, int32 $borderless)
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowSetChild(uiWindow $w, uiControl $child)
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowMargined(uiWindow $w)
	returns int32
	is native(LIB)
	is export(:window) 
	{ * }


sub uiWindowSetMargined(uiWindow $w, int32 $margined)
	is native(LIB)
	is export(:window) 
	{ * }


sub uiNewWindow(Str $title, int32 $width, int32 $height, int32 $hasMenubar)
	returns uiWindow
	is native(LIB)
	is export(:window) 
	{ * }



sub uiButtonText(uiButton $b)
	returns Str
	is native(LIB)
	is export(:button) 
	{ * }


sub uiButtonSetText(uiButton $b, Str $text)
	is native(LIB)
	is export(:button) 
	{ * }


sub uiButtonOnClicked(uiButton $b, &f (uiButton, Pointer), Pointer $data)
	is native(LIB)
	is export(:button) 
	{ * }


sub uiNewButton(Str $text)
	returns uiButton
	is native(LIB)
	is export(:button) 
	{ * }



sub uiBoxAppend(uiBox $b, uiControl $child, int32 $stretchy)
	is native(LIB)
	is export(:box) 
	{ * }


sub uiBoxDelete(uiBox $b, ulong $index)
	is native(LIB)
	is export(:box) 
	{ * }


sub uiBoxPadded(uiBox $b)
	returns int32
	is native(LIB)
	is export(:box) 
	{ * }


sub uiBoxSetPadded(uiBox $b, int32 $padded)
	is native(LIB)
	is export(:box) 
	{ * }


sub uiNewHorizontalBox()
	returns uiBox
	is native(LIB)
	is export(:box) 
	{ * }


sub uiNewVerticalBox()
	returns uiBox
	is native(LIB)
	is export(:box) 
	{ * }



sub uiCheckboxText(uiCheckbox $c)
	returns Str
	is native(LIB)
	is export(:checkbox) 
	{ * }


sub uiCheckboxSetText(uiCheckbox $c, Str $text)
	is native(LIB)
	is export(:checkbox) 
	{ * }


sub uiCheckboxOnToggled(uiCheckbox $c, &f (uiCheckbox, Pointer), Pointer $data)
	is native(LIB)
	is export(:checkbox) 
	{ * }


sub uiCheckboxChecked(uiCheckbox $c)
	returns int32
	is native(LIB)
	is export(:checkbox) 
	{ * }


sub uiCheckboxSetChecked(uiCheckbox $c, int32 $checked)
	is native(LIB)
	is export(:checkbox) 
	{ * }


sub uiNewCheckbox(Str $text)
	returns uiCheckbox
	is native(LIB)
	is export(:checkbox) 
	{ * }



sub uiEntryText(uiEntry $e)
	returns Str
	is native(LIB)
	is export(:entry) 
	{ * }


sub uiEntrySetText(uiEntry $e, Str $text)
	is native(LIB)
	is export(:entry) 
	{ * }


sub uiEntryOnChanged(uiEntry $e, &f (uiEntry, Pointer), Pointer $data)
	is native(LIB)
	is export(:entry) 
	{ * }


sub uiEntryReadOnly(uiEntry $e)
	returns int32
	is native(LIB)
	is export(:entry) 
	{ * }


sub uiEntrySetReadOnly(uiEntry $e, int32 $readonly)
	is native(LIB)
	is export(:entry) 
	{ * }


sub uiNewEntry()
	returns uiEntry
	is native(LIB)
	is export(:entry) 
	{ * }


sub uiNewPasswordEntry()
	returns uiEntry
	is native(LIB)
	is export(:entry) 
	{ * }

sub uiNewSearchEntry()
	returns uiEntry
	is native(LIB)
	is export(:entry) 
	{ * }


sub uiFormAppend(uiForm $f, Str	$label, uiControl $c, int32	$stretchy)
	is native(LIB)
	is export(:form) 
	{ * }


sub uiNewForm()
	returns uiForm
	is native(LIB)
	is export(:form) 
	{ * }



sub uiLabelText(uiLabel $l)
	returns Str
	is native(LIB)
	is export(:label) 
	{ * }


sub uiLabelSetText(uiLabel $l, Str $text)
	is native(LIB)
	is export(:label) 
	{ * }


sub uiNewLabel(Str $text)
	returns uiLabel
	is native(LIB)
	is export(:label) 
	{ * }



sub uiTabAppend(uiTab $t, Str $name, uiControl $c)
	is native(LIB)
	is export(:tab) 
	{ * }


sub uiTabInsertAt(uiTab $t, Str $name, uint32 $before, uiControl $c)
	is native(LIB)
	is export(:tab) 
	{ * }


sub uiTabDelete(uiTab $t, uint32 $index)
	is native(LIB)
	is export(:tab) 
	{ * }


sub uiTabNumPages(uiTab $t)
	returns uint32
	is native(LIB)
	is export(:tab) 
	{ * }


sub uiTabMargined(uiTab $t, uint32 $page)
	returns int32
	is native(LIB)
	is export(:tab) 
	{ * }


sub uiTabSetMargined(uiTab $t, uint32 $page, int32 $margined)
	is native(LIB)
	is export(:tab) 
	{ * }


sub uiNewTab()
	returns uiTab
	is native(LIB)
	is export(:tab) 
	{ * }



sub uiGroupTitle(uiGroup $g)
	returns Str
	is native(LIB)
	is export(:group) 
	{ * }


sub uiGroupSetTitle(uiGroup $g, Str $title)
	is native(LIB)
	is export(:group) 
	{ * }


sub uiGroupSetChild(uiGroup $g, uiControl $c)
	is native(LIB)
	is export(:group) 
	{ * }


sub uiGroupMargined(uiGroup $g)
	returns int32
	is native(LIB)
	is export(:group) 
	{ * }


sub uiGroupSetMargined(uiGroup $g, int32 $margined)
	is native(LIB)
	is export(:group) 
	{ * }


sub uiNewGroup(Str $title)
	returns uiGroup
	is native(LIB)
	is export(:group) 
	{ * }



sub uiSpinboxValue(uiSpinbox $s)
	returns int32
	is native(LIB)
	is export(:spinbox) 
	{ * }


sub uiSpinboxSetValue(uiSpinbox $s, int32 $value)
	is native(LIB)
	is export(:spinbox) 
	{ * }


sub uiSpinboxOnChanged(uiSpinbox $s, &f (uiSpinbox, Pointer), Pointer $data)
	is native(LIB)
	is export(:spinbox) 
	{ * }


sub uiNewSpinbox(int64 $min, int64 $max)
	returns uiSpinbox
	is native(LIB)
	is export(:spinbox) 
	{ * }



sub uiSliderValue(uiSlider $s)
	returns int32
	is native(LIB)
	is export(:slider) 
	{ * }


sub uiSliderSetValue(uiSlider $s, int64 $value)
	is native(LIB)
	is export(:slider) 
	{ * }


sub uiSliderOnChanged(uiSlider $s, &f (uiSlider, Pointer), Pointer $data)
	is native(LIB)
	is export(:slider) 
	{ * }


sub uiNewSlider(int64 $min, int64 $max)
	returns uiSlider
	is native(LIB)
	is export(:slider) 
	{ * }



sub uiProgressBarSetValue(uiProgressBar $p, int32 $n)
	is native(LIB)
	is export(:progbar) 
	{ * }


sub uiNewProgressBar()
	returns uiProgressBar
	is native(LIB)
	is export(:progbar) 
	{ * }



sub uiNewHorizontalSeparator()
	returns uiSeparator
	is native(LIB)
	is export(:separator) 
	{ * }


sub uiNewVerticalSeparator()
	returns uiSeparator
	is native(LIB)
	is export(:separator) 
	{ * }



sub uiComboboxAppend(uiCombobox $c, Str $text)
	is native(LIB)
	is export(:combobox) 
	{ * }


sub uiComboboxSelected(uiCombobox $c)
	returns int64
	is native(LIB)
	is export(:combobox) 
	{ * }


sub uiComboboxSetSelected(uiCombobox $c, int64 $n)
	is native(LIB)
	is export(:combobox) 
	{ * }


sub uiComboboxOnSelected(uiCombobox $c, &f (uiCombobox, Pointer), Pointer $data)
	is native(LIB)
	is export(:combobox) 
	{ * }


sub uiNewCombobox()
	returns uiCombobox
	is native(LIB)
	is export(:combobox) 
	{ * }



sub uiEditableComboboxAppend(uiEditableCombobox $c, Str $text)
	is native(LIB)
	is export(:e-combobox) 
	{ * }


sub uiEditableComboboxText(uiEditableCombobox $c)
	returns Str
	is native(LIB)
	is export(:e-combobox) 
	{ * }


sub uiEditableComboboxSetText(uiEditableCombobox $c, Str $text)
	is native(LIB)
	is export(:e-combobox) 
	{ * }



sub uiEditableComboboxOnChanged(uiEditableCombobox $c, &f (uiEditableCombobox, Pointer), Pointer $data)
	is native(LIB)
	is export(:e-combobox) 
	{ * }


sub uiNewEditableCombobox()
	returns uiEditableCombobox
	is native(LIB)
	is export(:e-combobox) 
	{ * }



sub uiRadioButtonsAppend(uiRadioButtons $r, Str $text)
	is native(LIB)
	is export(:radiobutton) 
	{ * }


sub uiNewRadioButtons()
	returns uiRadioButtons
	is native(LIB)
	is export(:radiobutton) 
	{ * }


sub uiRadioButtonsSelected(uiRadioButtons  $r)
	returns int32
	is native(LIB)
	is export(:radiobutton) 
	{ * }

sub uiRadioButtonsSetSelected(uiRadioButtons $r, int32 $n)
	returns int32
	is native(LIB)
	is export(:radiobutton) 
	{ * }

sub uiRadioButtonsOnSelected(uiRadioButtons 	$r, &f (uiRadioButtons, Pointer), Pointer $data)
	is native(LIB)
	is export(:radiobutton) 
	{ * }



sub uiNewDateTimePicker()
	returns uiDateTimePicker
	is native(LIB)
	is export(:picker) 
	{ * }


sub uiNewDatePicker()
	returns uiDateTimePicker
	is native(LIB)
	is export(:picker) 
	{ * }


sub uiNewTimePicker()
	returns uiDateTimePicker
	is native(LIB)
	is export(:picker) 
	{ * }



sub uiMultilineEntryText(uiMultilineEntry $e)
	returns Str
	is native(LIB)
	is export(:multientry) 
	{ * }


sub uiMultilineEntrySetText(uiMultilineEntry $e, Str $text)
	is native(LIB)
	is export(:multientry) 
	{ * }


sub uiMultilineEntryAppend(uiMultilineEntry $e, Str $text)
	is native(LIB)
	is export(:multientry) 
	{ * }


sub uiMultilineEntryOnChanged(uiMultilineEntry $e, &f (uiMultilineEntry, Pointer), Pointer $data)
	is native(LIB)
	is export(:multientry) 
	{ * }


sub uiMultilineEntryReadOnly(uiMultilineEntry $e)
	returns int32
	is native(LIB)
	is export(:multientry) 
	{ * }


sub uiMultilineEntrySetReadOnly(uiMultilineEntry $e, int32 $readonly)
	is native(LIB)
	is export(:multientry) 
	{ * }


sub uiNewMultilineEntry()
	returns uiMultilineEntry
	is native(LIB)
	is export(:multientry) 
	{ * }


sub uiNewNonWrappingMultilineEntry()
	returns uiMultilineEntry
	is native(LIB)
	is export(:multientry) 
	{ * }



sub uiMenuItemEnable(uiMenuItem $m)
	is native(LIB)
	is export(:menu) 
	{ * }


sub uiMenuItemDisable(uiMenuItem $m)
	is native(LIB)
	is export(:menu) 
	{ * }


sub uiMenuItemOnClicked(uiMenuItem $m, &f (uiMenuItem, Pointer), Pointer $data)
	is native(LIB)
	is export(:menu) 
	{ * }


sub uiMenuItemChecked(uiMenuItem $m)
	returns int32
	is native(LIB)
	is export(:menu) 
	{ * }


sub uiMenuItemSetChecked(uiMenuItem $m, int32 $checked)
	is native(LIB)
	is export(:menu) 
	{ * }



sub uiMenuAppendItem(uiMenu $m, Str $name)
	returns uiMenuItem
	is native(LIB)
	is export(:menu) 
	{ * }


sub uiMenuAppendCheckItem(uiMenu $m, Str $name)
	returns uiMenuItem
	is native(LIB)
	is export(:menu) 
	{ * }


sub uiMenuAppendQuitItem(uiMenu $m)
	returns uiMenuItem
	is native(LIB)
	is export(:menu) 
	{ * }


sub uiMenuAppendPreferencesItem(uiMenu $m)
	returns uiMenuItem
	is native(LIB)
	is export(:menu) 
	{ * }


sub uiMenuAppendAboutItem(uiMenu $m)
	returns uiMenuItem
	is native(LIB)
	is export(:menu) 
	{ * }


sub uiMenuAppendSeparator(uiMenu $m)
	is native(LIB)
	is export(:menu) 
	{ * }


sub uiNewMenu(Str $name)
	returns uiMenu
	is native(LIB)
	is export(:menu) 
	{ * }



sub uiOpenFile(uiWindow $parent)
	returns Str
	is native(LIB)
	is export(:window) 
	{ * }


sub uiSaveFile(uiWindow $parent)
	returns Str
	is native(LIB)
	is export(:window) 
	{ * }



sub uiMsgBox(uiWindow $parent, Str $title, Str $description)
	is native(LIB)
	is export(:window) 
	{ * }


sub uiMsgBoxError(uiWindow $parent, Str $title, Str $description)
	is native(LIB)
	is export(:window) 
	{ * }



sub uiAreaSetSize(uiArea $a, int64 $width, int64 $height)
	is native(LIB)
	is export(:area) 
	{ * }



sub uiAreaQueueRedrawAll(uiArea $a)
	is native(LIB)
	is export(:area) 
	{ * }


sub uiAreaScrollTo(uiArea $a, num64 $x , num64 $y, num64 $width, num64 $height)
	is native(LIB)
	is export(:area) 
	{ * }


sub uiNewArea(uiAreaHandler $ah)
	returns uiArea
	is native(LIB)
	is export(:area) 
	{ * }


sub uiNewScrollingArea(uiAreaHandler $ah, int64 $width, int64 $height)
	returns uiArea
	is native(LIB)
	is export(:area) 
	{ * }


sub uiDrawNewPath(uint32 $fillMode)
	returns uiDrawPath
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawFreePath(uiDrawPath $p)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawPathNewFigure(uiDrawPath $p, num64 $x, num64 $y)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawPathNewFigureWithArc(uiDrawPath $p 
                              ,num64      $xCenter 
                              ,num64      $yCenter 
                              ,num64      $radius 
                              ,num64      $startAngle 
                              ,num64      $sweep 
                              ,int32      $negative 
                              ) is native(LIB) is export(:draw) { * }


sub uiDrawPathLineTo(uiDrawPath $p, num64 $x, num64 $y)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawPathArcTo(uiDrawPath $p 
                   ,num64      $xCenter 
                   ,num64      $yCenter 
                   ,num64      $radius 
                   ,num64      $startAngle 
                   ,num64      $sweep 
                   ,int32      $negative 
                   ) is native(LIB) is export(:draw) { * }


sub uiDrawPathBezierTo(uiDrawPath $p 
                      ,num64      $c1x 
                      ,num64      $c1y 
                      ,num64      $c2x 
                      ,num64      $c2y 
                      ,num64      $endX 
                      ,num64      $endY 
                      ) is native(LIB) is export(:draw) { * }



sub uiDrawPathCloseFigure(uiDrawPath $p)
	is native(LIB)
	is export(:draw) 
	{ * }



sub uiDrawPathAddRectangle(uiDrawPath $p, num64 $x, num64 $y, num64 $width, num64 $height)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawPathEnd(uiDrawPath $p)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawStroke(uiDrawContext $c, uiDrawPath $path, uiDrawBrush $b, uiDrawStrokeParams $p)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawFill(uiDrawContext $c, uiDrawPath $path, uiDrawBrush $b)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawMatrixSetIdentity(uiDrawMatrix $m)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawMatrixTranslate(uiDrawMatrix $m, num64 $x, num64 $y)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawMatrixScale(uiDrawMatrix $m, num64 $xCenter, num64 $yCenter, num64 $x, num64 $y)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawMatrixRotate(uiDrawMatrix $m, num64 $x, num64 $y, num64 $amount)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawMatrixSkew(uiDrawMatrix $m, num64 $x, num64 $y, num64 $xamount, num64 $yamount)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawMatrixMultiply(uiDrawMatrix $dest, uiDrawMatrix $src)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawMatrixInvertible(uiDrawMatrix $m)
	returns int32
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawMatrixInvert(uiDrawMatrix $m)
	returns int32
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawMatrixTransformPoint(uiDrawMatrix $m, Pointer[num64] $x, Pointer[num64] $y)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawMatrixTransformSize(uiDrawMatrix $m, Pointer[num64] $x, Pointer[num64] $y)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawTransform(uiDrawContext $c, uiDrawMatrix $m)
	is native(LIB)
	is export(:draw) 
	{ * }



sub uiDrawClip(uiDrawContext $c, uiDrawPath $path)
	is native(LIB)
	is export(:draw) 
	{ * }



sub uiDrawSave(uiDrawContext $c)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawRestore(uiDrawContext $c)
	is native(LIB)
	is export(:draw) 
	{ * }



sub uiDrawListFontFamilies()
	returns uiDrawFontFamilies
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawFontFamiliesNumFamilies(uiDrawFontFamilies $ff)
	returns uint64
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawFontFamiliesFamily(uiDrawFontFamilies $ff, uint64 $n)
	returns Str
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawFreeFontFamilies(uiDrawFontFamilies $ff)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawLoadClosestFont(uiDrawTextFontDescriptor $desc)
	returns uiDrawTextFont
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawFreeTextFont(uiDrawTextFont $font)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawTextFontHandle(uiDrawTextFont $font)
	returns uint64
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawTextFontDescribe(uiDrawTextFont $font, uiDrawTextFontDescriptor $desc)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawTextFontGetMetrics(uiDrawTextFont $font, uiDrawTextFontMetrics $metrics)
	is native(LIB)
	is export(:draw) 
	{ * }



sub uiDrawNewTextLayout(Str $text, uiDrawTextFont $defaultFont, num64 $width)
	returns uiDrawTextLayout
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawFreeTextLayout(uiDrawTextLayout $layout)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawTextLayoutSetWidth(uiDrawTextLayout $layout, num64 $width)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawTextLayoutExtents(uiDrawTextLayout $layout, Pointer[num64] $width, Pointer[num64] $height)
	is native(LIB)
	is export(:draw) 
	{ * }


sub uiDrawTextLayoutSetColor(uiDrawTextLayout $layout 
                            ,int64      $startChar 
                            ,int64      $endChar 
                            ,num64      $r 
                            ,num64      $g 
                            ,num64      $b 
                            ,num64      $a 
                            ) is native(LIB) is export(:draw) { * }


sub uiDrawText(uiDrawContext $c, num64 $x, num64 $y, uiDrawTextLayout $layout)
	is native(LIB)
	is export(:draw) 
	{ * }



sub uiFontButtonFont(uiFontButton $b)
	returns uiDrawTextFont
	is native(LIB)
	is export(:font) 
	{ * }


sub uiFontButtonOnChanged(uiFontButton $b, &f (uiFontButton, Pointer), Pointer $data)
	is native(LIB)
	is export(:font) 
	{ * }


sub uiNewFontButton()
	returns uiFontButton
	is native(LIB)
	is export(:font) 
	{ * }



sub uiColorButtonColor(uiColorButton $b 
                      ,num64         $r is rw 
                      ,num64         $g is rw 
                      ,num64         $bl is rw 
                      ,num64         $a is rw 
                      ) is native(LIB) is export(:color) { * }


sub uiColorButtonSetColor(uiColorButton $b 
                         ,num64         $r 
                         ,num64         $g 
                         ,num64         $bl 
                         ,num64         $a 
                         ) is native(LIB) is export(:color) { * }


sub uiColorButtonOnChanged(uiColorButton $b, &f (uiColorButton, Pointer), Pointer $data)
	is native(LIB)
	is export(:color) 
	{ * }


sub uiNewColorButton()
	returns uiColorButton
	is native(LIB)
	is export(:color) 
	{ * }



sub uiFormDelete(uiForm $f, int32 $index)
	is native(LIB)
	is export(:form) 
	{ * }


sub uiFormPadded(uiForm $f)
	returns int32
	is native(LIB)
	is export(:form)
	{ * }


sub uiFormSetPadded(uiForm $f, int32 $padded)
	is native(LIB)
	is export(:form)
	{ * }



sub uiGridAppend(uiGrid    $g 
                ,uiControl $c 
                ,int32     $left 
                ,int32     $top 
                ,int32     $xspan 
                ,int32     $yspan 
                ,int32     $hexpand 
                ,uint32    $halign 
                ,int32     $vexpand 
                ,uint32    $valign 
                ) is native(LIB) is export(:grid) { * }


sub uiGridInsertAt(uiGrid    $g
                  ,uiControl $c
                  ,uiControl $existing
                  ,uint32    $at
                  ,int32     $xspan
                  ,int32     $yspan
                  ,int32     $hexpand
                  ,uint32    $halign
                  ,int32     $vexpand
                  ,uint32    $valign
                  ) is native(LIB) is export(:grid) { * }


sub uiGridPadded(uiGrid $g)
	returns int32
	is native(LIB)
	is export(:grid)
	{ * }


sub uiGridSetPadded(uiGrid $g, int32 $padded)
	is native(LIB)
	is export(:grid)
	{ * }


sub uiNewGrid()
	returns uiGrid
	is native(LIB)
	is export(:grid)
	{ * }

# Externs



#useful subs

sub uicontrol($control) is export(:DEFAULT) {
	return nativecast(uiControl, $control);
}

sub get-pointer($struct) is export(:DEFAULT) {
	return nativecast(Pointer, $struct);
}
