module Libui::Text is export {
constant Weight = do {
my enum Libui::Text::Weight (
  Minimum => 0,
  Thin => 100,
  UltraLight => 200,
  Light => 300,
  Book => 350,
  Normal => 400,
  Medium => 500,
  SemiBold => 600,
  Bold => 700,
  UltraBold => 800,
  Heavy => 900,
  UltraHeavy => 950,
  Maximum => 1000,
); Libui::Text::Weight }

constant Italic = do {
my enum Libui::Text::Italic (
  Normal => 0,
  Oblique => 1,
  Italic => 2,
); Libui::Text::Italic }

constant Stretch = do {
my enum Libui::Text::Stretch (
  UltraCondensed => 0,
  ExtraCondensed => 1,
  Condensed => 2,
  SemiCondensed => 3,
  Normal => 4,
  SemiExpanded => 5,
  Expanded => 6,
  ExtraExpanded => 7,
  UltraExpanded => 8,
); Libui::Text::Stretch }

constant Underline = do {
my enum Libui::Text::Underline (
  None => 0,
  Single => 1,
  Double => 2,
  Suggestion => 3,
); Libui::Text::Underline }

constant UnderlineColor = do {
my enum Libui::Text::UnderlineColor (
  Custom => 0,
  Spelling => 1,
  Grammar => 2,
  Auxiliary => 3,
); Libui::Text::UnderlineColor }
}
role Attribute[::T] {
  #Default to the Type object
  has T $.value is rw = T;
}

subset RGBA of Numeric where 0 <= * <= 1;

class Color is export {
  has RGBA $.r is rw;
  has RGBA $.g is rw;
  has RGBA $.b is rw;
  has RGBA $.a is rw;
}

class TextColor {
  also does Attribute[Color];
  multi method new(RGBA $r, RGBA $g, RGBA $b, RGBA $a) {
    self.bless(:value(Color.new(:$r, :$g, :$b, :$a)));
  }

  multi method new(RGBA :$r, RGBA :$g, RGBA :$b, RGBA :$a) {
    self.bless(:value(Color.new(:$r, :$g, :$b, :$a)));
  }

  multi method new(Color $value) {
    self.bless(:$value);
  }

  multi method new(Color :$value) {
    self.bless(:$value);
  }

  method Red() {
    return TextColor.new(Color.new(1.0, 0, 0, 1.0));
  }

  method Blue() {
    return TextColor.new(Color.new(0, 0, 1.0, 1.0));
  }

  method Green() {
    return TextColor.new(Color.new(0, 1.0, 0, 1.0));
  }

  method Cyan() {
    return TextColor.new(Color.new(0, 1.0, 1.0, 1.0));
  }

  method Purple() {
    return TextColor.new(Color.new(1.0, 0, 1.0, 1.0));
  }

  method Yellow() {
    return TextColor.new(Color.new(1.0, 1.0, 0, 1.0));
  }
}

#Example OpenTypeFeature: 'liga' => 1

subset OpenTypeFeature of Pair where { .key.chars == 4 and .value ~~ UInt};

class Feature is export {
  also does Attribute[OpenTypeFeature];

  submethod BUILD(OpenTypeFeature :$value) {
    $!value = $value;
  }

  multi method new(Str $key, $value) {
    self.bless(value => Pair.new(:$key, :$value));
  }

  multi method new(Pair $value) {
    self.bless(:$value)
  }

  method ACCEPTS(Feature $other) {
    $!value == $other.value;
  }
}

class Features is export {
  has Feature %.features;

  multi submethod BUILD(Features :$features) {
    %!features = $features.features;
  }

  multi submethod BUILD(Feature :%features) {
    %!features = %features;
  }
  multi submethod BUILD(Feature :$feature) {
    %!features.append($feature);
  }

  multi submethod new(Features $features) {
    self.bless(:$features);
  }

  multi submethod new(Feature $feature) {
    self.bless(:$feature);
  }


  method append(Feature $new-feature) {
    for %!features.kv -> $key, $feature {
      if $feature.type ~~ $new-feature.type {
        %!features[$key] = $new-feature;
        return self;
      }
      %!features.append($new-feature);
    }
  }

}


class Size {
  also does Attribute[Numeric]
}

subset WeightValue where { $_ ~~ UInt | Libui::Text::Weight };

class Weight {
  also does Attribute[WeightValue]
}

class Stretch {
  also does Attribute[Libui::Text::Stretch]
}

class Family {
  also does Attribute[Str]
}

class Underline {
  also does Attribute[Libui::Text::Underline]
}

class Italic {
  also does Attribute[Libui::Text::Italic]
}

class BackgroundColor is TextColor {}

class UnderlineColor is TextColor {
  has Libui::Text::UnderlineColor $.type;

  multi method new(RGBA:D $r, RGBA:D $g, RGBA:D $b, RGBA:D $a) {
    self.bless(type => Libui::Text::UnderlineColor::Custom, value => Color.new(:$r, :$g, :$b, :$a));
  }

  multi method new(RGBA:D :$r, RGBA:D :$g, RGBA:D :$b, RGBA:D :$a) {
    self.bless(type => Libui::Text::UnderlineColor::Custom, value => Color.new(:$r, :$g, :$b, :$a));
  }

  multi method new(Libui::Text::UnderlineColor :$type, Color :$value) {
    if $type != Libui::Text::UnderlineColor::Custom {
      self.bless(:$type, value => Color.new(:r(0), :g(0), :b(0), :a(0)));
    } else {
      self.bless(:$value);
    }
  }

  multi submethod BUILD(Libui::Text::UnderlineColor :$type, Color :$value) {
    $!type = $type;
  }

  multi submethod BUILD(Color :$value) {
    $!type = Libui::Text::UnderlineColor::Custom;
  }
}

class Libui::Style is export {
  has TextColor $.color;
  has UnderlineColor $.underline-color;
  has Size $.size;
  has Italic $.italic;
  has BackgroundColor $.background-color;
  has Stretch $.stretch;
  has Family $.family;
  has Weight $.weight;
  has Underline $.underline;
  has Features $.features;

  submethod BUILD(:$family, :$size, :$weight, :$italic, :$stretch, :$color, :$background-color, :$underline, :$underline-color, :$features) {
  }

  submethod TWEAK(:$family, :$size, :$weight, :$italic, :$stretch, :$color, :$background-color, :$underline, :$underline-color, :$features) {
    self.set(:$family, :$size, :$weight, :$italic, :$stretch, :$color, :$background-color, :$underline, :$underline-color, :$features);
  }

  method with(*%attributes) {
    return self.clone.set(|%attributes);
  }

  method set(*%attributes) {
    for %attributes.kv -> $key, $value {
      given $key.lc {
        when "family" {
          next unless $value.defined;
          if $value ~~ Family {
            $!family = $value;
            next;
          }
          $!family = Family.new(:$value);
        }
        when "size" {
          next unless $value.defined;
          if $value ~~ Size {
            $!size = $value;
            next;
          }
          $!size = Size.new(:$value);
        }
        when "weight" {
          next unless $value.defined;
          if $value ~~ Weight {
            $!weight = $value;
            next;
          }
          $!weight = Weight.new(:$value);
        }
        when "italic" {
          next unless $value.defined;
          if $value ~~ Italic {
            $!italic = $value;
            next;
          }
          $!italic = Italic.new(:$value);
        }
        when "stretch" {
          next unless $value.defined;
          if $value ~~ Stretch {
            $!stretch = $value;
            next;
          }
          $!stretch = Stretch.new(:$value);
        }
        when "color" {
          next unless $value.defined;
          if $value ~~ TextColor {
            $!color = $value;
            next;
          }
          if $value ~~ List {
            $!color = TextColor.new(
              Color.new(r => $value[0], g => $value[1], b => $value[2], a => $value[3])
            );
            next;
          }
          $!color = TextColor.new(:$value);
        }
        when "background-color" {
          next unless $value.defined;
          if $value ~~ BackgroundColor {
            $!background-color = $value;
            next;
          }
          if $value ~~ List {
            $!background-color = BackgroundColor.new(
              Color.new(r => $value[0], g => $value[1], b => $value[2], a => $value[3])
            );
            next;
          }
          $!background-color = BackgroundColor.new(:$value);
        }
        when "underline" {
          next unless $value.defined;
          if $value ~~ Underline {
           $!underline = $value;
           next;
          }
          $!underline = Underline.new(:$value);
        }
        when "underline-color" {
          next unless $value.defined;
          if $value ~~ UnderlineColor {
            $!underline = $value;
            next;
          }
          if $value ~~ List {
            $!underline-color = UnderlineColor.new(
              r => $value[0].Num,
              g => $value[1].Num,
              b => $value[2].Num,
              a => $value[3].Num
            );
            next;
          }
          $!underline-color = UnderlineColor.new(type => $value);
        }
        when "feature" {
          next unless $value.defined;
          if $value ~~ Feature {
            $!features.append: $value;
          }
          if $value ~~ List {
            $!features.append($value[0] => $value[1]);
          }
          note "Invalid Feature $value";
        }
      }
    }
    self
  }
}
