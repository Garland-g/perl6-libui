use Libui::Raw :lib;

use NativeCall;

enum uiForEach is export(:foreach) (
  uiForEachContinue => 0,
  uiForEachStop => 1,
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

enum uiTextItalic is export(:text) <
  uiTextItalicNormal,
  uiTextItalicOblique,
  uiTextItalicItalic,
>;

enum uiTextStretch is export(:text) <
  uiTextStretchUltraCondensed,
  uiTextStretchExtraCondensed,
  uiTextStretchCondensed,
  uiTextStretchSemiCondensed,
  uiTextStretchNormal,
  uiTextStretchSemiExpanded,
  uiTextStretchExpanded,
  uiTextStretchExtraExpanded,
  uiTextStretchUltraExpanded,
>;

enum uiUnderline is export(:text) <
  uiUnderlineNone,
  uiUnderlineSingle,
  uiUnderlineDouble,
  uiUnderlineSuggestion,
>;

enum uiUnderlineColor is export(:text) <
  uiUnderlineColorCustom,
  uiUnderlineColorSpelling,
  uiUnderlineColorGrammar,
  uiUnderlineColorAuxiliary,
>;

enum uiAttributeType is export(:text) <
  uiAttributeTypeFamily
  uiAttributeTypeSize
  uiAttributeTypeWeight
  uiAtrributeTypeItalic
  uiAttributeTypeStretch
  uiAttributeTypeColor
  uiAttributeTypeBackground
  uiAttributeTypeUnderline
  uiAttributeTypeUnderlineColor
  uiAttrbuteTypeFeatures
>;


class uiOTFeature is repr('CStruct') {
  has int8 $.a;
  has int8 $.b;
  has int8 $.c;
  has int8 $.d;
}

class uiOpenTypeFeatures is repr('CStruct') is export(:text){
  has uiOTFeature $.data;
  has size_t $.len;
  has size_t $.cap;
}


class uiUColor is repr('CStruct') {
  has num64 $.r;
  has num64 $.g;
  has num64 $.b;
  has num64 $.a;
  has int32 $.underlineColor;
}

class uiAttrType is repr('CUnion') {
  has Str $.family;
  has num64 $.size;
  has int32 $.weight;
  has int32 $.italic;
  has int32 $.stretch;
  HAS uiUColor $.color;
}

class uiAttribute is repr('CStruct') is export(:text) {
  has int32 $.ownedByUser;
  has size_t $.refcount;
  has int32 $.type;
  HAS uiAttrType $.u;
  has int32 $.underline;
  has Pointer[uiOpenTypeFeatures] $.features;
}

class uiAttributedString is repr('CStruct') is export(:text) {
  has Str $.s;
  has size_t $len;
  has Pointer $.attrs;
  has Pointer[uint16] $.u16;
  has size_t $.u16len;
  has Pointer[size_t] $.u8tou16;
  has Pointer[size_t] $.u16tou8;

  has Pointer $.graphemes;

  method Str {
    return uiAttributedStringString(self);
  }

  #|This takes byte start and end positions, not grapheme ranges
  method set-attribute-byte-range(uiAttribute $attr, Int $start, Int $end) {
    uiAttributedStringSetAttribute(self, $attr, $start, $end);
  }
}

#Don't use on an attribute that has been given to a uiAttributedString
sub uiFreeAttribute(uiAttribute $a)
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributeGetType(uiAttribute $a)
  returns int32
  is native(LIB)
  is export(:text)
  { * }

sub uiNewFamilyAttribute(Str $family)
  returns uiAttribute
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributeFamily(uiAttribute $a)
  returns Str
  is native(LIB)
  is export(:text)
  { * }

sub uiNewSizeAttribute(num64 $size)
  returns uiAttribute
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributeSize(uiAttribute $a)
  returns num64
  is native(LIB)
  is export(:text)
  { * }

sub uiNewWeightAttribute(uint32 $weight)
  returns uiAttribute
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributeWeight(uiAttribute $a)
  returns uint32
  is native(LIB)
  is export(:text)
  { * }

sub uiNewItalicAttribute(uint32 $italic)
  returns uiAttribute
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributeItalic(uiAttribute $a)
  returns uint32
  is native(LIB)
  is export(:text)
  { * }

sub uiNewStretchAttribute(uint32 $stretch)
  returns uiAttribute
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributeStretch(uiAttribute $a)
  returns uint32
  is native(LIB)
  is export(:text)
  { * }

sub uiNewColorAttribute(num64 $r, num64 $g, num64 $b, num64 $a)
  returns uiAttribute
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributeColor(uiAttribute $a, num64 $r is rw, num64 $g is rw, num64 $b is rw, num64 $alpha is rw)
  is native(LIB)
  is export(:text)
  { * }

sub uiNewBackgroundAttribute(num64 $r, num64 $g, num64 $b, num64 $a)
  returns uiAttribute
  is native(LIB)
  is export(:text)
  { * }

#sub uiAttributeBackground(uiAttribute $a, num64 $r is rw, num64 $g is rw, num64 $b is rw, num64 $alpha is rw)
  #is native(LIB)
  #is export(:text)
  #  { * }

sub uiNewUnderlineAttribute(int32 $u)
  returns uiAttribute
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributeUnderline(uiAttribute $a)
  returns uint32
  is native(LIB)
  is export(:text)
  { * }

sub uiNewUnderlineColorAttribute(int32 $u, num64 $r, num64 $g, num64 $b, num64 $a)
  returns uiAttribute
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributeUnderlineColor(uiAttribute $a
                             ,uint32 $u is rw
                             ,num64 $r is rw
                             ,num64 $g is rw
                             ,num64 $b is rw
                             ,num64 $alpha is rw
                             ) is native(LIB) is export(:text) { * }


sub uiNewOpenTypeFeatures()
  returns uiOpenTypeFeatures
  is native(LIB)
  is export(:text)
  { * }

sub uiFreeOpenTypeFeatures(uiOpenTypeFeatures $otf)
  is native(LIB)
  is export(:text)
  { * }

sub uiOpenTypeFeaturesClone(uiOpenTypeFeatures $otf) returns uiOpenTypeFeatures
  is native(LIB)
  is export(:text)
  { * }

sub uiOpenTypeFeaturesAdd(uiOpenTypeFeatures $otf is rw
                         ,int8 $a
                         ,int8 $b
                         ,int8 $c
                         ,int8 $d
                         ,uint32 $value
                         ) is native(LIB) is export(:text) { * }

sub uiOpenTypeFeaturesRemove(uiOpenTypeFeatures $otf is rw, int8 $a, int8 $b, int8 $c, int8 $d)
  is native(LIB)
  is export(:text)
  { * }

sub uiOpenTypeFeaturesGet(uiOpenTypeFeatures $otf is rw
                         ,int8 $a
                         ,int8 $b
                         ,int8 $c
                         ,int8 $d
                         ,uint32 $value is rw
                         ) returns int32 is native(LIB) is export(:text) { * }

sub uiOpenTypeFeaturesForEach(uiOpenTypeFeatures $otf
                             ,&f ( --> uiForEach)
                             ,Pointer $data
                             ) is native(LIB) is export(:text) { * }

sub uiNewFeaturesAttribute(uiOpenTypeFeatures $otf)
  returns uiAttribute
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributeFeatures(uiAttribute $a)
  returns uiOpenTypeFeatures
  is native(LIB)
  is export(:text)
  { * }

sub uiNewAttributedString(Str $initialString)
  returns uiAttributedString
  is native(LIB)
  is export(:text)
  { * }

sub uiFreeAttributedString(uiAttributedString $s is rw)
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributedStringString(uiAttributedString $s)
  returns Str
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributedStringLen(uiAttributedString $s)
  returns size_t
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributedStringAppendUnattributed(uiAttributedString $s is rw, Str $str)
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributedStringInsertAtUnattributed(uiAttributedString $s is rw, Str $str, size_t $at)
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributedStringDelete(uiAttributedString $s is rw, size_t $start, size_t $end)
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributedStringSetAttribute(uiAttributedString $s is rw, uiAttribute $a is rw, size_t $start, size_t $end)
  is native(LIB)
  is export(:text)
  { * }

sub uiAttributedStringForEachAttribute(uiAttributedString $s, &f ( --> uiForEach), Pointer $data)
  is native(LIB)
  is export(:text)
  { * }

#TODO Make Const when reimplemented
sub uiAttributedStringNumGraphemes(uiAttributedString $s is rw)
  returns size_t
  is native(LIB)
  is export(:text)
  { * }

#TODO Make Const when reimplemented upstream
sub uiAttributedStringByteIndexToGrapheme(uiAttributedString $s is rw, size_t $pos)
  returns size_t
  is native(LIB)
  is export(:text)
  { * }

#TODO Make Const when reimplemented upstream
sub uiAttributedStringGraphemeToByteIndex(uiAttributedString $s is rw, size_t $pos)
  returns size_t
  is native(LIB)
  is export(:text)
  { * }




