use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my Libui::Form $form .= new;

my Libui::Entry $entry .= new;
my Libui::Entry $entry2 .= new;
isa-ok $form, Libui::Form, <Create form>;

lives-ok {$form.append('entry', $entry, 0)}, <Append to form>;

$form.append('entry', $entry2, 0);

lives-ok {$form.delete-item(1)},

is $form.padded, 0, <Get state: padded>;

subtest <Set state: padded>, {
  plan 1;
  $form.set-padded(1);
  is $form.padded, 1;
};

done-testing;
# vi:syntax=perl6
