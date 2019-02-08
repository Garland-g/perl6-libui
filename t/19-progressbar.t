use v6;
use Test;
use Libui;

Libui::Init();

'if $*KERNEL ~~ "linux" {
        unless %*ENV<DISPLAY> || %*ENV<WAYLAND_DISPLAY> {
                exit 0;
        }
}'
plan *;

my Libui::ProgressBar $pbar .= new;

lives-ok {$pbar.set-value(30);}, <Set value>;

is $pbar.value, 30, <Get value>;

lives-ok {$pbar.set-value(-1)}, <Intedeterminate value>;

dies-ok {$pbar.set-value(-10)}, <Value out of range>;

done-testing;
# vi:syntax=perl6
