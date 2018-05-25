use v6;
use Test;
use Libui;

Libui::Init();

plan *;

my Libui::Group $group .= new('test'); 

isa-ok $group, Libui::Group, <Create group>;

is $group.title, 'test', <Get title>;

subtest <Set title>, {
	plan 1;
	$group.set-title('title');
	is $group.title, 'title';
}

my Libui::Button $button .= new('label'); 

lives-ok { $group.set-child($button);}, <Set child>;

is $group.margined, 0, <get state: margined>;

subtest <set state: margined>, {
	plan 1;
	$group.set-margined(1);
	is $group.margined, 1;
};

done-testing;
# vi:syntax=perl6
