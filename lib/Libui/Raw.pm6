use v6;

use NativeCall;

unit module Libui::Raw;

constant \LIB is export(:lib) = %?RESOURCES<libraries/ui>;

## Enumerations

enum uiModifier is export(:DEFAULT) (
   uiModifierCtrl => 1,
   uiModifierAlt => 2,
   uiModifierShift => 4,
   uiModifierSuper => 8
);
enum uiExtKey is export(:DEFAULT) (
   uiExtKeyEscape => 1,
   uiExtKeyInsert => 2,
   uiExtKeyDelete => 3,
   uiExtKeyHome => 4,
   uiExtKeyEnd => 5,
   uiExtKeyPageUp => 6,
   uiExtKeyPageDown => 7,
   uiExtKeyUp => 8,
   uiExtKeyDown => 9,
   uiExtKeyLeft => 10,
   uiExtKeyRight => 11,
   uiExtKeyF1 => 12,
   uiExtKeyF2 => 13,
   uiExtKeyF3 => 14,
   uiExtKeyF4 => 15,
   uiExtKeyF5 => 16,
   uiExtKeyF6 => 17,
   uiExtKeyF7 => 18,
   uiExtKeyF8 => 19,
   uiExtKeyF9 => 20,
   uiExtKeyF10 => 21,
   uiExtKeyF11 => 22,
   uiExtKeyF12 => 23,
   uiExtKeyN0 => 24,
   uiExtKeyN1 => 25,
   uiExtKeyN2 => 26,
   uiExtKeyN3 => 27,
   uiExtKeyN4 => 28,
   uiExtKeyN5 => 29,
   uiExtKeyN6 => 30,
   uiExtKeyN7 => 31,
   uiExtKeyN8 => 32,
   uiExtKeyN9 => 33,
   uiExtKeyNDot => 34,
   uiExtKeyNEnter => 35,
   uiExtKeyNAdd => 36,
   uiExtKeyNSubtract => 37,
   uiExtKeyNMultiply => 38,
   uiExtKeyNDivide => 39
);

enum uiAlign is export(:DEFAULT) (
  uiAlignFill => 0,
  uiAlignStart => 1,
  uiAlignCenter => 2,
  uiAlignEnd => 3
);

enum uiAt is export(:DEFAULT) (
   uiAtLeading => 0,
   uiAtTop => 1,
   uiAtTrailing => 2,
   uiAtBottom => 3
);
