use v6;
use Test;
use Libui;

Libui::Init();

plan *;


my Libui::MultilineEntry $entry;

lives-ok {
  $entry .= new;
}, <Create MultilineEntry>;

isa-ok $entry.changed, Supply, <Get changed supply>;

lives-ok {
my Libui::NonWrappingMultilineEntry $nwentry .= new;
}, <Create NonWrappingMultilineEntry>;

lives-ok {$entry.append('test'); }, <Append text>;

is $entry.text, 'test', <Get text>;

subtest <Set text>, {
  plan 1;
  $entry.set-text('text');
  is $entry.text, 'text', <Set text>;
};

is $entry.read-only, False, <Get state: read-only>;

subtest <Set state: read-only>, {
  plan 1;
  $entry.set-read-only(1);
  is $entry.read-only, True;
}

dies-ok {$entry.append(Str)}, <Append null Str>;

dies-ok {$entry.set-text(Str)}, <Set to null Str>;

done-testing;
# vi:syntax=perl6
