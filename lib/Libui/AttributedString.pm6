use Libui::Raw :lib;
use Libui::Attribute :raw;
use Libui::OpenTypeFeatures :foreach;

use NativeCall;

unit class uiAttributedString is repr('CStruct') is export(:DEFAULT);
sub uiNewAttributedString(Str $initialString)
  returns uiAttributedString
  is native(LIB)
  is export(:raw)
  { * }

sub uiFreeAttributedString(uiAttributedString $s is rw)
  is native(LIB)
  is export(:raw)
  { * }

sub uiAttributedStringString(uiAttributedString $s)
  returns Str
  is native(LIB)
  is export(:raw)
  { * }

sub uiAttributedStringLen(uiAttributedString $s)
  returns size_t
  is native(LIB)
  is export(:raw)
  { * }

sub uiAttributedStringAppendUnattributed(uiAttributedString $s is rw, Str $str)
  is native(LIB)
  is export(:raw)
  { * }

sub uiAttributedStringInsertAtUnattributed(uiAttributedString $s is rw, Str $str, size_t $at)
  is native(LIB)
  is export(:raw)
  { * }

sub uiAttributedStringDelete(uiAttributedString $s is rw, size_t $start, size_t $end)
  is native(LIB)
  is export(:raw)
  { * }

sub uiAttributedStringSetAttribute(uiAttributedString $s is rw, uiAttribute $a is rw, size_t $start, size_t $end)
  is native(LIB)
  is export(:raw)
  { * }

sub uiAttributedStringForEachAttribute(uiAttributedString $s, &f ( --> uiForEach), Pointer $data)
  is native(LIB)
  is export(:raw)
  { * }

#TODO Make Const when reimplemented
sub uiAttributedStringNumGraphemes(uiAttributedString $s is rw)
    returns size_t is native(LIB) is export(:raw) { * }

#TODO Make Const when reimplemented upstream
sub uiAttributedStringByteIndexToGrapheme(uiAttributedString $s is rw, size_t $pos)
  returns size_t is native(LIB) is export(:raw) { * }

#TODO Make Const when reimplemented upstream
sub uiAttributedStringGraphemeToByteIndex(uiAttributedString $s is rw, size_t $pos)
  returns size_t is native(LIB) is export(:raw) { * }

has Str $.s;
has size_t $len;
has Pointer $.attrs;
has Pointer[uint16] $.u16;
has size_t $.u16len;
has Pointer[size_t] $.u8tou16;
has Pointer[size_t] $.u16tou8;

has Pointer $.graphemes;

method new(Str :$string --> uiAttributedString) {
  return uiNewAttributedString($string);
}

method free(--> Nil) {
  uiFreeAttributedString(self);
}

method Str {
  return uiAttributedStringString(self);
}

method bytes(--> UInt) {
  uiAttributedStringLen(self);
}

method append-unattributed(Str $string --> Nil) {
  uiAttributedStringAppendUnattributed(self, $string);
}

method insert-unattributed(Str $string, UInt $at --> Nil) {
  uiAttributedStringInsertAtUnattributed(self, $string, $at);
}

method delete(UInt $start, UInt $end --> Nil) {
  uiAttributedStringDelete(self, $start, $end);
}

#|This takes byte start and end positions, not grapheme ranges
method set-attribute-byte-range(uiAttribute $attr, Int $start, Int $end) {
  uiAttributedStringSetAttribute(self, $attr, $start, $end);
}

method chars(--> UInt) {
  uiAttributedStringNumGraphemes(self);
}

method byte-index-to-grapheme(UInt $pos) {
  uiAttributedStringByteIndexToGrapheme(self, $pos);
}

method grapheme-to-byte-index(UInt $pos) {
  uiAttributedStringGraphemeToByteIndex(self, $pos);
}


