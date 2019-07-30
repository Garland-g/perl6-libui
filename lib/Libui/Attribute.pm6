use Libui::Raw :lib;
use Libui::OpenTypeFeatures :ALL;
use Libui::Text;

use Color;
use NativeCall;

constant Type = do {
  my enum Type (
    Family => 0,
    Size => 1,
    Weight => 2,
    Italic => 3,
    Stretch => 4,
    Color => 5,
    Background => 6,
    Underline => 7,
    UnderlineColor => 8,
    Features => 9,
  );
  Type;
}

class uiUColor is repr('CStruct') is export(:raw){
  has num64 $.r;
  has num64 $.g;
  has num64 $.b;
  has num64 $.a;
  has int32 $.underlineColor;
}

class uiAttrValue is repr('CUnion') is export(:raw) {
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
  HAS uiAttrValue $.value;
  has int32 $.underline;
  has Pointer[uiOpenTypeFeatures] $.features;
}

role TextAttribute is export(:attribute) {
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


  has uiAttribute $.attribute is rw;
  has Bool $.given = False;

  method free {
    if $!given {
      return fail "Cannot free a uiAttribute that is in use";
    } else {
      uiFreeAttribute($!attribute);
    }
  }

  method Int {
    uiAttributeGetType($!attribute);
  }

  method type(--> Type) {
    (self.Int);
  }

  method value() { ... }

  method perl(--> Str) {
    "{self.defined ?? "{self.^name}.new(value => {self.value})" !! self.^name}";
  }
}

class Family does TextAttribute is export {
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

  submethod TWEAK(Str :$value) {
    $!attribute = uiNewFamilyAttribute($value);
  }

  method Str {
    uiAttributeFamily($!attribute);
  }

  method value(--> Str) {
    self.Str;
  }

  method perl(--> Str) {
    "{self.defined ?? "{self.^name}.new(value => \"{self.value}\")" !! self.^name}";
  }
}

class Size does TextAttribute is export {
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

  submethod TWEAK(Real :$value) {
    my num64 $size = $value.Num;
    $!attribute = uiNewSizeAttribute($size);
  }

  method Num {
    uiAttributeSize($!attribute);
  }

  method size(--> Num) {
    self.Num;
  }

  method value(--> Num) {
    self.size;
  }
}

class Weight does TextAttribute is export {
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

  submethod TWEAK(UInt :$value) {
    $!attribute = uiNewWeightAttribute($value);
  }

  method Int {
    uiAttributeWeight($!attribute);
  }

  method weight(--> Int) {
    self.Int;
  }

  method value(--> Int) {
    self.Int;
  }
}

class Italic does TextAttribute is export {
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

  submethod TWEAK(Libui::Text::Italic(Int) :$value) {
    $!attribute = uiNewItalicAttribute($value.Int);
  }

  method Int {
    uiAttributeItalic($!attribute);
  }

  method italic(--> Libui::Text::Italic) {
    Libui::Text::Italic(self.Int);
  }

  method value(--> Libui::Text::Italic) {
    self.italic;
  }

  method perl(--> Str) {
    "{self.defined ?? "{self.^name}.new(value => Libui::Text::Italic::{self.value})" !! self.^name}";
  }
}

class Stretch does TextAttribute is export {
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

  submethod TWEAK(Libui::Text::Stretch(Int) :$value) {
    $!attribute = uiNewStretchAttribute($value.Int);
  }

  method Int {
    uiAttributeStretch($!attribute);
  }

  method stretch(--> Libui::Text::Stretch) {
    Libui::Text::Stretch(self.Int);
  }

  method value(--> Libui::Text::Stretch) {
    self.stretch;
  }

  method perl(--> Str) {
    "{self.defined ?? "{self.^name}.new(value => Libui::Text::Stretch::{self.value})" !! self.^name}";
  }
}

class TextColor does TextAttribute is export {
sub uiNewColorAttribute(num64 $r, num64 $g, num64 $b, num64 $a)
  returns uiAttribute
  is native(LIB)
  is export(:raw)
  { * }

sub uiAttributeColor(uiAttribute $a, num64 $r is rw, num64 $g is rw, num64 $b is rw, num64 $alpha is rw)
  is native(LIB)
  is export(:raw)
  { * }

  multi submethod TWEAK(*@args, *%hash) {
    my num64 ($r, $g, $b, $a) = Color.new(|@args, |%hash).rgbad».Num;
    $!attribute = uiNewColorAttribute($r, $g, $b, $a);
  }

  multi submethod TWEAK(Color :$value) {
    my num64 ($r, $g, $b, $a) = $value.rgbad».Num;
    $!attribute = uiNewColorAttribute($r, $g, $b, $a);
  }

  multi submethod TWEAK(Str :$value) {
    my num64 ($r, $g, $b, $a) = Color.new($value).rgbad».Num;
    $!attribute = uiNewColorAttribute($r, $g, $b, $a);
  }

  method Color(--> Color) {
    my num64 ($r, $g, $b, $a);
    uiAttributeColor($!attribute, $r, $g, $b, $a);
    return Color.new(:rgbad($r, $g, $b, $a));
  }

  method color(--> Color) {
    self.Color;
  }

  method value(--> Color) {
    self.Color;
  }

  method Red() {
    return self.new(color => Color.new(rgbad => [1.0, 0, 0, 1.0]));
  }

  method Blue() {
    return self.new(color => Color.new(rgbad => [0, 0, 1.0, 1.0]));
  }

  method Green() {
    return self.new(color => Color.new(rgbad => [0, 1.0, 0, 1.0]));
  }

  method Cyan() {
    return self.new(color => Color.new(rgbad => [0, 1.0, 1.0, 1.0]));
  }

  method Purple() {
    return self.new(color => Color.new(rgbad => [1.0, 0, 1.0, 1.0]));
  }

  method Yellow() {
    return self.new(color => Color.new(rgbad => [1.0, 1.0, 0, 1.0]));
  }

  method perl(--> Str) {
    "{self.defined ?? "{self.^name}.new(value => \"{self.value}\")" !! self.^name}";
  }

}

class BackgroundColor does TextAttribute is export {
  sub uiNewBackgroundAttribute(num64 $r, num64 $g, num64 $b, num64 $a)
    returns uiAttribute
    is native(LIB)
    is export(:raw)
    { * }

#TODO uncomment when uiAttributeBackground is implemented upstream
#  sub uiAttributeBackground(uiAttribute $a, num64 $r is rw, num64 $g is rw, num64 $b is rw, num64 $alpha is rw)
#    is native(LIB)
#    is export(:raw)
#    { * }

  multi submethod TWEAK(*@args, *%attrs) {
    $!attribute = uiNewBackgroundAttribute(|Color.new(|@args, |%attrs).rgbad);
  }

  multi submethod TWEAK(Color :$value) {
    my num64 ($r, $g, $b, $a) = $value.rgbad».Num;
    $!attribute = uiNewBackgroundAttribute($r, $g, $b, $a);
  }

  multi submethod TWEAK(Str :$value) {
    my num64 ($r, $g, $b, $a) = Color.new($value).rgbad».Num;
    $!attribute = uiNewBackgroundAttribute($r, $g, $b, $a);
  }

  #method Background(--> Color) {
    #my num64 ($r, $g, $b, $a);
    #uiAttributeBackground($!attribute, $r, $g, $b, $a);
    #return Color.new(:rgbad($r, $g, $b, $a));
  #}

  #method background(--> Color) {
    #self.Background;
  #}

  method value(--> Color) {
    #TODO remove line when uiAttributeBackground is implemented upstream
    Color.new(rgbad => [1.0, 0, 0, 1.0])
    #self.Background;
  }

  method Red() {
    return self.new(color => Color.new(rgbad => [1.0, 0, 0, 1.0]));
  }

  method Blue() {
    return self.new(color => Color.new(rgbad => [0, 0, 1.0, 1.0]));
  }

  method Green() {
    return self.new(color => Color.new(rgbad => [0, 1.0, 0, 1.0]));
  }

  method Cyan() {
    return self.new(color => Color.new(rgbad => [0, 1.0, 1.0, 1.0]));
  }

  method Purple() {
    return self.new(color => Color.new(rgbad => [1.0, 0, 1.0, 1.0]));
  }

  method Yellow() {
    return self.new(color => Color.new(rgbad => [1.0, 1.0, 0, 1.0]));
  }

  method perl(--> Str) {
    "{self.defined ?? "{self.^name}.new(value => \"{self.value}\")" !! self.^name}";
  }

}

class Underline does TextAttribute is export {
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

  submethod TWEAK(Libui::Text::Underline(Int) :$underline) {
    $!attribute = uiNewUnderlineAttribute($underline.Int);
  }

  method Int {
    uiAttributeUnderline($!attribute);
  }

  method underline(--> Libui::Text::Underline) {
    Libui::Text::Underline(self.Int);
  }

  method value(--> Libui::Text::Underline) {
    self.underline;
  }

  method perl(--> Str) {
    "{self.defined ?? "{self.^name}.new(value => Libui::Text::Underline::{self.value})" !! self.^name}";
  }
}

class UnderlineColor does TextAttribute is export {
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

  multi submethod TWEAK(*@args, *%attrs) {
    say "fallback";
    my num64 ($r, $g, $b, $a) = Color.new(|@args, |%attrs).rgbad;
    $!attribute = uiNewUnderlineColorAttribute(
      Libui::Text::UnderlineColor::Custom.Int,
      $r, $g, $b, $a
    );
  }

  multi submethod TWEAK(Color :$value!) {
    my num64 ($r, $g, $b, $a) = $value.rgbad».Num;
    $!attribute = uiNewUnderlineColorAttribute(
      Libui::Text::UnderlineColor::Custom.Int,
      $r, $g, $b, $a
    );
  }

  multi submethod TWEAK(Str :$value!) {
    my num64 ($r, $g, $b, $a) = Color.new($value).rgbad».Num;
    $!attribute = uiNewUnderlineColorAttribute(
      Libui::Text::UnderlineColor::Custom.Int,
      $r, $g, $b, $a
    );
  }

  multi submethod TWEAK(Int :$type!) {
    my num64 $t = 0.Num;
    $!attribute = uiNewUnderlineColorAttribute(
      Libui::Text::UnderlineColor($type).Int,
      $t, $t, $t, $t
    );
  }

  method Color {
    my num64 ($r, $g, $b, $a);
    my uint32 $u;
    uiAttributeUnderlineColor($!attribute, $u, $r, $g, $b, $a);
    return Color.new(:rgbad($r, $g, $b, $a));
  }

  method underlinecolor(--> Color) {
    self.Color;
  }

  method type(--> Libui::Text::UnderlineColor) {
    return my num64 ($r, $g, $b, $a);
    my uint32 $u;
    uiAttributeUnderlineColor($!attribute, $u, $r, $g, $b, $a);
    Libui::Text::UnderlineColor($u);
  }

  method value() {
    my num64 ($r, $g, $b, $a) = (0e0,0e0,0e0,0e0);
    my uint32 $u = 0;
    uiAttributeUnderlineColor($!attribute, $u, $r, $g, $b, $a);
    return Libui::Text::UnderlineColor($u) if $u != Libui::Text::UnderlineColor::Custom;
    return Color.new(:rgbad($r, $g, $b, $a));
  }

  method Red() {
    return self.new(color => Color.new(rgbad => [1.0, 0, 0, 1.0]));
  }

  method Blue() {
    return self.new(color => Color.new(rgbad => [0, 0, 1.0, 1.0]));
  }

  method Green() {
    return self.new(color => Color.new(rgbad => [0, 1.0, 0, 1.0]));
  }

  method Cyan() {
    return self.new(color => Color.new(rgbad => [0, 1.0, 1.0, 1.0]));
  }

  method Purple() {
    return self.new(color => Color.new(rgbad => [1.0, 0, 1.0, 1.0]));
  }

  method Yellow() {
    return self.new(color => Color.new(rgbad => [1.0, 1.0, 0, 1.0]));
  }

  method perl(--> Str) {
    "{self.defined ?? "{self.^name}.new(value => \"{self.value}\")" !! self.^name}";
  }
}

class Features does TextAttribute is export {
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

  method value(--> uiOpenTypeFeatures) {
    self.features;
  }
}
