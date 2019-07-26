use Libui::Raw :lib;
use Libui::Control;
use Libui::Image :raw;

use NativeCall;

enum uiTableValueType is export(:table) (
  uiTableValueTypeString => 0,
  uiTableValueTypeImage => 1,
  uiTableValueTypeInt => 2,
  uiTableValueTypeColor => 3,
);


class uiTableValueUnionColor is repr('CStruct') {
  has num64 $.r;
  has num64 $.g;
  has num64 $.b;
  has num64 $.a;
}

class uiTableValueUnion is repr('CUnion') {
  has Str $.str;
  has Pointer[uiImage] $.img;
  has int32 $.i;
  has uiTableValueUnionColor $.color;
}



class uiTableValue is repr('CStruct') is export {
  has int32 $.type;
  has uiTableValueUnion $.u;
}

class uiTableModelHandler is repr('CStruct') is export {
  has Pointer $.NumColumns;
  has Pointer $.ColumnType;
  has Pointer $.NumRows;
  has Pointer $.CellValue;
  has Pointer $.SetCellValue;
}

class uiTableModel is repr('CStruct') is export {
  #Unix
  has uiTableModelHandler $.mh is rw;
  #Windows
  #has Pointer[uiTableModelHandler] $.mh;
  #has Pointer[uiTableModel] $.model;
  #Darwin
  #has Pointer[uiTableModelHandler] $.mh;
  #1has Pointer[uiTableModel] $.m;
}

class uiTableTextColumnOptionalParams is repr('CStruct') is export {
  has int32 $.ColorModelColumn;
}

class uiTableParams is repr('CStruct') is export {
  has uiTableModel $.Model;
  has int32 $.RowBackgroundColorModelColumn;
}

class uiTable is repr('CStruct') is export {
  has int32 $.placeholder;
}

sub uiFreeTableValue(uiTableValue $v)
  is native(LIB)
  is export(:table)
  { * }

sub uiTableValueGetType(uiTableValue $v)
  returns uint32
  is native(LIB)
  is export(:table)
  { * }

sub uiNewTableValueString(Str $str)
  returns uiTableValue
  is native(LIB)
  is export(:table)
  { * }

sub uiTableValueString(uiTableValue $v)
  returns Str
  is native(LIB)
  is export(:table)
  { * }

sub uiNewTableValueImage(uiImage $img)
  returns uiTableValue
  is native(LIB)
  is export(:table)
  { * }

sub uiTableValueImage(uiTableValue $v)
  returns uiImage
  is native(LIB)
  is export(:table)
  { * }

sub uiNewTableValueInt(int32 $i)
  returns uiTableValue
  is native(LIB)
  is export(:table)
  { * }

sub uiTableValueInt(uiTableValue $v)
  returns int32
  is native(LIB)
  is export(:table)
  { * }

sub uiNewTableValueColor(num64 $r, num64 $g, num64 $b, num64 $a)
  returns uiTableValue
  is native(LIB)
  is export(:table)
  { * }

sub uiTableValueColor(uiTableValue $v
                     ,num64 $r is rw
                     ,num64 $g is rw
                     ,num64 $b is rw
                     ,num64 $a is rw
                     ) is native(LIB) is export { * }

sub uiTableAppendImageColumn(uiTable $t
                            ,Str $name
                            ,int32 $imageModelColumn
) is native(LIB) is export { * }

sub uiTableAppendImageTextColumn(uiTable $t
                                ,Str $name
                                ,int32 $imageModelColumn
                                ,int32 $textModelColumn
                                ,int32 $textEditableModelColumn
                                ,uiTableTextColumnOptionalParams $textParams
) is native(LIB) is export { * }

sub uiNewTableModel(uiTableModelHandler $mh is rw)
  returns uiTableModel
  is native(LIB)
  is export(:table)
  { * }

sub uiFreeTableModel(uiTableModel $m)
  is native(LIB)
  is export(:table)
  { * }

sub uiTableModelRowInserted(uiTableModel $m is rw, int32 $newIndex)
  is native(LIB)
  is export(:table)
  { * }

sub uiTableModelRowChanged(uiTableModel $m is rw, int32 $index)
  is native(LIB)
  is export(:table)
  { * }

sub uiTableModelRowDeleted(uiTableModel $m is rw, int32 $oldIndex)
  is native(LIB)
  is export(:table)
  { * }

sub uiTableAppendTextColumn(uiTable $t
                           ,Str $name
                           ,int32 $textModelColumn
                           ,int32 $textEditableModelColumn
                           ,uiTableTextColumnOptionalParams $textParams
                           ) is native(LIB) is export(:table) { * }

sub uiAppendImageColumn(uiTable $t, Str $name, int32 $imageModelColumn)
  is native(LIB)
  is export(:table)
  { * }

sub uiAppendImageTextColumn(uiTable $t
                           ,int32 $imageModelColumn
                           ,int32 $textModelColumn
                           ,int32 $textEditableModelColumn
                           ,uiTableTextColumnOptionalParams $textParams
                           ) is native(LIB) is export(:table) { * }

sub uiTableAppendCheckboxColumn(uiTable $t
                               ,Str $name
                               ,int32 $checkboxModelColumn
                               ,int32 $checkboxEditableModelColumn
                               ) is native(LIB) is export(:table) { * }

sub uiTableAppendCheckboxTextColumn(uiTable $t
                                   ,Str $name
                                   ,int32 $checkboxModelColumn
                                   ,int32 $checkboxEditableModelColumn
                                   ,int32 $textModelColumn
                                   ,int32 $textEditableModelColumn
                                   ,uiTableTextColumnOptionalParams
                                   ) is native(LIB) is export(:table) { * }

sub uiTableAppendProgressBarColumn(uiTable $t, Str $name, int32 $progressModelColumn)
  is native(LIB)
  is export(:table)
  { * }

sub uiTableAppendButtonColumn(uiTable $t
                             ,Str $name
                             ,int32 $buttonModelColumn
                             ,int32 $buttonClickableModelColumn
                             ) is native(LIB) is export(:table) { * }

sub uiNewTable(uiTableParams $params)
  returns uiTable
  is native(LIB)
  is export(:table)
  { * }


