use Libui::Raw :lib;

use NativeCall;

class uiImage is repr('CStruct') is export(:raw) {
  #Unix
  has num64 $.width;
  has num64 $.height;
  has Pointer $.images;
  #Windows
  #has num64 $.width;
  #has num64 $.height;
  #has Pointer $.bitmaps;
  #Darwin
  #has Pointer $.i;
  #has NSSize $.size;
  #has Pointer $.swizzled;
}

sub uiNewImage(num64 $width, num64 $height)
  returns uiImage
  is native(LIB)
  is export(:raw)
  { * }

sub uiFreeImage(uiImage $i)
  is native(LIB)
  is export(:raw)
  { * }

sub uiImageAppend(uiImage $i is rw
                 ,Pointer[void] $pixels
                 ,int32 $pixelWidth
                 ,int32 $pixelHeight
                 ,int32 $byteStride
                 ) is native(LIB) is export(:raw) { * }

