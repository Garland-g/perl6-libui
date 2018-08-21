use Libui::Raw :text;

constant TextWeight is export = do {
my enum Libui::TextWeight (
  Minimum => 0,
  Thin => 100,
  UltraLight => 200,
  Light => 300,
  Book => 350,
  Normal => 400,
  Medium => 500,
  SemiBold => 600,
  Bold => 700,
  UltraBold => 800,
  Heavy => 900,
  UltraHeavy => 950,
  Maximum => 1000,
); Libui::TextWeight }

constant TextItalic is export = do {
my enum Libui::TextItalic (
  Normal => 0,
  Oblique => 1,
  Italic => 2,
); Libui::TextItalic }

constant TextStretch is export = do {
my enum Libui::TextStretch is export (
  UltraCondensed => 0,
  ExtraCondensed => 1,
  Condensed => 2,
  SemiCondensed => 3,
  Normal => 4,
  SemiExpanded => 5,
  Expanded => 6,
  ExtraExpanded => 7,
  UltraExpanded => 8,
); Libui::TextStretch }

constant TextUnderline is export = do {
enum Libui::TextUnderline (
  None => 0,
  Single => 1,
  Double => 2,
  Suggestion => 3,
); Libui::TextUnderline }

constant TextUnderlineColor is export = do {
enum Libui::TextUnderlineColor (
  Custom => 0,
  Spelling => 1,
  Grammar => 2,
  Auxiliary => 3,
); Libui::TextUnderlineColor }

class Libui::AttributedString is export {
  has uiAttributedString $.attrstr;

  submethod BUILD(Str :$init!) {
    $!attrstr = uiNewAttributedString($init);
  }

  method ACCEPTS($s2) {
    return self eq $s2;
  }

  method new(Str $init) {
    self.bless(:$init);
  }

  method Str() {
    return uiAttributedStringString($!attrstr);
  }

  method chars() {
    return self.Str.chars;
  }

  method codes() {
    return self.Str.codes;
  }

  #| N.B AttributedStrings are always UTF-8
  method encode() {
    return self.Str.encode;
  }

  #| Convenience function
  method substr(|args) {
    return self.Str.substr(|args);
  }

  #| Full conversion from perl6 substr semantics to C-String UTF8 byte array
  multi method chars-to-bytes(UInt $start-char, UInt $chars) {
    my $end-char = self.chars-to-end($start-char, $chars)[1];
    my $start-byte = self.substr(0, $start-char).encode.bytes;
    my $end-byte = self.substr(0, $end-char).encode.bytes;
    return ($start-byte, $end-byte);
  }

  #| Full conversion from perl6 Range to C-String UTF8 byte array
  multi method chars-to-bytes(Range $r) {
    my ($start-char, $end-char) = self.chars-to-end($r);
    my $start-byte = self.substr(0, $start-char).encode.bytes;
    my $end-byte = self.substr(0, $end-char).encode.bytes;
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

  method append(Str $str) {
    uiAttributedStringAppendUnattributed($!attrstr, $str);
  }

  method set-attribute-bytes(uiAttribute $attr is rw, UInt $start, UInt $end) {
    uiAttributedStringSetAttribute($!attrstr, $attr, $start, $end);
  }

#  method set-attribute-codes(uiAttribute $attr is rw, Int $start, Int $end) {
#    my Str $str = $!attrstr.Str;
#  }

  #| Use Perl 6 Str semantics
  multi method set-attribute-chars(uiAttribute $attr is rw, UInt $start, UInt $chars) {
    my ($s, $e) = self.chars-to-bytes($start, $chars);
    self.set-attribute-bytes($attr, $s, $e);
  }
  multi method set-attribute-chars(uiAttribute $attr is rw, Range $r ) {
    my ($s, $e) = self.chars-to-bytes($r);
    self.set-attribute-bytes($attr, $s, $e);
  }

  #| Insert unattributed text, moves existing attributes to follow existing text
  method insert(Str $str, UInt $char-at) {
    my $at = $!attrstr.substr(0, $char-at).encode.bytes;
    uiAttributedStringInsertAtUnattributed($!attrstr, $str, $at);
  }

  multi method delete(UInt $start, UInt $chars) {
    my ($s, $e) = self.chars-to-bytes($start, $chars);
    uiAttributedStringDelete($!attrstr, $s, $e);
  }

  multi method delete(Range $r) {
    my ($s, $e) = self.chars-to-bytes($r);
    uiAttributedStringDelete($!attrstr, $s, $e);
  }

  #|( Run a callback on each attribute
      Cannot modify the underlying string
      Cannot free or save the attribute for later
    )
  method for-each-attribute(Callable $f) {
    uiAttributedStringForEachAttribute($!attrstr, $f, Str);
  }

  multi method family(Str $family, UInt $start, UInt $chars) {
    my $attr = uiNewFamilyAttribute($family);
    self.set-attribute-chars($attr, $start, $chars);
  }

  multi method family(Str $family, Range $r) {
    my $attr = uiNewFamilyAttribute($family);
    self.set-attribute-chars($family, $r);
  }

  multi method size(Numeric $size, UInt $start, UInt $chars) {
    my $attr = uiNewSizeAttribute($size.Num);
    self.set-attribute-chars($attr, $start, $chars);
  }

  multi method size(Numeric $size, Range $r) {
    my $attr = uiNewSizeAttribute($size.Num);
    self.set-attribute-chars($attr, $r);
  }

  multi method weight(Int(Libui::TextWeight) $weight where 0 <= * <= 1000, UInt $start, UInt $chars) {
    my $attr = uiNewWeightAttribute($weight);
    self.set-attribute-chars($attr, $start, $chars);
  }

  multi method weight(Int(Libui::TextWeight) $weight where 0 <= * <= 1000, Range $r) {
    my $attr = uiNewWeightAttribute($weight);
    self.set-attribute-chars($attr, $r);
  }

  multi method italic(Libui::TextItalic $italic, UInt $start, UInt $chars) {
    my $attr = uiNewItalicAttribute($italic);
    self.set-attribute-chars($attr, $start, $chars);
  }

  multi method italic(Libui::TextItalic $italic, Range $r) {
    my $attr = uiNewItalicAttribute($italic);
    self.set-attribute-chars($attr, $r);
  }

  multi method stretch(Libui::TextStretch $stretch, UInt $start, UInt $chars) {
    my $attr = uiNewStretchAttribute($stretch);
    self.set-attribute-chars($attr, $start, $chars);
  }

  multi method stretch(Libui::TextStretch $stretch, Range $r) {
    my $attr = uiNewStretchAttribute($stretch);
    self.set-attribute-chars($attr, $r);
  }

  multi method color(Numeric $r, Numeric $g, Numeric $b, Numeric $a, UInt $start, UInt $chars) {
    my $attr = uiNewColorAttribute($r.Num, $g.Num, $b.Num, $a.Num);
    self.set-attribute-chars($attr, $start, $chars);
  }

  multi method color(Numeric $r, Numeric $g, Numeric $b, Numeric $a, Range $range) {
    my $attr = uiNewColorAttribute($r.Num, $g.Num, $b.Num, $a.Num);
    self.set-attribute-chars($attr, $range);
  }

  multi method background(Numeric $r, Numeric $g, Numeric $b, Numeric $a, UInt $start, UInt $chars) {
    my $attr = uiNewBackgroundAttribute($r.Num, $g.Num, $b.Num, $a.Num);
    self.set-attribute-chars($attr, $start, $chars);
  }

  multi method background(Numeric $r, Numeric $g, Numeric $b, Numeric $a, Range $range) {
    my $attr = uiNewBackgroundAttribute($r.Num, $g.Num, $b.Num, $a.Num);
    self.set-attribute-chars($attr, $range);
  }

  multi method underline(Libui::TextUnderline $underline, UInt $start, UInt $chars) {
    my $attr = uiNewUnderlineAttribute($underline);
    self.set-attribute-chars($attr, $start, $chars);
  }

  multi method underline(Libui::TextUnderline $underline, Range $r) {
    my $attr = uiNewUnderlineAttribute($underline);
    self.set-attribute-chars($attr, $r);
  }

  multi method underline-color(Libui::TextUnderlineColor $underline-color
                        ,Numeric $r
                        ,Numeric $g
                        ,Numeric $b
                        ,Numeric $a
                        ,UInt $start
                        ,UInt $chars
                        ) {
    my $attr = uiNewUnderlineColorAttribute($underline-color, $r.Num, $g.Num, $b.Num, $a.Num);
    self.set-attribute-chars($attr, $start, $chars);
  }

  multi method underline-color(Libui::TextUnderlineColor $underline-color
                        ,Numeric $r
                        ,Numeric $g
                        ,Numeric $b
                        ,Numeric $a
                        ,Range $range
                        ) {
    my $attr = uiNewUnderlineColorAttribute($underline-color, $r.Num, $g.Num, $b.Num, $a.Num);
    self.set-attribute-chars($attr, $range);
  }
}
