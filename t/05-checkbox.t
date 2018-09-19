use v6;
use Test;
use Libui;

plan *;
Libui::Init();
my $checkbox = Libui::Checkbox.new('text');

isa-ok $checkbox, Libui::Checkbox, <Create a checkbox> or bail-out "Cannot proceed without a checkbox";

isa-ok $checkbox.toggled, Supply, <Get checkbox's supply>;

is $checkbox.text(), 'text', <Get checkbox's text>;

subtest {
  plan 1;
  $checkbox.set-text('test');

  is $checkbox.text(), 'test';
}, <Set checkbox's text>;

is $checkbox.checked, False, <Get checkbox's state>;

subtest {
  plan 1;
  $checkbox.set-checked(1);

  is $checkbox.checked, True;
}, <Set checkbox's state>;

lives-ok {Libui::Checkbox.new(Str)}, <Checkbox with Null Str>;

done-testing;
# vi:syntax=perl6
