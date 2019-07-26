use Libui::Raw :lib;
use Libui::Control;

use NativeCall;

enum uiWindowResizeEdge is export(:Window) (
  uiWindowResizeEdgeLeft => 0,
  uiWindowResizeEdgeTop => 1,
  uiWindowResizeEdgeRight => 2,
  uiWindowResizeEdgeBottom => 3,
  uiWindowResizeEdgeTopLeft => 4,
  uiWindowResizeEdgeTopRight => 5,
  uiWindowResizeEdgeBottomLeft => 6,
  uiWindowResizeEdgeBottomRight => 7,
);

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

class uiAreaHandler is repr('CStruct') is export(:area) {
  has Pointer                       $.Draw; # F:void ( )* Draw
  has Pointer                       $.MouseEvent; # F:void ( )* MouseEvent
  has Pointer                       $.MouseCrossed; # F:void ( )* MouseCrossed
  has Pointer                       $.DragBroken; # F:void ( )* DragBroken
  has Pointer                       $.KeyEvent; # F:int ( )* KeyEvent
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

sub uiAreaBeginUserWindowMove(uiArea $a)
  is native(LIB)
  is export(:area)
  { * }

sub uiAreaBeginUserWindowResize(uiArea $a, int32 $edge)
  is native(LIB)
  is export(:area)
  { * }

sub uiNewScrollingArea(uiAreaHandler $ah, int64 $width, int64 $height)
  returns uiArea
  is native(LIB)
  is export(:area)
  { * }

