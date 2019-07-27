use Libui::Raw :lib;
use Libui::OpenTypeFeatures :ALL;

use Color;
use NativeCall;

unit module Attribute;

enum uiTextWeight is export(:enum) (
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

enum uiTextItalic is export(:enum) <
  uiTextItalicNormal,
  uiTextItalicOblique,
  uiTextItalicItalic,
>;

enum uiTextStretch is export(:enum) <
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

enum uiUnderline is export(:enum) <
  uiUnderlineNone,
  uiUnderlineSingle,
  uiUnderlineDouble,
  uiUnderlineSuggestion,
>;

enum uiUnderlineColor is export(:enum) <
  uiUnderlineColorCustom,
  uiUnderlineColorSpelling,
  uiUnderlineColorGrammar,
  uiUnderlineColorAuxiliary,
>;

enum uiAttributeType is export(:enum) <
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


  class uiUColor is repr('CStruct') is export(:raw){
    has num64 $.r;
    has num64 $.g;
    has num64 $.b;
    has num64 $.a;
    has int32 $.underlineColor;
  }

  class uiAttrType is repr('CUnion') is export(:raw) {
    has Str $.family;
    has num64 $.size;
    has int32 $.weight;
    has int32 $.italic;
    has int32 $.stretch;
    HAS uiUColor $.color;
  }

  class uiAttribute is repr('CStruct') is export(:raw) {
    has int32 $.ownedByUser;
    has size_t $.refcount;
    has int32 $.type;
    HAS uiAttrType $.u;
    has int32 $.underline;
    has Pointer[uiOpenTypeFeatures] $.features;
  }

role Attribute {
  #Don't use on an attribute that has been given to a uiAttributedString
  sub uiFreeAttribute(uiAttribute $a)
    is native(LIB)
    is export(:raw)
    { * }

  sub uiAttributeGetType(uiAttribute $a)
    returns int32
    is native(LIB)
    is export(:raw)
    { * }


  has uiAttribute $.attribute;
  has Bool $.given = False;

  method free {
    if $!given {
      return fail "Cannot free a uiAttribute that is in use";
    } else {
      uiFreeAttribute($!attribute);
    }
  }

  method type(--> Int) {
    uiAttributeGetType($!attribute);
  }
}

class Family does Attribute {
  sub uiNewFamilyAttribute(Str $family)
    returns uiAttribute
    is native(LIB)
    is export(:raw)
    { * }

  sub uiAttributeFamily(uiAttribute $a)
    returns Str
    is native(LIB)
    is export(:raw)
    { * }

  submethod TWEAK(Str :$family) {
    $!attribute = uiNewFamilyAttribute($family);
  }

  method Str {
    uiAttributeFamily($!attribute);
  }
}

class Size does Attribute {
  sub uiNewSizeAttribute(num64 $size)
    returns uiAttribute
    is native(LIB)
    is export(:raw)
    { * }

  sub uiAttributeSize(uiAttribute $a)
    returns num64
    is native(LIB)
    is export(:raw)
    { * }

  submethod TWEAK(Int :$size) {
    $!attribute = uiNewSizeAttribute($size);
  }

  method Int {
    uiAttributeSize($!attribute);
  }

  method size(--> Int) {
    self.Int;
  }
}

class Weight does Attribute {
  sub uiNewWeightAttribute(uint32 $weight)
    returns uiAttribute
    is native(LIB)
    is export(:raw)
    { * }

  sub uiAttributeWeight(uiAttribute $a)
    returns uint32
    is native(LIB)
    is export(:raw)
    { * }

  submethod TWEAK(UInt :$weight) {
    $!attribute = uiNewWeightAttribute($weight);
  }

  method Int {
    uiAttributeWeight($!attribute);
  }

  method weight(--> Int) {
    self.Int;
  }
}

class Italic does Attribute {
  sub uiNewItalicAttribute(uint32 $italic)
    returns uiAttribute
    is native(LIB)
    is export(:raw)
    { * }

  sub uiAttributeItalic(uiAttribute $a)
    returns uint32
    is native(LIB)
    is export(:raw)
    { * }

  submethod TWEAK(UInt :$italic) {
    $!attribute = uiNewItalicAttribute($italic);
  }

  method Int {
    uiAttributeItalic($!attribute);
  }

  method italic(--> Int) {
    self.Int;
  }
}

class Stretch does Attribute {
  sub uiNewStretchAttribute(uint32 $stretch)
    returns uiAttribute
    is native(LIB)
    is export(:raw)
    { * }

  sub uiAttributeStretch(uiAttribute $a)
    returns uint32
    is native(LIB)
    is export(:raw)
    { * }

  submethod TWEAK(UInt :$stretch) {
    $!attribute = uiNewStretchAttribute($stretch);
  }

  method Int {
    uiAttributeStretch($!attribute);
  }

  method stretch(--> Int) {
    self.Int;
  }
}

class Color does Attribute {
sub uiNewColorAttribute(num64 $r, num64 $g, num64 $b, num64 $a)
  returns uiAttribute
  is native(LIB)
  is export(:raw)
  { * }

sub uiAttributeColor(uiAttribute $a, num64 $r is rw, num64 $g is rw, num64 $b is rw, num64 $alpha is rw)
  is native(LIB)
  is export(:raw)
  { * }

  multi submethod TWEAK() {
    #$!attribute = uiNewColorAttribute($r, $g, $b, $a);
  }

  method Color(--> Color) {
    my num64 ($r, $g, $b, $a);
    uiAttributeColor($!attribute, $r, $g, $b, $a);
    return Color.new(:$r, :$g, :$b, :$a);
  }

  method color(--> Color) {
    self.Color;
  }
}

class Background does Attribute {
  sub uiNewBackgroundAttribute(num64 $r, num64 $g, num64 $b, num64 $a)
    returns uiAttribute
    is native(LIB)
    is export(:raw)
    { * }

  sub uiAttributeBackground(uiAttribute $a, num64 $r is rw, num64 $g is rw, num64 $b is rw, num64 $alpha is rw)
    is native(LIB)
    is export(:raw)
    { * }

  multi submethod TWEAK() {
    #$!attribute = uiNewBackgroundAttribute(num64 $r, num64 $g, num64 $b, num64 $a)
  }

  method Background(--> Color) {
    my num64 ($r, $g, $b);
    uiAttributeBackground($!attribute, $r, $g, $b);
    return Color.new(:$r, :$g, :$b);
  }

  method background(--> Color) {
    self.Background;
  }
}

class Underline does Attribute {
  sub uiNewUnderlineAttribute(int32 $u)
    returns uiAttribute
    is native(LIB)
    is export(:raw)
    { * }

  sub uiAttributeUnderline(uiAttribute $a)
    returns uint32
    is native(LIB)
    is export(:raw)
    { * }

  submethod TWEAK(UInt :$underline) {
    $!attribute = uiNewUnderlineAttribute($underline);
  }

  method Int {
    uiAttributeUnderline($!attribute);
  }

  method underline(--> Int) {
    self.Int;
  }
}

class UnderlineColor does Attribute {
  sub uiNewUnderlineColorAttribute(int32 $u, num64 $r, num64 $g, num64 $b, num64 $a)
    returns uiAttribute
    is native(LIB)
    is export(:raw)
    { * }

  sub uiAttributeUnderlineColor(uiAttribute $a
                               ,uint32 $u is rw
                               ,num64 $r is rw
                               ,num64 $g is rw
                               ,num64 $b is rw
                               ,num64 $alpha is rw
                               ) is native(LIB) is export(:raw) { * }

  multi submethod TWEAK() {
    #$!attribute = uiNewUnderlineColorAttribute($u, $r, $g, $b, $a);
  }

  method Color {
    my num64 ($r, $g, $b, $a);
    my uint32 $u;
    uiAttributeUnderlineColor($!attribute, $u, $r, $g, $b, $a);
  }

  method underlinecolor() {
    self.Color;
  }
}

class Features does Attribute {
  sub uiNewFeaturesAttribute(uiOpenTypeFeatures $otf)
    returns uiAttribute
    is native(LIB)
    is export(:raw)
    { * }

  sub uiAttributeFeatures(uiAttribute $a)
    returns uiOpenTypeFeatures
    is native(LIB)
    is export(:raw)
    { * }

  submethod TWEAK(uiOpenTypeFeatures $otf) {
    $!attribute = uiNewFeaturesAttribute($otf);
  }

  method features(--> uiOpenTypeFeatures) {
    uiAttributeFeatures($!attribute);
  }
}
