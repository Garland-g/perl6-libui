use v6;
use Test;
use Libui;

plan *;

Libui::Init();
	my $window = Libui::Window.new('test');

subtest 'before $window.show', {

	isa-ok $window, Libui::Window, <Create a Window> or bail-out "Cannot proceed without a window";

	isa-ok $window.closing, Supply, <Get the closing supply>;

	is 'test', $window.title(), <Get the window's title>;

	$window.set-title('window');
	is 'window', $window.title(), <Set the window's title>;

	my $button = Libui::Button.new('test');

	$window.set-content($button);

	is-deeply $button.parent, $window.Control, <Set the window's content> 
		or bail-out "Must be able to set window's content";

};

$window.show();

subtest 'after $window.show', {
	
	my int32 $h;
	my int32 $w;

	isa-ok $window.size-changed, Supply, <Get the size-changed supply>;

	$window.content-size($w, $h);

	subtest {
		todo 'Fails on macos for some reason';
		is $h, 480, 'Get window height';
		is $w, 640, 'Get window width';
	}, <Get the window's size'>;

	is $window.width(), $w, <Get only window's width'>;

	is $window.height(), $h, <Get only window's height'>;



	todo 'Requires uiMain(), which is blocking';
	subtest {
		$window.set-content-size(300, 200);

		$w = 300;
		$h = 200;

		plan 2;
		is $window.height(), $h;
		is $window.width(), $w;
	}, <Set window's content size>;


	is $window.fullscreen, 0, <Get window's state: fullscreen>;

	subtest <set-fullscreen>, {
		plan 1;
		$window.set-fullscreen(1);
		is $window.fullscreen, 1;
	}

	is $window.borderless, 0, <Get window's state: borderless>;

	subtest <set-borderless>, {
		plan 1;
		$window.set-borderless(1);
		is $window.borderless, 1;
	}

	is $window.margined, 0, <Get window's state: margined>;

	subtest <set-margined>, {
		plan 1;
		$window.set-margined(1);
		is $window.margined, 1;
	}
}

done-testing;
# vi:syntax=perl6
