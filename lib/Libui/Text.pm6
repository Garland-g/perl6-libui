
module Libui::Text is export {
constant Weight = do {
my enum Libui::Text::Weight (
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
); Libui::Text::Weight }

constant Italic = do {
my enum Libui::Text::Italic (
  Normal => 0,
  Oblique => 1,
  Italic => 2,
); Libui::Text::Italic }

constant Stretch = do {
my enum Libui::Text::Stretch (
  UltraCondensed => 0,
  ExtraCondensed => 1,
  Condensed => 2,
  SemiCondensed => 3,
  Normal => 4,
  SemiExpanded => 5,
  Expanded => 6,
  ExtraExpanded => 7,
  UltraExpanded => 8,
); Libui::Text::Stretch }

constant Underline = do {
my enum Libui::Text::Underline (
  None => 0,
  Single => 1,
  Double => 2,
  Suggestion => 3,
); Libui::Text::Underline }

constant UnderlineColor = do {
my enum Libui::Text::UnderlineColor (
  Custom => 0,
  Spelling => 1,
  Grammar => 2,
  Auxiliary => 3,
); Libui::Text::UnderlineColor }
}
