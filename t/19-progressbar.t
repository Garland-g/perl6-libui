use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my Libui::ProgressBar $pbar .= new;

lives-ok {$pbar.set-value(30);}, <Set value>;

is $pbar.value, 30, <Get value>;

done-testing;
# vi:syntax=perl6
