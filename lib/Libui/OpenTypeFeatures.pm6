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
                               ,&f ( --> int32)
                               ,Pointer $data
                               ) is native(LIB) is export(:raw) { * }

  #
  subset OpenTypeFeatureName is export(:subsets) of Str where {
    / ^^ <[ ! .. ~ ]> <[ \x[0020] .. ~ ]> ** 3 $$ /
  };

  subset OpenTypeFeature is export(:subsets) of Pair where {
    .key ~~ OpenTypeFeatureName
    and .value ~~ UInt
  };

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

  multi method add(int8 :$a!, int8 :$b!, int8 :$c!, int8 :$d!, uint32 :$value! --> Nil) {
    uiOpenTypeFeaturesAdd(self, $a, $b, $c, $d, $value)
  }

  multi method add(OpenTypeFeature $feature) {
    my int8 ($a, $b, $c, $d) = $feature.key.comb».ord;
    uiOpenTypeFeaturesAdd(self, $a, $b, $c, $d, $feature.value);
  }

  multi method add(Str $key, Int $value) {
    self.add($key => $value);
  }

  multi method add(*%features) {
    for %features.kv -> $key, $value {
      self.add($key, $value);
    }
  }

  multi method add(*@features) {
    for @features -> Str $key, Int $value {
      self.add($key, $value);
    }
  }

  multi method remove(int8 :$a!, int8 :$b!, int8 :$c!, int8 :$d! --> Nil) {
    uiOpenTypeFeaturesRemove(self, $a, $b, $c, $d);
  }

  multi method remove(OpenTypeFeatureName $feature) {
    my int8 ($a, $b, $c, $d) = $feature.comb».ord;
    uiOpenTypeFeaturesRemove(self, $a, $b, $c, $d);
  }

  multi method remove(*@features) {
    for @features -> Str $feature {
      self.remove($feature);
    }
  }

  multi method get(int8 :$a!, int8 :$b!, int8 :$c!, int8 :$d!, :$value! is rw --> Int) {
    uiOpenTypeFeaturesGet(self, $a, $b, $c, $d, $value);
  }

  multi method get(OpenTypeFeatureName $feature --> Int) {
    my uint32 $value;
    my int8 ($a, $b, $c, $d) = $feature.comb».ord;
    my $result = uiOpenTypeFeaturesGet(self, $a, $b, $c, $d, $value);
    if $result != 0 {
      return $value;
    }
    return Int;
  }
}

constant OpenTypeFeatures is export = uiOpenTypeFeatures;
