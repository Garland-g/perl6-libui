use v6;
use Libui;
use Test;

Libui::Init();

plan *;

my Libui::AttributedString $attrstr .= new("  ∮ E⋅da = Q,  n → ∞, ∑ f(i) = ∏ g(i), ∀x∈ℝ: ⌈x⌉ = −⌊−x⌋, α ∧ ¬β = ¬(¬α ∨ β),");

my Libui::AttributedString $attrstr3 .= new("Hello World");
#Basic Strng attributes
is $attrstr3.Str, "Hello World", <Get String>;

is $attrstr3 ~~ "Hello World", True, <Smartmatch AttributedStrings with Str>;

is $attrstr ~~ $attrstr3, False, <Smartmatch different AttributedStrings>;

is $attrstr3 ~~ Libui::AttributedString.new(Libui::TaggedStr.new("Hello World", Libui::Style.new(size => 40))), False, <Smartmatch AttributedStrings with different Styles>;

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

isa-ok $attrstr.uiAttributedString, Libui::Raw::uiAttributedString, <Render uiAttributedString>;

done-testing;
