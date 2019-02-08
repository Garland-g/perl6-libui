use v6;
use Test;
use Libui;

plan 8;

if $*KERNEL ~~ "linux" {
  unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
    skip-rest;
    exit 0;
  }
}

Libui::Init();

my Libui::Form $form .= new;

my Libui::Entry $entry .= new;
my Libui::Entry $entry2 .= new;
isa-ok $form, Libui::Form, <Create form>;

lives-ok {$form.append('entry', $entry, 0)}, <Append to form>;

$form.append('entry', $entry2, 0);

lives-ok {$form.delete-item(1)},

is $form.padded, False, <Get state: padded>;

subtest <Set state: padded>, {
  plan 1;
  $form.set-padded(1);
  is $form.padded, True;
};

throws-like {$form.delete-item(300)}, Exception, <Die when deleting out of range>;

throws-like {$form.delete(-2)}, Exception, <Die when deleting negative number>;

dies-ok {$form.append(Str, Libui::VBox.new, True)}, <Append with null label>;

done-testing;
# vi:syntax=perl6
