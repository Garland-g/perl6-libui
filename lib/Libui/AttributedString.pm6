use Libui::Raw :lib;
use Libui::Attribute :raw;
use Libui::OpenTypeFeatures :foreach, :raw;
use Libui::Style;

use NativeCall;

proto sub chars-to-bytes(|) is export(:chars-to-bytes) { * }

#| Full conversion from perl6 substr semantics to C-String UTF8 byte array
multi sub chars-to-bytes(Str $str, UInt $start-char, UInt $chars, :$encoding = 'utf-8') {
  my $end-char = chars-to-end($start-char, $chars)[1];
  my $start-byte = $str.substr(0, $start-char).encode.bytes;
  my $end-byte = $str.substr(0, $end-char).encode.bytes;
  return ($start-byte, $end-byte);
}

#| Full conversion from perl6 Range to C-String UTF8 byte array
multi sub chars-to-bytes(Str $str, Range $r, :$encoding = 'utf-8') {
  my ($start-char, $end-char) = chars-to-end($r);
  my $start-byte = $str.substr(0, $start-char).encode.bytes;
  my $end-byte = $str.substr(0, $end-char).encode.bytes;
  return ($start-byte, $end-byte);
}

proto sub chars-to-end(|) is export(:chars-to-end) { * }

#| Converts from perl6 substr semantics to [start, end) C-string semantics
multi sub chars-to-end(UInt $start, UInt $chars) {
  return ($start, $start + $chars);
}

#| Converts from Perl6 Range to [start, end) C-string semantics
multi sub chars-to-end(Range $r where *.is-int()) {
  return $r.int-bounds Z+ (0, 1);
}


class uiAttributedString is repr('CStruct') is export(:DEFAULT) {

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
}

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


class Libui::TaggedStr is Str {
  has Libui::Style $.style is rw;

  submethod BUILD(Str :$value, Libui::Style :$style) {
    $!style = $style;
  }

  multi method new(Str $value, Libui::Style $style) {
    self.bless(:$value, :$style);
  }

  multi method new(Str :$value, Libui::Style :$style) {
    self.bless(:$value, :$style);
  }

  method perl() {
    "Libui::TaggedStr.new(value => {callsame()}, style => {$!style.perl})"
  }

  method ACCEPTS(Libui::TaggedStr $str) {
    return self.perl ~~ $str.perl;
  }
}

class Libui::AttributedString is export {
  has Libui::TaggedStr @.str;

  multi submethod BUILD() {
  }

  multi submethod BUILD(Libui::TaggedStr :$init!) {
  }

  multi submethod BUILD(Str :$init!, Libui::Style :$style!) {
  }

  multi submethod BUILD(Str :$init!) {
  }

  multi submethod BUILD(Libui::AttributedString :$str!) {
    @!str = $str.str;
  }

  multi submethod TWEAK() {
  }

  multi submethod TWEAK(Libui::TaggedStr :$init!) {
    @!str.append($init);
  }

  multi submethod TWEAK(Str :$init!, Libui::Style :$style ) {
    @!str.append(Libui::TaggedStr.new(value => $init, :$style));
  }

  multi submethod TWEAK(Str :$init!) {
    @!str.append(Libui::TaggedStr.new(value => $init, style => Libui::Style.new));
  }

  multi submethod TWEAK(Libui::AttributedString :$str) {
  }

  multi method new() {
    self.bless();
  }

  multi method new(Str $init, Libui::Style $style) {
    self.bless(:$init, :$style);
  }

  multi method new(Libui::TaggedStr $init) {
    self.bless(:$init);
  }

  multi method new(Str $init) {
    self.bless(:$init);
  }

  multi method new(Libui::AttributedString $str) {
    self.bless(:$str);
  }

  #|Render a Libui::AttributedString
  method uiAttributedString() {
    my $attrstr = uiNewAttributedString("");
    my @attr;
    my $total-len = 0;
    for @!str -> $str {
      uiAttributedStringAppendUnattributed($attrstr, $str.Str);
      my $len = $str.encode.bytes;
      if $str.style.defined {
        if $str.style.size.defined {
          @attr.append: $str.style.size
        }
        if $str.style.family.defined {
          @attr.append: $str.style.family
        }
        if $str.style.weight.defined {
          @attr.append: $str.style.weight
        }
        if $str.style.underline.defined {
          @attr.append: $str.style.underline
        }
        if $str.style.stretch.defined {
          @attr.append: $str.style.stretch
        }
        if $str.style.italic.defined {
          @attr.append: $str.style.italic
        }
        if $str.style.color.defined {
          @attr.append: $str.style.color
        }
        if $str.style.background-color.defined {
          @attr.append: $str.style.background-color
        }
        if $str.style.underline-color.defined {
          @attr.append: $str.style.underline-color
        }
        if $str.style.features.defined {
          @attr.append: $str.style.features
        }
        for @attr -> $attr {
          set-attribute-chars($attrstr, $attr, $total-len..($total-len + $len));
        }
      }
      $total-len += $len;
      @attr = [];
    }
    return $attrstr;
  }

  method Str() {
    return @!str.join;
  }

  method chars() {
    return @!str.join.chars;
  }

  method codes() {
    return @!str.join.codes;
  }

  method ACCEPTS(Libui::AttributedString $attrstr) {
    return @!str ~~ $attrstr.str;
  }

  #| N.B AttributedStrings are always UTF-8
  method encode() {
    return @!str.join.encode;
  }

  method append-attributed(Str $str, Libui::Style $style) {
    @!str.append(Libui::TaggedStr.new($str, $style));
  }

  multi method append(Str $str) {
    @!str.append(Libui::TaggedStr.new($str, Libui::Style));
  }

  multi method append(Libui::AttributedString $other) {
    my @newstr.append(@!str).append($other.str);
  self.append($other.Str);
    return Libui::NewString;
  }

  sub set-attribute-bytes(uiAttributedString $attrstr, uiAttribute $attr, UInt $start, UInt $end) {
    uiAttributedStringSetAttribute($attrstr, $attr, $start, $end);
  }


  #| Use Perl 6 Str semantics
  multi sub set-attribute-chars(uiAttributedString $attrstr, uiAttribute $attr, UInt $start, UInt $chars) {
    my ($s, $e) = chars-to-bytes($attrstr.Str, $start, $chars);
    set-attribute-bytes($attrstr, $attr, $s, $e);
  }
  multi sub set-attribute-chars(uiAttributedString $attrstr, uiAttribute $attr, Range $r ) {
    my ($s, $e) = chars-to-bytes($attrstr.Str,  $r);
    set-attribute-bytes($attrstr, $attr, $s, $e);
  }
}
multi sub infix:<~> (Libui::AttributedString $attrstr, Libui::AttributedString $to-add ) is export {
}

multi sub infix:<~> (Libui::AttributedString $attrstr, Str $str --> Libui::AttributedString) is export {
}
