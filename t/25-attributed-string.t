use v6;
use Libui;
use Test;

Libui::Init();

plan *;

my Libui::AttributedString $attrstr .= new("  ∮ E⋅da = Q,  n → ∞, ∑ f(i) = ∏ g(i), ∀x∈ℝ: ⌈x⌉ = −⌊−x⌋, α ∧ ¬β = ¬(¬α ∨ β),");

my Libui::AttributedString $attrstr3 .= new("Hello World");
#Basic Strng attributes
is $attrstr3.Str, "Hello World", <Get String>;

is $attrstr.chars, 77, <Get number of characters>;

is $attrstr.codes, 77, <Get number of codes>;

is $attrstr.encode.bytes, 118, <Get number of bytes>;


my Libui::AttributedString $attrstr2 .= new("Ḍ̇👪");

#Combining String Attributes
is $attrstr2.chars, 2, <Get number of characters (combining)>;

is $attrstr2.codes, 3, <Get number of codepoints (combining)>;

is $attrstr2.encode.bytes, 9, <Get number of bytes (combining)>;


#Perl6 to C-String Semantics
is $attrstr.chars-to-end(2..5), (2,6), <Range to Start, End conversion>;

is $attrstr.chars-to-end(2, 4), (2,6), <Start, Chars to Start, End conversion>;


#Perl6 Chars to UTF-8 Bytes
is $attrstr2.chars-to-bytes(0,1), (0,5), <Start, Chars to Start-Byte, End-Byte conversion>;
is $attrstr2.chars-to-bytes(0..^1), (0,5), <Char Range to Start-Byte, End-Byte conversion>;

#String Manipulation
$attrstr2.delete(0..^1);

is $attrstr2.Str, "👪", <Delete using Range>;

#Adding attributes (Can it be tested better?)
lives-ok {$attrstr3.weight(Libui::TextWeight::Minimum, 0, 5) }, <Set weight attribute>;
lives-ok {$attrstr3.underline(Libui::TextUnderline::Single, 0, 5) }, <Set underline attribute>;
lives-ok {$attrstr3.size(32, 0, 5) }, <Set size attribute (Int)>;
lives-ok {$attrstr3.size(32.6, 6, 9) }, <Set size attribute (Rat)>;

#enum access
is Libui::TextUnderline::Double.Int, 2, <Access Underline enum>;
is Libui::TextUnderlineColor::Spelling.Int, 1, <Access UnderlineColor enum>;
is Libui::TextStretch::Normal.Int, 4, <Access Stretch enum>;
is Libui::TextWeight::Minimum.Int, 0, <Access Weight enum>;
is Libui::TextItalic::Italic.Int, 2, <Access Italic enum>;

done-testing;
