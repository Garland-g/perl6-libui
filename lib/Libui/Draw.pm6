use Libui::Raw :lib;
use Libui::Control;
use Libui::FontButton :raw;

use NativeCall;

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
enum uiDrawTextAlign is export(:draw) (
  uiDrawTextAlignLeft => 0,
  uiDrawTextAlignCenter => 1,
  uiDrawTextAlignRight => 2,
);

class uiDrawTextLayoutParams is repr('CStruct') is export(:raw) {
  has Str $.String;
  has uiFontDescriptor $.DefaultFont;
  has num64 $.Width;
  has uint32 $.Align;
}
class uiDrawTextLayout is repr('CStruct') is export(:raw) {
  #Unix
  has Pointer $.layout; #PangoLayout
  #Windows
  #has Pointer $.format; #IDWriteTextFormat
  #has Pointer $.layout #IDWriteTextLayout
  #has Pointer $.backgroundParams;
  #has Pointer[size_t] $.u8tou16;
  #has size_t $.nUTF8;
  #has Pointer[size_t] $.u16tou8;
  #has size_t $.nUTF16;
  #Darwin
  #has Pointer[uiprivTextFrame] $.frame;
  #has Pointer[uiprivTextFrame] $.forLines;
  #has bool empty;
  #has Pointer[size_t] $.u8tou16;
  #has size_t $.nUTF8;
  #has Pointer[size_t] $.u16tou8;
  #has size_t $.nUTF16;
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

sub uiDrawNewPath(uint32 $fillMode)
  returns uiDrawPath
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawFreePath(uiDrawPath $p)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawPathNewFigure(uiDrawPath $p, num64 $x, num64 $y)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawPathNewFigureWithArc(uiDrawPath $p
                              ,num64      $xCenter
                              ,num64      $yCenter
                              ,num64      $radius
                              ,num64      $startAngle
                              ,num64      $sweep
                              ,int32      $negative
                              ) is native(LIB) is export(:raw) { * }


sub uiDrawPathLineTo(uiDrawPath $p, num64 $x, num64 $y)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawPathArcTo(uiDrawPath $p
                   ,num64      $xCenter
                   ,num64      $yCenter
                   ,num64      $radius
                   ,num64      $startAngle
                   ,num64      $sweep
                   ,int32      $negative
                   ) is native(LIB) is export(:raw) { * }


sub uiDrawPathBezierTo(uiDrawPath $p
                      ,num64      $c1x
                      ,num64      $c1y
                      ,num64      $c2x
                      ,num64      $c2y
                      ,num64      $endX
                      ,num64      $endY
                      ) is native(LIB) is export(:raw) { * }



sub uiDrawPathCloseFigure(uiDrawPath $p)
  is native(LIB)
  is export(:raw)
  { * }



sub uiDrawPathAddRectangle(uiDrawPath $p, num64 $x, num64 $y, num64 $width, num64 $height)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawPathEnd(uiDrawPath $p)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawStroke(uiDrawContext $c, uiDrawPath $path, uiDrawBrush $b, uiDrawStrokeParams $p)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawFill(uiDrawContext $c, uiDrawPath $path, uiDrawBrush $b)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawMatrixSetIdentity(uiDrawMatrix $m)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawMatrixTranslate(uiDrawMatrix $m, num64 $x, num64 $y)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawMatrixScale(uiDrawMatrix $m, num64 $xCenter, num64 $yCenter, num64 $x, num64 $y)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawMatrixRotate(uiDrawMatrix $m, num64 $x, num64 $y, num64 $amount)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawMatrixSkew(uiDrawMatrix $m, num64 $x, num64 $y, num64 $xamount, num64 $yamount)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawMatrixMultiply(uiDrawMatrix $dest, uiDrawMatrix $src)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawMatrixInvertible(uiDrawMatrix $m)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawMatrixInvert(uiDrawMatrix $m)
  returns int32
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawMatrixTransformPoint(uiDrawMatrix $m, Pointer[num64] $x, Pointer[num64] $y)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawMatrixTransformSize(uiDrawMatrix $m, Pointer[num64] $x, Pointer[num64] $y)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawTransform(uiDrawContext $c, uiDrawMatrix $m)
  is native(LIB)
  is export(:raw)
  { * }



sub uiDrawClip(uiDrawContext $c, uiDrawPath $path)
  is native(LIB)
  is export(:raw)
  { * }



sub uiDrawSave(uiDrawContext $c)
  is native(LIB)
  is export(:raw)
  { * }


sub uiDrawRestore(uiDrawContext $c)
  is native(LIB)
  is export(:raw)
  { * }

sub uiDrawNewTextLayout(uiDrawTextLayoutParams $params is rw)
  returns uiDrawTextLayout
  is native(LIB)
  is export(:raw)
  { * }

sub uiDrawFreeTextLayout(uiDrawTextLayout $tl)
  is native(LIB)
  is export(:raw)
  { * }

sub uiDrawText(uiDrawContext $c, uiDrawTextLayout $tl, num64 $x, num64 $y)
  is native(LIB)
  is export(:raw)
  { * }

sub uiDrawTextLayoutExtents(uiDrawTextLayout $tl, num64 $width is rw, num64 $height is rw)
  is native(LIB)
  is export(:raw)
  { * }



#TODO Add following functions
#sub uiDrawTextLayoutHeightForWidth()
#sub uiDrawTextLayoutRangeForSize()
#sub uiDrawTextLayoutNewWithNeight()



