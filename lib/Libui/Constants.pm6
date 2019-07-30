use Libui::Raw :lib;

## Enumerations

enum uiDrawBrushType is export(:draw) (
   uiDrawBrushTypeSolid => 0,
   uiDrawBrushTypeLinearGradient => 1,
   uiDrawBrushTypeRadialGradient => 2,
   uiDrawBrushTypeImage => 3
);
enum uiDrawLineCap is export(:draw) (
   uiDrawLineCapFlat => 0,
   uiDrawLineCapRound => 1,
   uiDrawLineCapSquare => 2
);
enum uiDrawLineJoin is export(:draw) (
   uiDrawLineJoinMiter => 0,
   uiDrawLineJoinRound => 1,
   uiDrawLineJoinBevel => 2
);
enum uiDrawFillMode is export(:draw) (
   uiDrawFillModeWinding => 0,
   uiDrawFillModeAlternate => 1
);
enum uiDrawTextWeight is export(:draw) (
   uiDrawTextWeightThin => 0,
   uiDrawTextWeightUltraLight => 1,
   uiDrawTextWeightLight => 2,
   uiDrawTextWeightBook => 3,
   uiDrawTextWeightNormal => 4,
   uiDrawTextWeightMedium => 5,
   uiDrawTextWeightSemiBold => 6,
   uiDrawTextWeightBold => 7,
   uiDrawTextWeightUtraBold => 8,
   uiDrawTextWeightHeavy => 9,
   uiDrawTextWeightUltraHeavy => 10
);
enum uiDrawTextItalic is export(:draw) (
   uiDrawTextItalicNormal => 0,
   uiDrawTextItalicOblique => 1,
   uiDrawTextItalicItalic => 2
);
enum uiDrawTextStretch is export(:draw) (
   uiDrawTextStretchUltraCondensed => 0,
   uiDrawTextStretchExtraCondensed => 1,
   uiDrawTextStretchCondensed => 2,
   uiDrawTextStretchSemiCondensed => 3,
   uiDrawTextStretchNormal => 4,
   uiDrawTextStretchSemiExpanded => 5,
   uiDrawTextStretchExpanded => 6,
   uiDrawTextStretchExtraExpanded => 7,
   uiDrawTextStretchUltraExpanded => 8
);
enum uiDrawTextAlign is export(:draw) (
  uiDrawTextAlignLeft => 0,
  uiDrawTextAlignCenter => 1,
  uiDrawTextAlignRight => 2,
);
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

enum uiForEach is export(:foreach) (
  uiForEachContinue => 0,
  uiForEachStop => 1,
);

enum uiAttributeType is export(:text) <
  uiAttributeTypeFamily
  uiAttributeTypeSize
  uiAttributeTypeWeight
  uiAtrributeTypeItalic
  uiAttributeTypeStretch
  uiAttributeTypeColor
  uiAttributeTypeBackground
  uiAttributeTypeUnderline
  uiAttributeTypeUnderlineColor
  uiAttrbuteTypeFeatures
>;

enum uiTableValueType is export(:table) (
  uiTableValueTypeString => 0,
  uiTableValueTypeImage => 1,
  uiTableValueTypeInt => 2,
  uiTableValueTypeColor => 3,
);
