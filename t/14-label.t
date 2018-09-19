use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my Libui::Label $label .= new('text');

isa-ok $label, Libui::Label, <Create a label>;

is $label.text, 'text', <Get text>;

subtest <Set text>, {
  plan 1;
  $label.set-text('value');
  is $label.text, 'value';
};

lives-ok {Libui::Label.new(Str)}, <Null label>;

done-testing;
# vi:syntax=perl6
