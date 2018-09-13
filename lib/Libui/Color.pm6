
subset RGBA of Numeric where 0 <= * <= 1;

unit class Libui::Color;

has RGBA $.r is rw;
has RGBA $.g is rw;
has RGBA $.b is rw;
has RGBA $.a is rw;
