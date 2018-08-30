use v6;

use lib 'lib';
use Libui;

use Test;

Libui::Init();

#Style composition

plan *;

my Libui::Style $style .= new(size => 22, family => "Courier New", weight => 400);

my $style2 = $style.with(size => 25, stretch => Libui::Text::Stretch::Condensed);

my $style3 = $style.with(color => (1, 0, 0, 1));

my $style4 = $style.with(underline-color => Libui::Text::UnderlineColor::Spelling);

my $style5 = $style.with(background-color => (0, 1, 0, 1));

is $style.perl,
'Libui::Style.new(color => TextColor, underline-color => UnderlineColor, size => Size.new(value => 22), italic => Italic, background-color => BackgroundColor, stretch => Stretch, family => Family.new(value => "Courier New"), weight => Weight.new(value => 400), underline => Underline, features => Features)',
<New Style>;

is $style2.perl,
'Libui::Style.new(color => TextColor, underline-color => UnderlineColor, size => Size.new(value => 25), italic => Italic, background-color => BackgroundColor, stretch => Stretch.new(value => Libui::Text::Stretch::Condensed), family => Family.new(value => "Courier New"), weight => Weight.new(value => 400), underline => Underline, features => Features)',
<Style with Size and Stretch>;

is $style3.perl,
'Libui::Style.new(color => TextColor.new(value => Color.new(r => 1, g => 0, b => 0, a => 1)), underline-color => UnderlineColor, size => Size.new(value => 22), italic => Italic, background-color => BackgroundColor, stretch => Stretch, family => Family.new(value => "Courier New"), weight => Weight.new(value => 400), underline => Underline, features => Features)',
<Style with color>;

is $style4.perl,
'Libui::Style.new(color => TextColor, underline-color => UnderlineColor.new(type => Libui::Text::UnderlineColor::Spelling, value => Color.new(r => 0, g => 0, b => 0, a => 0)), size => Size.new(value => 22), italic => Italic, background-color => BackgroundColor, stretch => Stretch, family => Family.new(value => "Courier New"), weight => Weight.new(value => 400), underline => Underline, features => Features)',
<Style with underline-color>;

is $style5.perl,
'Libui::Style.new(color => TextColor, underline-color => UnderlineColor, size => Size.new(value => 22), italic => Italic, background-color => BackgroundColor.new(value => Color.new(r => 0, g => 1, b => 0, a => 1)), stretch => Stretch, family => Family.new(value => "Courier New"), weight => Weight.new(value => 400), underline => Underline, features => Features)',
<Style with background-color>;

done-testing;
