use Libui::Attribute;
use Libui::OpenTypeFeatures;
use Color;

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

  method Str {
    qq:to/END/;
    Style:
      TextColor: {$!color.defined ?? $!color.value !! TextColor.^name}
      UnderlineColor: {$!underline-color.defined ?? $!underline-color.value !! UnderlineColor.^name}
      Size: {$!size.defined ?? $!size.value !! $!size.WHAT}
      Italic: {$!italic.defined ?? $!italic.value !! Italic.^name}
      BackgroundColor: {$!background-color.defined ?? $!background-color.value !! BackgroundColor.^name}
      Stretch: {$!stretch.defined ?? $!stretch.value !! Stretch.^name}
      Family: {$!family.defined ?? $!family.value !! Family.^name}
      Weight: {$!weight.defined ?? $!weight.value !! Weight.^name}
      Underline: {$!underline.defined ?? $!underline.value !! Underline.^name}
      Features: {$!features.defined ?? $!features.value.list !! Features.^name}
    END
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
          elsif $value ~~ List {
            $!color = TextColor.new(value => Color.new(rgbad => $value));
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
          elsif $value ~~ List {
            $!background-color = BackgroundColor.new(value => Color.new(rgbad => $value));
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
          elsif $value ~~ Color {
            $!underline-color = UnderlineColor.new(:$value);
            next;
          }
          elsif $value ~~ List {
            $!underline-color = UnderlineColor.new(value => Color.new(rgbad => $value));
            next;
          }
          $!underline-color = UnderlineColor.new(type => $value.Int);
        }
        when "feature" {
          next unless $value.defined;
          if $value ~~ Features {
            $!features = $value;
          }
          elsif $value ~~ OpenTypeFeatures {
            $!features .= new($value);
          }
          elsif $value ~~ List {
            my $otf = OpenTypeFeatures.new;
            my (@pairs, @unpaired);
            $value.map({
              @pairs.append: $_ if $_ ~~ Pair;
              @unpaired.append: $_ if $_ !~~ Pair;
            });
            @pairs.map({$otf.add($_)});
            for @unpaired -> Str $key, Int $value {
              $otf.add($key => $value);
            }
            $!features .= new($otf);
          }
          else {
            note "Invalid Feature $value";
          }
        }
      }
    }
    self
  }
}
