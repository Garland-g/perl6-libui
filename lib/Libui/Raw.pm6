use v6;

unit module Libui::Raw;

use NativeCall;

constant \LIB = 'ui';

## Enumerations

enum uiDrawBrushType is export (
   uiDrawBrushTypeSolid => 0,
   uiDrawBrushTypeLinearGradient => 1,
   uiDrawBrushTypeRadialGradient => 2,
   uiDrawBrushTypeImage => 3
);
enum uiDrawLineCap is export (
   uiDrawLineCapFlat => 0,
   uiDrawLineCapRound => 1,
   uiDrawLineCapSquare => 2
);
enum uiDrawLineJoin is export (
   uiDrawLineJoinMiter => 0,
   uiDrawLineJoinRound => 1,
   uiDrawLineJoinBevel => 2
);
enum uiDrawFillMode is export (
   uiDrawFillModeWinding => 0,
   uiDrawFillModeAlternate => 1
);
enum uiDrawTextWeight is export (
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
enum uiDrawTextItalic is export (
   uiDrawTextItalicNormal => 0,
   uiDrawTextItalicOblique => 1,
   uiDrawTextItalicItalic => 2
);
enum uiDrawTextStretch is export (
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
enum uiModifier is export (
   uiModifierCtrl => 1,
   uiModifierAlt => 2,
   uiModifierShift => 4,
   uiModifierSuper => 8
);
enum uiExtKey is export (
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

enum uiAlign is export (
	uiAlignFill => 0,
	uiAlignStart => 1,
	uiAlignCenter => 2,
	uiAlignEnd => 3
);

enum uiAt is export (
   uiAtLeading => 0,
   uiAtTop => 1,
   uiAtTrailing => 2,
   uiAtBottom => 3
);

enum uiTextWeight is export (
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

enum uiTextItalic is export (
	uiTextItalicNormal => 0,
	uiTextItalicOblique => 1,
	uiTextItalicItalic => 2,
);

enum uiTextStretch is export (
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

class uiInitOptions is repr('CStruct') is export {
	has size_t                        $.Size; # Typedef<size_t>->«long unsigned int» Size
}
class uiControl is repr('CStruct') is export {
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

class uiWindow is repr('CStruct') is export {
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
class uiButton is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiButtonText;
	has Pointer $.uiSetText;
	has Pointer $.uiButtononClicked;
	has Pointer $.onClicked;
	has Pointer $.onClickedData;
}
class uiBox is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiBoxAppend;
	has Pointer $.uiBoxDelete;
	has Pointer $.uiBoxPadded;
	has Pointer $.uiBoxSetPadded;
	has Pointer $.uiNewHorizontalBox;
	has Pointer $.uiNewVerticalBox;
}
class uiCheckbox is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiCheckboxText;
	has Pointer $.uiCheckboxSetText;
	has Pointer $.uiCheckboxOnToggled;
	has Pointer $.uiCheckboxChecked;
	has Pointer $.uiCheckboxSetChecked;
	has Pointer $uiNewCheckbox;
}
class uiEntry is repr('CStruct') is export {
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
class uiForm is repr('CStruct') is export {
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
class uiLabel is repr('CStruct') is export {
	also does autocast;
	#has Pointer $.c;
	#has Pointer $.widget;
	#has Pointer $.misc;
	#has Pointer $.label;
	has Pointer $.uiLabelText;
	has Pointer $.uiLabelSetText;
	has Pointer $.uiNewLabel;
}
class uiTab is repr('CStruct') is export {
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
class uiGroup is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiGroupTitle;
	has Pointer $.uiGroupSetTitle;
	has Pointer $.uiGroupSetChild;
	has Pointer $.uiGroupMargined;
	has Pointer $.uiGroupSetMargined;
	has Pointer $.uiNewGroup;
}
class uiSpinbox is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiSpinboxValue;
	has Pointer $.uiSpinboxSetValue;
	has Pointer $.uiSpinboxOnChanged;
	has Pointer $.uiNewSpinbox;
}
class uiSlider is repr('CStruct') is export {
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
class uiProgressBar is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiProgressBarValue;
	has Pointer $.uiProgressBarSetValue;
	has Pointer $.uiNewProgressBar;
}
class uiSeparator is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiNewHorizontalSeparator;
	has Pointer $.uiNewVerticalSeparator;
}
class uiCombobox is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiComboboxAppend;
	has Pointer $.uiComboboxSelected;
	has Pointer $.uiComboboxSetSelected;
	has Pointer $.uiComboBoxOnSelected;
	has Pointer $.uiNewCombobox;
}
class uiEditableCombobox is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiEditableComboboxAppend;
	has Pointer $.uiEditableComboboxText;
	has Pointer $.uiEditableComboboxSetText;
	has Pointer $.uiEditableComboboxOnChanged;
	has Pointer $.uiNewEditableCombobox;
}
class uiRadioButtons is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiRadioButtonsAppend;
	has Pointer $.uiRadioButtonsSelected;
	has Pointer $.uiRadioButtonsSetSelected;
	has Pointer $.uiRadioButtonsOnSelected;
	has Pointer $.uiNewRadioButtons;
}
class uiDateTimePicker is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiNewDateTimePicker;
	has Pointer $.uiNewDatePicker;
	has Pointer $.uiNewTimePicker;
}
class uiMultilineEntry is repr('CStruct') is export {
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
class uiMenuItem is repr('CStruct') is export {
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
class uiMenu is repr('CStruct') is export {
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
class uiArea is repr('CStruct') is export {
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
class uiDrawContext is repr('CStruct') is export {
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
class uiAreaHandler is repr('CStruct') is export {
	has Pointer                       $.Draw; # F:void ( )* Draw
	has Pointer                       $.MouseEvent; # F:void ( )* MouseEvent
	has Pointer                       $.MouseCrossed; # F:void ( )* MouseCrossed
	has Pointer                       $.DragBroken; # F:void ( )* DragBroken
	has Pointer                       $.KeyEvent; # F:int ( )* KeyEvent
}
class uiAreaDrawParams is repr('CStruct') is export {
	has uiDrawContext                 $.Context; # Typedef<uiDrawContext>->«uiDrawContext»* Context
	has num64                         $.AreaWidth; # double AreaWidth
	has num64                         $.AreaHeight; # double AreaHeight
	has num64                         $.ClipX; # double ClipX
	has num64                         $.ClipY; # double ClipY
	has num64                         $.ClipWidth; # double ClipWidth
	has num64                         $.ClipHeight; # double ClipHeight
}
class uiDrawPath is repr('CStruct') is export {
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
class uiDrawMatrix is repr('CStruct') is export {
	has num64                         $.M11; # double M11
	has num64                         $.M12; # double M12
	has num64                         $.M21; # double M21
	has num64                         $.M22; # double M22
	has num64                         $.M31; # double M31
	has num64                         $.M32; # double M32
}
class uiDrawBrush is repr('CStruct') is export {
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
class uiDrawBrushGradientStop is repr('CStruct') is export {
	has num64                         $.Pos; # double Pos
	has num64                         $.R; # double R
	has num64                         $.G; # double G
	has num64                         $.B; # double B
	has num64                         $.A; # double A
}
class uiDrawStrokeParams is repr('CStruct') is export {
	has uint32                 $.Cap; # Typedef<uiDrawLineCap>->«unsigned int» Cap
	has uint32                $.Join; # Typedef<uiDrawLineJoin>->«unsigned int» Join
	has num64                         $.Thickness; # double Thickness
	has num64                         $.MiterLimit; # double MiterLimit
	has num64                $.Dashes; # double* Dashes
	has size_t                        $.NumDashes; # Typedef<size_t>->«long unsigned int» NumDashes
	has num64                         $.DashPhase; # double DashPhase
}
class uiDrawFontFamilies is repr('CStruct') is export {
	#Windows
	has Pointer $.fontCollection;
	#Unix
	has Pointer $.f;
	has int32 $.n;
	#Darwin
	has Pointer $.fonts;
}
class uiDrawTextLayout is repr('CStruct') is export {
	#Unix
	has Str $.s;
	has Pointer $.graphemes; #ptdiff_t is implementation-dependent: offload problem until resolution can be found
	has Pointer $.defaultFont;
	has num64 $.width;
	has Pointer $.attrs;
}
class uiDrawTextFont is repr('CStruct') is export {
	#Darwin
	has Pointer $.f;
	#Windows
	#has Pointer $.f;
	has uint16 $.family;
	has num64 $.size;
	#Unix
	#has Pointer $.f;
}
class uiDrawTextFontDescriptor is repr('CStruct') is export {
	has Str                           $.Family; # const char* Family
	has num64                         $.Size; # double Size
	has uint32              					$.Weight; # Typedef<uiDrawTextWeight>->«unsigned int» Weight
	has uint32												$.Italic; # Typedef<uiDrawTextItalic>->«unsigned int» Italic
	has uint32												$.Stretch; # Typedef<uiDrawTextStretch>->«unsigned int» Stretch
}
class uiDrawTextFontMetrics is repr('CStruct') is export {
	has num64                         $.Ascent; # double Ascent
	has num64                         $.Descent; # double Descent
	has num64                         $.Leading; # double Leading
	has num64                         $.UnderlinePos; # double UnderlinePos
	has num64                         $.UnderlineThickness; # double UnderlineThickness
}
class uiAreaMouseEvent is repr('CStruct') is export {
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
class uiAreaKeyEvent is repr('CStruct') is export {
	has int8                          $.Key; # char Key
	has uint32                     $.ExtKey; # Typedef<uiExtKey>->«unsigned int» ExtKey
	has uint32                   $.Modifier; # Typedef<uiModifiers>->«unsigned int» Modifier
	has uint32                   $.Modifiers; # Typedef<uiModifiers>->«unsigned int» Modifiers
	has int32                         $.Up; # int Up
}
# TODO Redo uiFontButton when libui 0.0.4 is released
#class uiFontDescriptor is repr('CStruct') is export {
#	has Str $.Family;
#	has num64 $.Size;
#	has uint32 $.Weight; #Typedef<uiTextWeight> -> unsigned int
#	has uint32 $.Italic; #Typedef<uiTextItalic> -> unsigned int
#	has uint32 $.Stretch; #Typedef<uiTextStretch> -> unsigned int
#}

class uiFontButton is repr('CStruct') is export {
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
class uiColorButton is repr('CStruct') is export {
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

class uiGrid is repr('CStruct') is export {
	also does autocast;
	has Pointer $.uiGridAppend;
	has Pointer $.uiGridInsertAt;
	has int32 $.uiGridPadded;
	has Pointer $.uiGridSetPadded;
	has uiGrid $.uiNewGrid;
}

# Extras stuff

#constant uiDrawContext is export := uiDrawContext;
#constant uiTab is export := uiTab;
#constant uiColorButton is export := uiColorButton;
#constant uiDrawFontFamilies is export := uiDrawFontFamilies;
#constant uiFontButton is export := uiFontButton;
#constant uiButton is export := uiButton;
#constant uiDrawBrushGradientStop is export := uiDrawBrushGradientStop;
#constant uiDrawBrush is export := uiDrawBrush;
#constant uiSpinbox is export := uiSpinbox;
#constant uiArea is export := uiArea;
#constant uiDrawTextFontMetrics is export := uiDrawTextFontMetrics;
#constant uiCheckbox is export := uiCheckbox;
#constant uiBox is export := uiBox;
#constant uiInitOptions is export := uiInitOptions;
#constant uiAreaMouseEvent is export := uiAreaMouseEvent;
#constant uiSeparator is export := uiSeparator;
#constant uiControl is export := uiControl;
#constant uiDrawMatrix is export := uiDrawMatrix;
#constant uiDateTimePicker is export := uiDateTimePicker;
#constant uiMenuItem is export := uiMenuItem;
#constant uiDrawTextFontDescriptor is export := uiDrawTextFontDescriptor;
#constant uiCombobox is export := uiCombobox;
#constant uiDrawPath is export := uiDrawPath;
#constant uiRadioButtons is export := uiRadioButtons;
#constant uiGroup is export := uiGroup;
#constant uiDrawTextFont is export := uiDrawTextFont;
#constant uiAreaKeyEvent is export := uiAreaKeyEvent;
#constant uiAreaHandler is export := uiAreaHandler;
#constant uiEntry is export := uiEntry;
#constant uiDrawStrokeParams is export := uiDrawStrokeParams;
#constant uiProgressBar is export := uiProgressBar;
#constant uiMenu is export := uiMenu;
#constant uiLabel is export := uiLabel;
#constant uiMultilineEntry is export := uiMultilineEntry;
#constant uiAreaDrawParams is export := uiAreaDrawParams;
#constant uiEditableCombobox is export := uiEditableCombobox;
#constant uiWindow is export := uiWindow;
#constant uiSlider is export := uiSlider;
#constant uiDrawTextLayout is export := uiDrawTextLayout;
# Functions

#== /mnt/b/Documents/alpha3.1/src/ui.h ==

#const char *uiInit(uiInitOptions *options);
sub uiInit(uiInitOptions $options # Typedef<uiInitOptions>->«uiInitOptions»*
           ) is native(LIB) returns Str is export { * }

#From /mnt/b/Documents/alpha3.1/src/ui.h:42
#_UI_EXTERN void uiUninit(void);
sub uiUninit(
             ) is native(LIB)  is export { * }
#
#From /mnt/b/Documents/alpha3.1/src/ui.h:43
#_UI_EXTERN void uiFreeInitError(const char *err);
sub uiFreeInitError(Str $err # const char*
                    ) is native(LIB)  is export { * }

#From /mnt/b/Documents/alpha3.1/src/ui.h:45
#UI_EXTERN void uiMain(void);
sub uiMain(
           ) is native(LIB)  is export { * }

#From /mnt/b/Documents/alpha3.1/src/ui.h:46
#_UI_EXTERN int uiMainStep(int wait);
sub uiMainStep(int32 $wait # int
               ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiQuit(void);
sub uiQuit(
           ) is native(LIB)  is export { * }

#_UI_EXTERN void uiQueueMain(void (*f)(void *data), void *data);
sub uiQueueMain(&f (Pointer) # F:void ( )*
               ,Pointer                       $data # void*
                ) is native(LIB)  is export { * }

#_UI_EXTERN void uiOnShouldQuit(int (*f)(void *data), void *data);
sub uiOnShouldQuit(&f (Pointer --> int32) # F:int ( )*
                  ,Pointer                       $data # void*
                   ) is native(LIB)  is export { * }

#_UI_EXTERN void uiFreeText(char *text);
sub uiFreeText(Str $text # char*
               ) is native(LIB)  is export { * }

#// TOOD add argument names to all arguments
#define uiControl(this) ((uiControl *) (this))
#_UI_EXTERN void uiControlDestroy(uiControl *);
sub uiControlDestroy(uiControl  # Typedef<uiControl>->«uiControl»*
                     ) is native(LIB)  is export { * }

#_UI_EXTERN uintptr_t uiControlHandle(uiControl *);
sub uiControlHandle(uiControl  # Typedef<uiControl>->«uiControl»*
                    ) is native(LIB) returns uint32 is export { * }

#_UI_EXTERN uiControl *uiControlParent(uiControl *);
sub uiControlParent(uiControl  # Typedef<uiControl>->«uiControl»*
                    ) is native(LIB) returns uiControl is export { * }

#_UI_EXTERN void uiControlSetParent(uiControl *, uiControl *);
sub uiControlSetParent(uiControl                      # Typedef<uiControl>->«uiControl»*
                      ,uiControl                      # Typedef<uiControl>->«uiControl»*
                       ) is native(LIB)  is export { * }

#_UI_EXTERN int uiControlToplevel(uiControl *);
sub uiControlToplevel(uiControl  # Typedef<uiControl>->«uiControl»*
                      ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN int uiControlVisible(uiControl *);
sub uiControlVisible(uiControl  # Typedef<uiControl>->«uiControl»*
                     ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiControlShow(uiControl *);
sub uiControlShow(uiControl  # Typedef<uiControl>->«uiControl»*
                  ) is native(LIB)  is export { * }

#_UI_EXTERN void uiControlHide(uiControl *);
sub uiControlHide(uiControl  # Typedef<uiControl>->«uiControl»*
                  ) is native(LIB)  is export { * }

#_UI_EXTERN int uiControlEnabled(uiControl *);
sub uiControlEnabled(uiControl  # Typedef<uiControl>->«uiControl»*
                     ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiControlEnable(uiControl *);
sub uiControlEnable(uiControl  # Typedef<uiControl>->«uiControl»*
                    ) is native(LIB)  is export { * }

#_UI_EXTERN void uiControlDisable(uiControl *);
sub uiControlDisable(uiControl  # Typedef<uiControl>->«uiControl»*
                     ) is native(LIB)  is export { * }

#_UI_EXTERN uiControl *uiAllocControl(size_t n, uint32_t OSsig, uint32_t typesig, const char *typenamestr);
sub uiAllocControl(size_t                        $n # Typedef<size_t>->«long unsigned int»
                  ,uint32                      $OSsig # Typedef<uint32_t>->«unsigned int»
                  ,uint32                      $typesig # Typedef<uint32_t>->«unsigned int»
                  ,Str                           $typenamestr # const char*
                   ) is native(LIB) returns uiControl is export { * }

#_UI_EXTERN void uiFreeControl(uiControl *);
sub uiFreeControl(uiControl  # Typedef<uiControl>->«uiControl»*
                  ) is native(LIB)  is export { * }

#// TODO make sure all controls have these
#_UI_EXTERN void uiControlVerifySetParent(uiControl *, uiControl *);
sub uiControlVerifySetParent(uiControl                      # Typedef<uiControl>->«uiControl»*
                            ,uiControl                      # Typedef<uiControl>->«uiControl»*
                             ) is native(LIB)  is export { * }

#_UI_EXTERN int uiControlEnabledToUser(uiControl *);
sub uiControlEnabledToUser(uiControl  # Typedef<uiControl>->«uiControl»*
                           ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiUserBugCannotSetParentOnToplevel(const char *type);
sub uiUserBugCannotSetParentOnToplevel(Str $type # const char*
                                       ) is native(LIB)  is export { * }

#define uiWindow(this) ((uiWindow *) (this))
#_UI_EXTERN char *uiWindowTitle(uiWindow *w);
sub uiWindowTitle(uiWindow $w # Typedef<uiWindow>->«uiWindow»*
                  ) is native(LIB) returns Str is export { * }

#_UI_EXTERN void uiWindowSetTitle(uiWindow *w, const char *title);
sub uiWindowSetTitle(uiWindow                      $w # Typedef<uiWindow>->«uiWindow»*
                    ,Str                           $title # const char*
                     ) is native(LIB)  is export { * }

sub uiWindowContentSize(uiWindow $w
											, int32 $width is rw
											, int32 $height is rw
											) is native(LIB) is export { * }

sub uiWindowSetContentSize(uiWindow $w
											,int32 $width
											,int32 $height
											) is native(LIB) is export { * }


sub uiWindowFullscreen(uiWindow $w
											) is native(LIB) returns int32 is export { * }

sub uiWindowSetFullscreen(uiWindow $w
											,int32 $fullscreen
											) is native(LIB) is export { * }


#_UI_EXTERN void uiWindowOnContentSizeChanged(uiWindow *w, int (*f)(uiWindow *w, void *data), void *data);
sub uiWindowOnContentSizeChanged(uiWindow           $w # Typedef<uiWindow>->«uiWindow»*
                     ,&f (uiWindow, Pointer --> int32) # F:int ( )*
                     ,Pointer                       $data # void*
                      ) is native(LIB)  is export { * }


#_UI_EXTERN void uiWindowOnClosing(uiWindow *w, int (*f)(uiWindow *w, void *data), void *data);
sub uiWindowOnClosing(uiWindow                      $w # Typedef<uiWindow>->«uiWindow»*
                     ,&f (uiWindow, Pointer --> int32) # F:int ( )*
                     ,Pointer                       $data # void*
                      ) is native(LIB)  is export { * }


sub uiWindowBorderless(uiWindow $w
											) is native(LIB) returns int32 is export { * }

sub uiWindowSetBorderless(uiWindow $w
											,int32 $borderless
											) is native(LIB) is export { * }


#_UI_EXTERN void uiWindowSetChild(uiWindow *w, uiControl *child);
sub uiWindowSetChild(uiWindow                      $w # Typedef<uiWindow>->«uiWindow»*
                    ,uiControl                     $child # Typedef<uiControl>->«uiControl»*
                     ) is native(LIB)  is export { * }

#_UI_EXTERN int uiWindowMargined(uiWindow *w);
sub uiWindowMargined(uiWindow $w # Typedef<uiWindow>->«uiWindow»*
                     ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiWindowSetMargined(uiWindow *w, int margined);
sub uiWindowSetMargined(uiWindow                      $w # Typedef<uiWindow>->«uiWindow»*
                       ,int32                         $margined # int
                        ) is native(LIB)  is export { * }


#_UI_EXTERN uiWindow *uiNewWindow(const char *title, int width, int height, int hasMenubar);
sub uiNewWindow(Str                           $title # const char*
               ,int32                         $width # int
               ,int32                         $height # int
               ,int32                         $hasMenubar # int
                ) is native(LIB) returns uiWindow is export { * }

#define uiButton(this) ((uiButton *) (this))
#_UI_EXTERN char *uiButtonText(uiButton *b);
sub uiButtonText(uiButton $b # Typedef<uiButton>->«uiButton»*
                 ) is native(LIB) returns Str is export { * }

#_UI_EXTERN void uiButtonSetText(uiButton *b, const char *text);
sub uiButtonSetText(uiButton                      $b # Typedef<uiButton>->«uiButton»*
                   ,Str                           $text # const char*
                    ) is native(LIB)  is export { * }

#_UI_EXTERN void uiButtonOnClicked(uiButton *b, void (*f)(uiButton *b, void *data), void *data);
sub uiButtonOnClicked(uiButton                      $b # Typedef<uiButton>->«uiButton»*
                     ,&f (uiButton, Pointer) # F:void ( )*
                     ,Pointer                       $data # void*
                      ) is native(LIB)  is export { * }

#_UI_EXTERN uiButton *uiNewButton(const char *text);
sub uiNewButton(Str $text # const char*
                ) is native(LIB) returns uiButton is export { * }

#define uiBox(this) ((uiBox *) (this))
#_UI_EXTERN void uiBoxAppend(uiBox *b, uiControl *child, int stretchy);
sub uiBoxAppend(uiBox                         $b # Typedef<uiBox>->«uiBox»*
               ,uiControl                     $child # Typedef<uiControl>->«uiControl»*
               ,int32                         $stretchy # int
                ) is native(LIB)  is export { * }

#_UI_EXTERN void uiBoxDelete(uiBox *b, uintmax_t index);
sub uiBoxDelete(uiBox                         $b # Typedef<uiBox>->«uiBox»*
               ,ulong                     $index # Typedef<uintmax_t>->«long unsigned int»
                ) is native(LIB)  is export { * }

#_UI_EXTERN int uiBoxPadded(uiBox *b);
sub uiBoxPadded(uiBox $b # Typedef<uiBox>->«uiBox»*
                ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiBoxSetPadded(uiBox *b, int padded);
sub uiBoxSetPadded(uiBox                         $b # Typedef<uiBox>->«uiBox»*
                  ,int32                         $padded # int
                   ) is native(LIB)  is export { * }

#_UI_EXTERN uiBox *uiNewHorizontalBox(void);
sub uiNewHorizontalBox(
                       ) is native(LIB) returns uiBox is export { * }

#_UI_EXTERN uiBox *uiNewVerticalBox(void);
sub uiNewVerticalBox(
                     ) is native(LIB) returns uiBox is export { * }

#define uiCheckbox(this) ((uiCheckbox *) (this))
#_UI_EXTERN char *uiCheckboxText(uiCheckbox *c);
sub uiCheckboxText(uiCheckbox $c # Typedef<uiCheckbox>->«uiCheckbox»*
                   ) is native(LIB) returns Str is export { * }

#_UI_EXTERN void uiCheckboxSetText(uiCheckbox *c, const char *text);
sub uiCheckboxSetText(uiCheckbox                    $c # Typedef<uiCheckbox>->«uiCheckbox»*
                     ,Str                           $text # const char*
                      ) is native(LIB)  is export { * }

#_UI_EXTERN void uiCheckboxOnToggled(uiCheckbox *c, void (*f)(uiCheckbox *c, void *data), void *data);
sub uiCheckboxOnToggled(uiCheckbox                    $c # Typedef<uiCheckbox>->«uiCheckbox»*
                       ,&f (uiCheckbox, Pointer) # F:void ( )*
                       ,Pointer                       $data # void*
                        ) is native(LIB)  is export { * }

#_UI_EXTERN int uiCheckboxChecked(uiCheckbox *c);
sub uiCheckboxChecked(uiCheckbox $c # Typedef<uiCheckbox>->«uiCheckbox»*
                      ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiCheckboxSetChecked(uiCheckbox *c, int checked);
sub uiCheckboxSetChecked(uiCheckbox                    $c # Typedef<uiCheckbox>->«uiCheckbox»*
                        ,int32                         $checked # int
                         ) is native(LIB)  is export { * }

#_UI_EXTERN uiCheckbox *uiNewCheckbox(const char *text);
sub uiNewCheckbox(Str $text # const char*
                  ) is native(LIB) returns uiCheckbox is export { * }

#define uiEntry(this) ((uiEntry *) (this))
#_UI_EXTERN char *uiEntryText(uiEntry *e);
sub uiEntryText(uiEntry $e # Typedef<uiEntry>->«uiEntry»*
                ) is native(LIB) returns Str is export { * }

#_UI_EXTERN void uiEntrySetText(uiEntry *e, const char *text);
sub uiEntrySetText(uiEntry                       $e # Typedef<uiEntry>->«uiEntry»*
                  ,Str                           $text # const char*
                   ) is native(LIB)  is export { * }

#_UI_EXTERN void uiEntryOnChanged(uiEntry *e, void (*f)(uiEntry *e, void *data), void *data);
sub uiEntryOnChanged(uiEntry                       $e # Typedef<uiEntry>->«uiEntry»*
                    ,&f (uiEntry, Pointer) # F:void ( )*
                    ,Pointer                       $data # void*
                     ) is native(LIB)  is export { * }

#_UI_EXTERN int uiEntryReadOnly(uiEntry *e);
sub uiEntryReadOnly(uiEntry $e # Typedef<uiEntry>->«uiEntry»*
                    ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiEntrySetReadOnly(uiEntry *e, int readonly);
sub uiEntrySetReadOnly(uiEntry                       $e # Typedef<uiEntry>->«uiEntry»*
                      ,int32                         $readonly # int
                       ) is native(LIB)  is export { * }

#_UI_EXTERN uiEntry *uiNewEntry(void);
sub uiNewEntry(
               ) is native(LIB) returns uiEntry is export { * }

#_UI_EXTERN uiEntry *uiNewPasswordEntry(void);
sub uiNewPasswordEntry(
											) is native(LIB) returns uiEntry is export { * }

sub uiNewSearchEntry(
											) is native(LIB) returns uiEntry is export { * }

#_UI_EXTERN void uiFormAppend(uiForm *f, const char *label, uiControl *c, int stretchy);
sub uiFormAppend(uiForm 												$f #Typedef<uiForm>->«uiForm»*
								,Str														$label
								,uiControl 											$c #Typedef<uiControl>->«uiControl»*
								,int32													$stretchy
							) is native(LIB) is export { * }

#_UI_EXTERN void uiFormSetPadded(uiForm *f, int padded);
#sub uiFormSetPadded(uiForm											$f #Typedef<uiForm>->«uiForm»*
#									,int32												$padded
#								) is native(LIB) is export { * }

#_UI_EXTERN uiForm *uiNewForm(void);
sub uiNewForm(
							) is native(LIB) returns uiForm is export { * }

#define uiLabel(this) ((uiLabel *) (this))
#_UI_EXTERN char *uiLabelText(uiLabel *l);
sub uiLabelText(uiLabel $l # Typedef<uiLabel>->«uiLabel»*
                ) is native(LIB) returns Str is export { * }

#_UI_EXTERN void uiLabelSetText(uiLabel *l, const char *text);
sub uiLabelSetText(uiLabel                       $l # Typedef<uiLabel>->«uiLabel»*
                  ,Str                           $text # const char*
                   ) is native(LIB)  is export { * }

#_UI_EXTERN uiLabel *uiNewLabel(const char *text);
sub uiNewLabel(Str $text # const char*
               ) is native(LIB) returns uiLabel is export { * }

#define uiTab(this) ((uiTab *) (this))
#_UI_EXTERN void uiTabAppend(uiTab *t, const char *name, uiControl *c);
sub uiTabAppend(uiTab                         $t # Typedef<uiTab>->«uiTab»*
               ,Str                           $name # const char*
               ,uiControl                     $c # Typedef<uiControl>->«uiControl»*
                ) is native(LIB)  is export { * }

#_UI_EXTERN void uiTabInsertAt(uiTab *t, const char *name, uintmax_t before, uiControl *c);
sub uiTabInsertAt(uiTab                         $t # Typedef<uiTab>->«uiTab»*
                 ,Str                           $name # const char*
                 ,uint32                     $before # Typedef<uintmax_t>->«long unsigned int»
                 ,uiControl                     $c # Typedef<uiControl>->«uiControl»*
                  ) is native(LIB)  is export { * }

#_UI_EXTERN void uiTabDelete(uiTab *t, uintmax_t index);
sub uiTabDelete(uiTab                         $t # Typedef<uiTab>->«uiTab»*
               ,uint32                     $index # Typedef<uintmax_t>->«long unsigned int»
                ) is native(LIB)  is export { * }

#_UI_EXTERN uintmax_t uiTabNumPages(uiTab *t);
sub uiTabNumPages(uiTab $t # Typedef<uiTab>->«uiTab»*
                  ) is native(LIB) returns uint32 is export { * }

#_UI_EXTERN int uiTabMargined(uiTab *t, uintmax_t page);
sub uiTabMargined(uiTab                         $t # Typedef<uiTab>->«uiTab»*
                 ,uint32                     $page # Typedef<uintmax_t>->«long unsigned int»
                  ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiTabSetMargined(uiTab *t, uintmax_t page, int margined);
sub uiTabSetMargined(uiTab                         $t # Typedef<uiTab>->«uiTab»*
                    ,uint32                     $page # Typedef<uintmax_t>->«long unsigned int»
                    ,int32                         $margined # int
                     ) is native(LIB)  is export { * }

#_UI_EXTERN uiTab *uiNewTab(void);
sub uiNewTab(
             ) is native(LIB) returns uiTab is export { * }

#define uiGroup(this) ((uiGroup *) (this))
#_UI_EXTERN char *uiGroupTitle(uiGroup *g);
sub uiGroupTitle(uiGroup $g # Typedef<uiGroup>->«uiGroup»*
                 ) is native(LIB) returns Str is export { * }

#_UI_EXTERN void uiGroupSetTitle(uiGroup *g, const char *title);
sub uiGroupSetTitle(uiGroup                       $g # Typedef<uiGroup>->«uiGroup»*
                   ,Str                           $title # const char*
                    ) is native(LIB)  is export { * }

#_UI_EXTERN void uiGroupSetChild(uiGroup *g, uiControl *c);
sub uiGroupSetChild(uiGroup                       $g # Typedef<uiGroup>->«uiGroup»*
                   ,uiControl                     $c # Typedef<uiControl>->«uiControl»*
                    ) is native(LIB)  is export { * }

#_UI_EXTERN int uiGroupMargined(uiGroup *g);
sub uiGroupMargined(uiGroup $g # Typedef<uiGroup>->«uiGroup»*
                    ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiGroupSetMargined(uiGroup *g, int margined);
sub uiGroupSetMargined(uiGroup                       $g # Typedef<uiGroup>->«uiGroup»*
                      ,int32                         $margined # int
                       ) is native(LIB)  is export { * }

#_UI_EXTERN uiGroup *uiNewGroup(const char *title);
sub uiNewGroup(Str $title # const char*
               ) is native(LIB) returns uiGroup is export { * }

#define uiSpinbox(this) ((uiSpinbox *) (this))
#_UI_EXTERN intmax_t uiSpinboxValue(uiSpinbox *s);
sub uiSpinboxValue(uiSpinbox $s # Typedef<uiSpinbox>->«uiSpinbox»*
                   ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiSpinboxSetValue(uiSpinbox *s, intmax_t value);
sub uiSpinboxSetValue(uiSpinbox                     $s # Typedef<uiSpinbox>->«uiSpinbox»*
                     ,int32                      $value # Typedef<intmax_t>->«long int»
                      ) is native(LIB)  is export { * }

#_UI_EXTERN void uiSpinboxOnChanged(uiSpinbox *s, void (*f)(uiSpinbox *s, void *data), void *data);
sub uiSpinboxOnChanged(uiSpinbox                     $s # Typedef<uiSpinbox>->«uiSpinbox»*
                      ,&f (uiSpinbox, Pointer) # F:void ( )*
                      ,Pointer                       $data # void*
                       ) is native(LIB)  is export { * }

#_UI_EXTERN uiSpinbox *uiNewSpinbox(intmax_t min, intmax_t max);
sub uiNewSpinbox(int64                      $min # Typedef<intmax_t>->«long int»
                ,int64                      $max # Typedef<intmax_t>->«long int»
                 ) is native(LIB) returns uiSpinbox is export { * }

##define uiSlider(this) ((uiSlider *) (this))
#_UI_EXTERN intmax_t uiSliderValue(uiSlider *s);
sub uiSliderValue(uiSlider $s # Typedef<uiSlider>->«uiSlider»*
                  ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiSliderSetValue(uiSlider *s, intmax_t value);
sub uiSliderSetValue(uiSlider                      $s # Typedef<uiSlider>->«uiSlider»*
                    ,int64                     $value # Typedef<intmax_t>->«long int»
                     ) is native(LIB)  is export { * }

#_UI_EXTERN void uiSliderOnChanged(uiSlider *s, void (*f)(uiSlider *s, void *data), void *data);
sub uiSliderOnChanged(uiSlider                      $s # Typedef<uiSlider>->«uiSlider»*
                     ,&f (uiSlider, Pointer) # F:void (uiSlider *, void * )*
                     ,Pointer                       $data # void*
                      ) is native(LIB)  is export { * }

#_UI_EXTERN uiSlider *uiNewSlider(intmax_t min, intmax_t max);
sub uiNewSlider(int64                      $min # Typedef<intmax_t>->«long int»
               ,int64                      $max # Typedef<intmax_t>->«long int»
                ) is native(LIB) returns uiSlider is export { * }

##define uiProgressBar(this) ((uiProgressBar *) (this))
#// TODO uiProgressBarValue()
### TODO Enable when libui implements code ###
#sub uiProgressBarValue(uiProgressBar
#											) is native (LIB) is export { * }

#_UI_EXTERN void uiProgressBarSetValue(uiProgressBar *p, int n);
sub uiProgressBarSetValue(uiProgressBar                 $p # Typedef<uiProgressBar>->«uiProgressBar»*
                         ,int32                         $n # int
                          ) is native(LIB)  is export { * }

#_UI_EXTERN uiProgressBar *uiNewProgressBar(void);
sub uiNewProgressBar(
                     ) is native(LIB) returns uiProgressBar is export { * }

##define uiSeparator(this) ((uiSeparator *) (this))
#_UI_EXTERN uiSeparator *uiNewHorizontalSeparator(void);
sub uiNewHorizontalSeparator(
                             ) is native(LIB) returns uiSeparator is export { * }

#_UI_EXTERN uiSeparator *uiNewVerticalSeparator(void);
sub uiNewVerticalSeparator(
                           ) is native(LIB) returns uiSeparator is export { * }

##define uiCombobox(this) ((uiCombobox *) (this))
#_UI_EXTERN void uiComboboxAppend(uiCombobox *c, const char *text);
sub uiComboboxAppend(uiCombobox                    $c # Typedef<uiCombobox>->«uiCombobox»*
                    ,Str                           $text # const char*
                     ) is native(LIB)  is export { * }

#_UI_EXTERN intmax_t uiComboboxSelected(uiCombobox *c);
sub uiComboboxSelected(uiCombobox $c # Typedef<uiCombobox>->«uiCombobox»*
                       ) is native(LIB) returns int64 is export { * }

#_UI_EXTERN void uiComboboxSetSelected(uiCombobox *c, intmax_t n);
sub uiComboboxSetSelected(uiCombobox                    $c # Typedef<uiCombobox>->«uiCombobox»*
                         ,int64                      $n # Typedef<intmax_t>->«long int»
                          ) is native(LIB)  is export { * }

#_UI_EXTERN void uiComboboxOnSelected(uiCombobox *c, void (*f)(uiCombobox *c, void *data), void *data);
sub uiComboboxOnSelected(uiCombobox                    $c # Typedef<uiCombobox>->«uiCombobox»*
                        ,&f (uiCombobox, Pointer) # F:void ( )*
                        ,Pointer                       $data # void*
                         ) is native(LIB)  is export { * }

#_UI_EXTERN uiCombobox *uiNewCombobox(void)
sub uiNewCombobox(
                  ) is native(LIB) returns uiCombobox is export { * }

##define uiEditableCombobox(this) ((uiEditableCombobox *) (this))
#_UI_EXTERN void uiEditableComboboxAppend(uiEditableCombobox *c, const char *text);
sub uiEditableComboboxAppend(uiEditableCombobox            $c # Typedef<uiEditableCombobox>->«uiEditableCombobox»*
                            ,Str                           $text # const char*
                             ) is native(LIB)  is export { * }

#_UI_EXTERN char *uiEditableComboboxText(uiEditableCombobox *c);
sub uiEditableComboboxText(uiEditableCombobox $c # Typedef<uiEditableCombobox>->«uiEditableCombobox»*
                           ) is native(LIB) returns Str is export { * }

#_UI_EXTERN void uiEditableComboboxSetText(uiEditableCombobox *c, const char *text);
sub uiEditableComboboxSetText(uiEditableCombobox            $c # Typedef<uiEditableCombobox>->«uiEditableCombobox»*
                             ,Str                           $text # const char*
                              ) is native(LIB)  is export { * }

#// TODO what do we call a function that sets the currently selected item and fills the text field with it? editable comboboxes have no consistent concept of selected item
#_UI_EXTERN void uiEditableComboboxOnChanged(uiEditableCombobox *c, void (*f)(uiEditableCombobox *c, void *data), void *data);
sub uiEditableComboboxOnChanged(uiEditableCombobox            $c # Typedef<uiEditableCombobox>->«uiEditableCombobox»*
                               ,&f (uiEditableCombobox, Pointer) # F:void ( )*
                               ,Pointer                       $data # void*
                                ) is native(LIB)  is export { * }

#_UI_EXTERN uiEditableCombobox *uiNewEditableCombobox(void);
sub uiNewEditableCombobox(
                          ) is native(LIB) returns uiEditableCombobox is export { * }

##define uiRadioButtons(this) ((uiRadioButtons *) (this))
#_UI_EXTERN void uiRadioButtonsAppend(uiRadioButtons *r, const char *text);
sub uiRadioButtonsAppend(uiRadioButtons                $r # Typedef<uiRadioButtons>->«uiRadioButtons»*
                        ,Str                           $text # const char*
                         ) is native(LIB)  is export { * }

#_UI_EXTERN uiRadioButtons *uiNewRadioButtons(void);
sub uiNewRadioButtons(
                      ) is native(LIB) returns uiRadioButtons is export { * }


sub uiRadioButtonsSelected(uiRadioButtons  $r
													) is native(LIB) returns int32 is export { * }

sub uiRadioButtonsSetSelected(uiRadioButtons  $r
														 ,int32 					$n
														 ) is native(LIB) returns int32 is export { * }

sub uiRadioButtonsOnSelected(uiRadioButtons 	$r
														,&f (uiRadioButtons, Pointer)
														, Pointer 				$data
														) is native(LIB) is export { * }

##define uiDateTimePicker(this) ((uiDateTimePicker *) (this))
#_UI_EXTERN uiDateTimePicker *uiNewDateTimePicker(void);
sub uiNewDateTimePicker(
                        ) is native(LIB) returns uiDateTimePicker is export { * }

#_UI_EXTERN uiDateTimePicker *uiNewDatePicker(void);
sub uiNewDatePicker(
                    ) is native(LIB) returns uiDateTimePicker is export { * }

#_UI_EXTERN uiDateTimePicker *uiNewTimePicker(void);
sub uiNewTimePicker(
                    ) is native(LIB) returns uiDateTimePicker is export { * }

##define uiMultilineEntry(this) ((uiMultilineEntry *) (this))
#_UI_EXTERN char *uiMultilineEntryText(uiMultilineEntry *e);
sub uiMultilineEntryText(uiMultilineEntry $e # Typedef<uiMultilineEntry>->«uiMultilineEntry»*
                         ) is native(LIB) returns Str is export { * }

#_UI_EXTERN void uiMultilineEntrySetText(uiMultilineEntry *e, const char *text);
sub uiMultilineEntrySetText(uiMultilineEntry              $e # Typedef<uiMultilineEntry>->«uiMultilineEntry»*
                           ,Str                           $text # const char*
                            ) is native(LIB)  is export { * }

#_UI_EXTERN void uiMultilineEntryAppend(uiMultilineEntry *e, const char *text);
sub uiMultilineEntryAppend(uiMultilineEntry              $e # Typedef<uiMultilineEntry>->«uiMultilineEntry»*
                          ,Str                           $text # const char*
                           ) is native(LIB)  is export { * }

#_UI_EXTERN void uiMultilineEntryOnChanged(uiMultilineEntry *e, void (*f)(uiMultilineEntry *e, void *data), void *data);
sub uiMultilineEntryOnChanged(uiMultilineEntry              $e # Typedef<uiMultilineEntry>->«uiMultilineEntry»*
                             ,&f (uiMultilineEntry, Pointer) # F:void ( )*
                             ,Pointer                       $data # void*
                              ) is native(LIB)  is export { * }

#_UI_EXTERN int uiMultilineEntryReadOnly(uiMultilineEntry *e);
sub uiMultilineEntryReadOnly(uiMultilineEntry $e # Typedef<uiMultilineEntry>->«uiMultilineEntry»*
                             ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiMultilineEntrySetReadOnly(uiMultilineEntry *e, int readonly);
sub uiMultilineEntrySetReadOnly(uiMultilineEntry              $e # Typedef<uiMultilineEntry>->«uiMultilineEntry»*
                               ,int32                         $readonly # int
                                ) is native(LIB)  is export { * }

#_UI_EXTERN uiMultilineEntry *uiNewMultilineEntry(void);
sub uiNewMultilineEntry(
                        ) is native(LIB) returns uiMultilineEntry is export { * }

#_UI_EXTERN uiMultilineEntry *uiNewNonWrappingMultilineEntry(void);
sub uiNewNonWrappingMultilineEntry(
                                   ) is native(LIB) returns uiMultilineEntry is export { * }

##define uiMenuItem(this) ((uiMenuItem *) (this))
#_UI_EXTERN void uiMenuItemEnable(uiMenuItem *m);
sub uiMenuItemEnable(uiMenuItem $m # Typedef<uiMenuItem>->«uiMenuItem»*
                     ) is native(LIB)  is export { * }

#_UI_EXTERN void uiMenuItemDisable(uiMenuItem *m);
sub uiMenuItemDisable(uiMenuItem $m # Typedef<uiMenuItem>->«uiMenuItem»*
                      ) is native(LIB)  is export { * }

#_UI_EXTERN void uiMenuItemOnClicked(uiMenuItem *m, void (*f)(uiMenuItem *sender, uiWindow *window, void *data), void *data);
sub uiMenuItemOnClicked(uiMenuItem                    $m # Typedef<uiMenuItem>->«uiMenuItem»*
                       ,&f (uiMenuItem, Pointer) # F:void ( )*
                       ,Pointer                       $data # void*
                        ) is native(LIB)  is export { * }

#_UI_EXTERN int uiMenuItemChecked(uiMenuItem *m);
sub uiMenuItemChecked(uiMenuItem $m # Typedef<uiMenuItem>->«uiMenuItem»*
                      ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiMenuItemSetChecked(uiMenuItem *m, int checked);
sub uiMenuItemSetChecked(uiMenuItem                    $m # Typedef<uiMenuItem>->«uiMenuItem»*
                        ,int32                         $checked # int
                         ) is native(LIB)  is export { * }

##define uiMenu(this) ((uiMenu *) (this))
#_UI_EXTERN uiMenuItem *uiMenuAppendItem(uiMenu *m, const char *name);
sub uiMenuAppendItem(uiMenu                        $m # Typedef<uiMenu>->«uiMenu»*
                    ,Str                           $name # const char*
                     ) is native(LIB) returns uiMenuItem is export { * }

#_UI_EXTERN uiMenuItem *uiMenuAppendCheckItem(uiMenu *m, const char *name);
sub uiMenuAppendCheckItem(uiMenu                        $m # Typedef<uiMenu>->«uiMenu»*
                         ,Str                           $name # const char*
                          ) is native(LIB) returns uiMenuItem is export { * }

#_UI_EXTERN uiMenuItem *uiMenuAppendQuitItem(uiMenu *m);
sub uiMenuAppendQuitItem(uiMenu $m # Typedef<uiMenu>->«uiMenu»*
                         ) is native(LIB) returns uiMenuItem is export { * }

#_UI_EXTERN uiMenuItem *uiMenuAppendPreferencesItem(uiMenu *m);
sub uiMenuAppendPreferencesItem(uiMenu $m # Typedef<uiMenu>->«uiMenu»*
                                ) is native(LIB) returns uiMenuItem is export { * }

#_UI_EXTERN uiMenuItem *uiMenuAppendAboutItem(uiMenu *m);
sub uiMenuAppendAboutItem(uiMenu $m # Typedef<uiMenu>->«uiMenu»*
                          ) is native(LIB) returns uiMenuItem is export { * }

#_UI_EXTERN void uiMenuAppendSeparator(uiMenu *m);
sub uiMenuAppendSeparator(uiMenu $m # Typedef<uiMenu>->«uiMenu»*
                          ) is native(LIB)  is export { * }

#_UI_EXTERN uiMenu *uiNewMenu(const char *name);
sub uiNewMenu(Str $name # const char*
              ) is native(LIB) returns uiMenu is export { * }

#_UI_EXTERN char *uiOpenFile(uiWindow *parent);
sub uiOpenFile(uiWindow $parent # Typedef<uiWindow>->«uiWindow»*
               ) is native(LIB) returns Str is export { * }

#_UI_EXTERN char *uiSaveFile(uiWindow *parent);
sub uiSaveFile(uiWindow $parent # Typedef<uiWindow>->«uiWindow»*
               ) is native(LIB) returns Str is export { * }

#_UI_EXTERN void uiMsgBox(uiWindow *parent, const char *title, const char *description);
sub uiMsgBox(uiWindow                      $parent # Typedef<uiWindow>->«uiWindow»*
            ,Str                           $title # const char*
            ,Str                           $description # const char*
             ) is native(LIB)  is export { * }

#_UI_EXTERN void uiMsgBoxError(uiWindow *parent, const char *title, const char *description);
sub uiMsgBoxError(uiWindow                      $parent # Typedef<uiWindow>->«uiWindow»*
                 ,Str                           $title # const char*
                 ,Str                           $description # const char*
                  ) is native(LIB)  is export { * }

##define uiArea(this) ((uiArea *) (this))
#// TODO give a better name
#// TODO document the types of width and height
#_UI_EXTERN void uiAreaSetSize(uiArea *a, intmax_t width, intmax_t height);
sub uiAreaSetSize(uiArea                        $a # Typedef<uiArea>->«uiArea»*
                 ,int64                      $width # Typedef<intmax_t>->«long int»
                 ,int64                      $height # Typedef<intmax_t>->«long int»
                  ) is native(LIB)  is export { * }

#// TODO uiAreaQueueRedraw()
#_UI_EXTERN void uiAreaQueueRedrawAll(uiArea *a);
sub uiAreaQueueRedrawAll(uiArea $a # Typedef<uiArea>->«uiArea»*
                         ) is native(LIB)  is export { * }

#_UI_EXTERN void uiAreaScrollTo(uiArea *a, double x, double y, double width, double height);
sub uiAreaScrollTo(uiArea                        $a # Typedef<uiArea>->«uiArea»*
                  ,num64                         $x # double
                  ,num64                         $y # double
                  ,num64                         $width # double
                  ,num64                         $height # double
                   ) is native(LIB)  is export { * }

#_UI_EXTERN uiArea *uiNewArea(uiAreaHandler *ah);
sub uiNewArea(uiAreaHandler $ah # Typedef<uiAreaHandler>->«uiAreaHandler»*
              ) is native(LIB) returns uiArea is export { * }

#_UI_EXTERN uiArea *uiNewScrollingArea(uiAreaHandler *ah, intmax_t width, intmax_t height);
sub uiNewScrollingArea(uiAreaHandler                 $ah # Typedef<uiAreaHandler>->«uiAreaHandler»*
                      ,int64                      $width # Typedef<intmax_t>->«long int»
                      ,int64                      $height # Typedef<intmax_t>->«long int»
                       ) is native(LIB) returns uiArea is export { * }

#_UI_EXTERN uiDrawPath *uiDrawNewPath(uiDrawFillMode fillMode);
sub uiDrawNewPath(uint32 $fillMode # Typedef<uiDrawFillMode>->«unsigned int»
                  ) is native(LIB) returns uiDrawPath is export { * }

#_UI_EXTERN void uiDrawFreePath(uiDrawPath *p);
sub uiDrawFreePath(uiDrawPath $p # Typedef<uiDrawPath>->«uiDrawPath»*
                   ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawPathNewFigure(uiDrawPath *p, double x, double y);
sub uiDrawPathNewFigure(uiDrawPath                    $p # Typedef<uiDrawPath>->«uiDrawPath»*
                       ,num64                         $x # double
                       ,num64                         $y # double
                        ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawPathNewFigureWithArc(uiDrawPath *p, double xCenter, double yCenter, double radius, double startAngle, double sweep, int negative);
sub uiDrawPathNewFigureWithArc(uiDrawPath                    $p # Typedef<uiDrawPath>->«uiDrawPath»*
                              ,num64                         $xCenter # double
                              ,num64                         $yCenter # double
                              ,num64                         $radius # double
                              ,num64                         $startAngle # double
                              ,num64                         $sweep # double
                              ,int32                         $negative # int
                               ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawPathLineTo(uiDrawPath *p, double x, double y);
sub uiDrawPathLineTo(uiDrawPath                    $p # Typedef<uiDrawPath>->«uiDrawPath»*
                    ,num64                         $x # double
                    ,num64                         $y # double
                     ) is native(LIB)  is export { * }

#// notes: angles are both relative to 0 and go counterclockwise
#// TODO is the initial line segment on cairo and OS X a proper join?
#// TODO what if sweep < 0?
#_UI_EXTERN void uiDrawPathArcTo(uiDrawPath *p, double xCenter, double yCenter, double radius, double startAngle, double sweep, int negative);
sub uiDrawPathArcTo(uiDrawPath                    $p # Typedef<uiDrawPath>->«uiDrawPath»*
                   ,num64                         $xCenter # double
                   ,num64                         $yCenter # double
                   ,num64                         $radius # double
                   ,num64                         $startAngle # double
                   ,num64                         $sweep # double
                   ,int32                         $negative # int
                    ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawPathBezierTo(uiDrawPath *p, double c1x, double c1y, double c2x, double c2y, double endX, double endY);
sub uiDrawPathBezierTo(uiDrawPath                    $p # Typedef<uiDrawPath>->«uiDrawPath»*
                      ,num64                         $c1x # double
                      ,num64                         $c1y # double
                      ,num64                         $c2x # double
                      ,num64                         $c2y # double
                      ,num64                         $endX # double
                      ,num64                         $endY # double
                       ) is native(LIB)  is export { * }

#// TODO quadratic bezier
#_UI_EXTERN void uiDrawPathCloseFigure(uiDrawPath *p);
sub uiDrawPathCloseFigure(uiDrawPath $p # Typedef<uiDrawPath>->«uiDrawPath»*
                          ) is native(LIB)  is export { * }

#// TODO effect of these when a figure is already started
#_UI_EXTERN void uiDrawPathAddRectangle(uiDrawPath *p, double x, double y, double width, double height);
sub uiDrawPathAddRectangle(uiDrawPath                    $p # Typedef<uiDrawPath>->«uiDrawPath»*
                          ,num64                         $x # double
                          ,num64                         $y # double
                          ,num64                         $width # double
                          ,num64                         $height # double
                           ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawPathEnd(uiDrawPath *p);
sub uiDrawPathEnd(uiDrawPath $p # Typedef<uiDrawPath>->«uiDrawPath»*
                  ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawStroke(uiDrawContext *c, uiDrawPath *path, uiDrawBrush *b, uiDrawStrokeParams *p);
sub uiDrawStroke(uiDrawContext                 $c # Typedef<uiDrawContext>->«uiDrawContext»*
                ,uiDrawPath                    $path # Typedef<uiDrawPath>->«uiDrawPath»*
                ,uiDrawBrush                   $b # Typedef<uiDrawBrush>->«uiDrawBrush»*
                ,uiDrawStrokeParams            $p # Typedef<uiDrawStrokeParams>->«uiDrawStrokeParams»*
                 ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawFill(uiDrawContext *c, uiDrawPath *path, uiDrawBrush *b);
sub uiDrawFill(uiDrawContext                 $c # Typedef<uiDrawContext>->«uiDrawContext»*
              ,uiDrawPath                    $path # Typedef<uiDrawPath>->«uiDrawPath»*
              ,uiDrawBrush                   $b # Typedef<uiDrawBrush>->«uiDrawBrush»*
               ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawMatrixSetIdentity(uiDrawMatrix *m);
sub uiDrawMatrixSetIdentity(uiDrawMatrix $m # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                            ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawMatrixTranslate(uiDrawMatrix *m, double x, double y);
sub uiDrawMatrixTranslate(uiDrawMatrix                  $m # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                         ,num64                         $x # double
                         ,num64                         $y # double
                          ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawMatrixScale(uiDrawMatrix *m, double xCenter, double yCenter, double x, double y);
sub uiDrawMatrixScale(uiDrawMatrix                  $m # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                     ,num64                         $xCenter # double
                     ,num64                         $yCenter # double
                     ,num64                         $x # double
                     ,num64                         $y # double
                      ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawMatrixRotate(uiDrawMatrix *m, double x, double y, double amount);
sub uiDrawMatrixRotate(uiDrawMatrix                  $m # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                      ,num64                         $x # double
                      ,num64                         $y # double
                      ,num64                         $amount # double
                       ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawMatrixSkew(uiDrawMatrix *m, double x, double y, double xamount, double yamount);
sub uiDrawMatrixSkew(uiDrawMatrix                  $m # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                    ,num64                         $x # double
                    ,num64                         $y # double
                    ,num64                         $xamount # double
                    ,num64                         $yamount # double
                     ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawMatrixMultiply(uiDrawMatrix *dest, uiDrawMatrix *src);
sub uiDrawMatrixMultiply(uiDrawMatrix                  $dest # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                        ,uiDrawMatrix                  $src # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                         ) is native(LIB)  is export { * }

#_UI_EXTERN int uiDrawMatrixInvertible(uiDrawMatrix *m);
sub uiDrawMatrixInvertible(uiDrawMatrix $m # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                           ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN int uiDrawMatrixInvert(uiDrawMatrix *m);
sub uiDrawMatrixInvert(uiDrawMatrix $m # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                       ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiDrawMatrixTransformPoint(uiDrawMatrix *m, double *x, double *y);
sub uiDrawMatrixTransformPoint(uiDrawMatrix                  $m # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                              ,Pointer[num64]                $x # double*
                              ,Pointer[num64]                $y # double*
                               ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawMatrixTransformSize(uiDrawMatrix *m, double *x, double *y);
sub uiDrawMatrixTransformSize(uiDrawMatrix                  $m # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                             ,Pointer[num64]                $x # double*
                             ,Pointer[num64]                $y # double*
                              ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawTransform(uiDrawContext *c, uiDrawMatrix *m);
sub uiDrawTransform(uiDrawContext                 $c # Typedef<uiDrawContext>->«uiDrawContext»*
                   ,uiDrawMatrix                  $m # Typedef<uiDrawMatrix>->«uiDrawMatrix»*
                    ) is native(LIB)  is export { * }

#// TODO add a uiDrawPathStrokeToFill() or something like that
#_UI_EXTERN void uiDrawClip(uiDrawContext *c, uiDrawPath *path);
sub uiDrawClip(uiDrawContext                 $c # Typedef<uiDrawContext>->«uiDrawContext»*
              ,uiDrawPath                    $path # Typedef<uiDrawPath>->«uiDrawPath»*
               ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawSave(uiDrawContext *c);
sub uiDrawSave(uiDrawContext $c # Typedef<uiDrawContext>->«uiDrawContext»*
               ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawRestore(uiDrawContext *c);
sub uiDrawRestore(uiDrawContext $c # Typedef<uiDrawContext>->«uiDrawContext»*
                  ) is native(LIB)  is export { * }

#_UI_EXTERN uiDrawFontFamilies *uiDrawListFontFamilies(void);
sub uiDrawListFontFamilies(
                           ) is native(LIB) returns uiDrawFontFamilies is export { * }

#_UI_EXTERN uintmax_t uiDrawFontFamiliesNumFamilies(uiDrawFontFamilies *ff);
sub uiDrawFontFamiliesNumFamilies(uiDrawFontFamilies $ff # Typedef<uiDrawFontFamilies>->«uiDrawFontFamilies»*
                                  ) is native(LIB) returns uint64 is export { * }

#_UI_EXTERN char *uiDrawFontFamiliesFamily(uiDrawFontFamilies *ff, uintmax_t n);
sub uiDrawFontFamiliesFamily(uiDrawFontFamilies            $ff # Typedef<uiDrawFontFamilies>->«uiDrawFontFamilies»*
                            ,uint64                     $n # Typedef<uintmax_t>->«long unsigned int»
                             ) is native(LIB) returns Str is export { * }

#_UI_EXTERN void uiDrawFreeFontFamilies(uiDrawFontFamilies *ff);
sub uiDrawFreeFontFamilies(uiDrawFontFamilies $ff # Typedef<uiDrawFontFamilies>->«uiDrawFontFamilies»*
                           ) is native(LIB)  is export { * }

#_UI_EXTERN uiDrawTextFont *uiDrawLoadClosestFont(const uiDrawTextFontDescriptor *desc);
sub uiDrawLoadClosestFont(uiDrawTextFontDescriptor $desc # const Typedef<uiDrawTextFontDescriptor>->«uiDrawTextFontDescriptor»*
                          ) is native(LIB) returns uiDrawTextFont is export { * }

#_UI_EXTERN void uiDrawFreeTextFont(uiDrawTextFont *font);
sub uiDrawFreeTextFont(uiDrawTextFont $font # Typedef<uiDrawTextFont>->«uiDrawTextFont»*
                       ) is native(LIB)  is export { * }

#_UI_EXTERN uintptr_t uiDrawTextFontHandle(uiDrawTextFont *font);
sub uiDrawTextFontHandle(uiDrawTextFont $font # Typedef<uiDrawTextFont>->«uiDrawTextFont»*
                         ) is native(LIB) returns uint64 is export { * }

#_UI_EXTERN void uiDrawTextFontDescribe(uiDrawTextFont *font, uiDrawTextFontDescriptor *desc);
sub uiDrawTextFontDescribe(uiDrawTextFont                $font # Typedef<uiDrawTextFont>->«uiDrawTextFont»*
                          ,uiDrawTextFontDescriptor      $desc # Typedef<uiDrawTextFontDescriptor>->«uiDrawTextFontDescriptor»*
                           ) is native(LIB)  is export { * }

#// TODO make copy with given attributes methods?
#// TODO yuck this name
#_UI_EXTERN void uiDrawTextFontGetMetrics(uiDrawTextFont *font, uiDrawTextFontMetrics *metrics);
sub uiDrawTextFontGetMetrics(uiDrawTextFont                $font # Typedef<uiDrawTextFont>->«uiDrawTextFont»*
                            ,uiDrawTextFontMetrics         $metrics # Typedef<uiDrawTextFontMetrics>->«uiDrawTextFontMetrics»*
                             ) is native(LIB)  is export { * }

#// TODO initial line spacing? and what about leading?
#_UI_EXTERN uiDrawTextLayout *uiDrawNewTextLayout(const char *text, uiDrawTextFont *defaultFont, double width);
sub uiDrawNewTextLayout(Str                           $text # const char*
                       ,uiDrawTextFont                $defaultFont # Typedef<uiDrawTextFont>->«uiDrawTextFont»*
                       ,num64                         $width # double
                        ) is native(LIB) returns uiDrawTextLayout is export { * }

#_UI_EXTERN void uiDrawFreeTextLayout(uiDrawTextLayout *layout);
sub uiDrawFreeTextLayout(uiDrawTextLayout $layout # Typedef<uiDrawTextLayout>->«uiDrawTextLayout»*
                         ) is native(LIB)  is export { * }

#// TODO get width
#_UI_EXTERN void uiDrawTextLayoutSetWidth(uiDrawTextLayout *layout, double width);
sub uiDrawTextLayoutSetWidth(uiDrawTextLayout              $layout # Typedef<uiDrawTextLayout>->«uiDrawTextLayout»*
                            ,num64                         $width # double
                             ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawTextLayoutExtents(uiDrawTextLayout *layout, double *width, double *height);
sub uiDrawTextLayoutExtents(uiDrawTextLayout              $layout # Typedef<uiDrawTextLayout>->«uiDrawTextLayout»*
                           ,Pointer[num64]                $width # double*
                           ,Pointer[num64]                $height # double*
                            ) is native(LIB)  is export { * }

#// and the attributes that you can set on a text layout
#_UI_EXTERN void uiDrawTextLayoutSetColor(uiDrawTextLayout *layout, intmax_t startChar, intmax_t endChar, double r, double g, double b, double a);
sub uiDrawTextLayoutSetColor(uiDrawTextLayout              $layout # Typedef<uiDrawTextLayout>->«uiDrawTextLayout»*
                            ,int64                      $startChar # Typedef<intmax_t>->«long int»
                            ,int64                      $endChar # Typedef<intmax_t>->«long int»
                            ,num64                         $r # double
                            ,num64                         $g # double
                            ,num64                         $b # double
                            ,num64                         $a # double
                             ) is native(LIB)  is export { * }

#_UI_EXTERN void uiDrawText(uiDrawContext *c, double x, double y, uiDrawTextLayout *layout);
sub uiDrawText(uiDrawContext                 $c # Typedef<uiDrawContext>->«uiDrawContext»*
              ,num64                         $x # double
              ,num64                         $y # double
              ,uiDrawTextLayout              $layout # Typedef<uiDrawTextLayout>->«uiDrawTextLayout»*
               ) is native(LIB)  is export { * }



##define uiFontButton(this) ((uiFontButton *) (this))
#// TODO document this returns a new font
#_UI_EXTERN uiDrawTextFont *uiFontButtonFont(uiFontButton *b);
sub uiFontButtonFont(uiFontButton $b # Typedef<uiFontButton>->«uiFontButton»*
                     ) is native(LIB) returns uiDrawTextFont is export { * }

#// TOOD SetFont, mechanics
#_UI_EXTERN void uiFontButtonOnChanged(uiFontButton *b, void (*f)(uiFontButton *, void *), void *data);
sub uiFontButtonOnChanged(uiFontButton                  $b # Typedef<uiFontButton>->«uiFontButton»*
                         ,&f (uiFontButton, Pointer) # F:void ( )*
                         ,Pointer                       $data # void*
                          ) is native(LIB)  is export { * }

#_UI_EXTERN uiFontButton *uiNewFontButton(void);
sub uiNewFontButton(
                    ) is native(LIB) returns uiFontButton is export { * }


##define uiColorButton(this) ((uiColorButton *) (this))
#_UI_EXTERN void uiColorButtonColor(uiColorButton *b, double *r, double *g, double *bl, double *a);
sub uiColorButtonColor(uiColorButton                 $b # Typedef<uiColorButton>->«uiColorButton»*
                      ,num64                $r is rw # double*
                      ,num64                $g is rw # double*
                      ,num64                $bl is rw # double*
                      ,num64                $a is rw # double*
                       ) is native(LIB)  is export { * }

#_UI_EXTERN void uiColorButtonSetColor(uiColorButton *b, double r, double g, double bl, double a);
sub uiColorButtonSetColor(uiColorButton                 $b # Typedef<uiColorButton>->«uiColorButton»*
                         ,num64                         $r # double
                         ,num64                         $g # double
                         ,num64                         $bl # double
                         ,num64                         $a # double
                          ) is native(LIB)  is export { * }

#_UI_EXTERN void uiColorButtonOnChanged(uiColorButton *b, void (*f)(uiColorButton *, void *), void *data);
sub uiColorButtonOnChanged(uiColorButton                 $b # Typedef<uiColorButton>->«uiColorButton»*
                          ,&f (uiColorButton, Pointer) # F:void ( )*
                          ,Pointer                       $data # void*
                           ) is native(LIB)  is export { * }

#_UI_EXTERN uiColorButton *uiNewColorButton(void);
sub uiNewColorButton(
                     ) is native(LIB) returns uiColorButton is export { * }

##define uiForm(this) ((uiForm *) (this))
#_UI_EXTERN void uiFormAppend(uiForm *f, const char *label, uiControl *c, int stretchy);
#sub uiFormAppend(uiForm                        $f # Typedef<uiForm>->«uiForm»*
#                ,Str                           $label # const char*
#                ,uiControl                     $c # Typedef<uiControl>->«uiControl»*
#                ,int32                         $stretchy # int
#                 ) is native(LIB)  is export { * }

#_UI_EXTERN void uiFormDelete(uiForm *f, int index);
sub uiFormDelete(uiForm                        $f # Typedef<uiForm>->«uiForm»*
                ,int32                         $index # int
                 ) is native(LIB)  is export { * }

#_UI_EXTERN int uiFormPadded(uiForm *f);
sub uiFormPadded(uiForm $f # Typedef<uiForm>->«uiForm»*
                 ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiFormSetPadded(uiForm *f, int padded);
sub uiFormSetPadded(uiForm                        $f # Typedef<uiForm>->«uiForm»*
                   ,int32                         $padded # int
                    ) is native(LIB)  is export { * }

#_UI_EXTERN uiForm *uiNewForm(void);
#sub uiNewForm(
#              ) is native(LIB) returns uiForm is export { * }

##define uiGrid(this) ((uiGrid *) (this))
#_UI_EXTERN void uiGridAppend(uiGrid *g, uiControl *c, int left, int top, int xspan, int yspan, int hexpand, uiAlign halign, int vexpand, uiAlign valign);
sub uiGridAppend(uiGrid                        $g # Typedef<uiGrid>->«uiGrid»*
                ,uiControl                     $c # Typedef<uiControl>->«uiControl»*
                ,int32                         $left # int
                ,int32                         $top # int
                ,int32                         $xspan # int
                ,int32                         $yspan # int
                ,int32                         $hexpand # int
                ,uint32                       $halign # Typedef<uiAlign>->«unsigned int»
                ,int32                         $vexpand # int
                ,uint32                       $valign # Typedef<uiAlign>->«unsigned int»
                 ) is native(LIB)  is export { * }

#_UI_EXTERN void uiGridInsertAt(uiGrid *g, uiControl *c, uiControl *existing, uiAt at, int xspan, int yspan, int hexpand, uiAlign halign, int vexpand, uiAlign valign);
sub uiGridInsertAt(uiGrid                        $g # Typedef<uiGrid>->«uiGrid»*
                  ,uiControl                     $c # Typedef<uiControl>->«uiControl»*
                  ,uiControl                     $existing # Typedef<uiControl>->«uiControl»*
                  ,uint32                          $at # Typedef<uiAt>->«unsigned int»
                  ,int32                         $xspan # int
                  ,int32                         $yspan # int
                  ,int32                         $hexpand # int
                  ,uint32                       $halign # Typedef<uiAlign>->«unsigned int»
                  ,int32                         $vexpand # int
                  ,uint32                       $valign # Typedef<uiAlign>->«unsigned int»
                   ) is native(LIB)  is export { * }

#_UI_EXTERN int uiGridPadded(uiGrid *g);
sub uiGridPadded(uiGrid $g # Typedef<uiGrid>->«uiGrid»*
                 ) is native(LIB) returns int32 is export { * }

#_UI_EXTERN void uiGridSetPadded(uiGrid *g, int padded);
sub uiGridSetPadded(uiGrid                        $g # Typedef<uiGrid>->«uiGrid»*
                   ,int32                         $padded # int
                    ) is native(LIB)  is export { * }

#_UI_EXTERN uiGrid *uiNewGrid(void);
sub uiNewGrid(
              ) is native(LIB) returns uiGrid is export { * }

# Externs



#useful subs

sub uicontrol($control) is export {
	return nativecast(uiControl, $control);
}

sub get-pointer($struct) is export {
	return nativecast(Pointer, $struct);
}
