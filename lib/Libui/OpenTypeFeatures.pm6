use Libui::Raw :lib;

use NativeCall;

enum uiForEach is export(:foreach) (
  uiForEachContinue => 0,
  uiForEachStop => 1,
);


class uiOTFeature is repr('CStruct') is export(:raw) {
  has int8 $.a;
  has int8 $.b;
  has int8 $.c;
  has int8 $.d;
}

class uiOpenTypeFeatures is repr('CStruct') is export(:raw) {

  sub uiNewOpenTypeFeatures()
    returns uiOpenTypeFeatures
    is native(LIB)
    is export(:raw)
    { * }

  sub uiFreeOpenTypeFeatures(uiOpenTypeFeatures $otf)
    is native(LIB)
    is export(:raw)
    { * }

  sub uiOpenTypeFeaturesClone(uiOpenTypeFeatures $otf) returns uiOpenTypeFeatures
    is native(LIB)
    is export(:raw)
    { * }

  sub uiOpenTypeFeaturesAdd(uiOpenTypeFeatures $otf is rw
                           ,int8 $a
                           ,int8 $b
                           ,int8 $c
                           ,int8 $d
                           ,uint32 $value
                           ) is native(LIB) is export(:raw) { * }

  sub uiOpenTypeFeaturesRemove(uiOpenTypeFeatures $otf is rw, int8 $a, int8 $b, int8 $c, int8 $d)
    is native(LIB)
    is export(:raw)
    { * }

  sub uiOpenTypeFeaturesGet(uiOpenTypeFeatures $otf is rw
                           ,int8 $a
                           ,int8 $b
                           ,int8 $c
                           ,int8 $d
                           ,uint32 $value is rw
                           ) returns int32 is native(LIB) is export(:raw) { * }

  sub uiOpenTypeFeaturesForEach(uiOpenTypeFeatures $otf
                               ,&f ( --> uiForEach)
                               ,Pointer $data
                               ) is native(LIB) is export(:raw) { * }


  has uiOTFeature $.data;
  has size_t $.len;
  has size_t $.cap;

  method new(--> uiOpenTypeFeatures) {
    uiNewOpenTypeFeatures;
  }

  method free(--> Nil) {
    uiFreeOpenTypeFeatures(self);
  }

  method clone(--> uiOpenTypeFeatures) {
    uiOpenTypeFeaturesClone(self);
  }

  method add(int8 :$a!, int8 :$b!, int8 :$c!, int8 :$d!, uint32 :$value! --> Nil) {
    uiOpenTypeFeaturesAdd(self, $a, $b, $c, $d, $value)
  }

  method remove(int8 :$a!, int8 :$b!, int8 :$c!, int8 :$d! --> Nil) {
    uiOpenTypeFeaturesRemove($a, $b, $c, $d);
  }

  method get(int8 :$a!, int8 :$b!, int8 :$c!, int8 :$d!, :$value! is rw --> Int) {
    uiOpenTypeFeaturesGet(self, $a, $b, $c, $d, $value);
  }

  method for-each(&f ( --> uiForEach), Pointer $data) {
    uiOpenTypeFeaturesForEach(&f, $data);
  }
}

