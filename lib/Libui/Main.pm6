use Libui::Raw :lib;

use NativeCall;

class uiInitOptions is repr('CStruct') is export(:init) {
  has size_t                        $.Size; # Typedef<size_t>->«long unsigned int» Size
}

sub uiInit(uiInitOptions $options)
returns Str
is native(LIB)
is export(:init)
{ * }


sub uiUninit()
is native(LIB)
is export(:init)
{ * }


sub uiFreeInitError(Str $err)
is native(LIB)
is export(:init)
{ * }



sub uiMain()
is native(LIB)
is export(:DEFAULT)
{ * }

sub uiMainSteps()
is native(LIB)
is export(:DEFAULT)
{ * }

sub uiMainStep(int32 $wait)
returns int32
is native(LIB)
is export(:DEFAULT)
{ * }


sub uiQuit()
is native(LIB)
is export(:DEFAULT)
{ * }


sub uiQueueMain(&f (Pointer), Pointer  $data)
is native(LIB)
is export(:DEFAULT)
{ * }

#cannot be called from any thread
#timer accuracy is based on OS
#initial tick register time unknown
#may be better to use Perl6 timing mechanisms
sub uiTimer(int32 $milliseconds, &f ( --> int32), Pointer)
is native(LIB)
is export(:timer)
{*}


sub uiOnShouldQuit(&f (Pointer --> int32), Pointer $data)
is native(LIB)
is export(:quit)
{ * }


sub uiFreeText(Str $text)
is native(LIB)
is export()
{ * }



