use Libui::Raw :text;
use Libui::StringStyle;

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
          @attr.append: uiNewSizeAttribute($str.style.size.value.Num)
        }
        if $str.style.family.defined {
          @attr.append: uiNewFamilyAttribute($str.style.family.value)
        }
        if $str.style.weight.defined {
          @attr.append: uiNewWeightAttribute($str.style.weight.value)
        }
        if $str.style.underline.defined {
          @attr.append: uiNewUnderlineAttribute($str.style.underline.value)
        }
        if $str.style.stretch.defined {
          @attr.append: uiNewStretchAttribute($str.style.stretch.value)
        }
        if $str.style.italic.defined {
          @attr.append: uiNewItalicAttribute($str.style.italic.value)
        }
        if $str.style.color.defined {
          my $color = $str.style.color.value;
          @attr.append: uiNewColorAttribute($color.r.Num, $color.g.Num, $color.b.Num, $color.a.Num)
        }
        if $str.style.background-color.defined {
          my $color = $str.style.background-color.value;
          @attr.append: uiNewBackgroundAttribute($color.r.Num, $color.g.Num, $color.b.Num, $color.a.Num)
        }
        if $str.style.underline-color.defined {
          my $color = $str.style.underline-color.value;
          my $type = $str.style.underline-color.type;
          @attr.append: uiNewUnderlineColorAttribute($type, $color.r.Num, $color.g.Num, $color.b.Num, $color.a.Num)
        }
        if $str.style.features.defined {
          my $otf = uiNewOpenTypeFeatures();
          say $str.style.features.features.WHAT;
          for $str.style.features.features.kv -> $key, $value {
            my ($a, $b, $c, $d) = $key.comb>>.ord;
            uiOpenTypeFeaturesAdd($otf, $a, $b, $c, $d, $value);
          }
          @attr.append: uiNewFeaturesAttribute($otf);
        }
        for @attr -> $attr {
          self.set-attribute-chars($attrstr, $attr, $total-len..($total-len + $len));
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

  #| Full conversion from perl6 substr semantics to C-String UTF8 byte array
  multi method chars-to-bytes(Str $str, UInt $start-char, UInt $chars) {
    my $end-char = self.chars-to-end($start-char, $chars)[1];
    my $start-byte = $str.substr(0, $start-char).encode.bytes;
    my $end-byte = $str.substr(0, $end-char).encode.bytes;
    return ($start-byte, $end-byte);
  }

  #| Full conversion from perl6 Range to C-String UTF8 byte array
  multi method chars-to-bytes(Str $str, Range $r) {
    my ($start-char, $end-char) = self.chars-to-end($r);
    my $start-byte = $str.substr(0, $start-char).encode.bytes;
    my $end-byte = $str.substr(0, $end-char).encode.bytes;
    return ($start-byte, $end-byte);
  }

  #| Converts from perl6 substr semantics to [start, end) C-string semantics
  multi method chars-to-end(UInt $start, UInt $chars) {
    return ($start, $start + $chars);
  }

  #| Converts from Perl6 Range to [start, end) C-string semantics
  multi method chars-to-end(Range $r where *.is-int()) {
    return $r.int-bounds Z+ (0, 1);
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

  method set-attribute-bytes(uiAttributedString $attrstr, uiAttribute $attr, UInt $start, UInt $end) {
    uiAttributedStringSetAttribute($attrstr, $attr, $start, $end);
  }


  #| Use Perl 6 Str semantics
  multi method set-attribute-chars(uiAttributedString $attrstr, uiAttribute $attr, UInt $start, UInt $chars) {
    my ($s, $e) = self.chars-to-bytes($attrstr.Str, $start, $chars);
    self.set-attribute-bytes($attrstr, $attr, $s, $e);
  }
  multi method set-attribute-chars(uiAttributedString $attrstr, uiAttribute $attr, Range $r ) {
    my ($s, $e) = self.chars-to-bytes($attrstr.Str,  $r);
    self.set-attribute-bytes($attrstr, $attr, $s, $e);
  }
}
multi sub infix:<~> (Libui::AttributedString $attrstr, Libui::AttributedString $to-add ) is export {
}

multi sub infix:<~> (Libui::AttributedString $attrstr, Str $str --> Libui::AttributedString) is export {
}
