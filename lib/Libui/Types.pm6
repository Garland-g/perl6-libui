unit module Libui::Types;

my package EXPORT::DEFAULT {
  subset SSIZE_T of Int where * >= -1;

  subset RGBA of Numeric where 0 <= * <= 1;

  subset Align of UInt where * < 4;

  subset At of UInt where * < 4;
}

=begin Types
=head2 Libui::Types

A set of types used in Libui.

=head4 C<SSIZE_T>

Equivalent to C's ssize_t. Can hold integers >= -1.

=head4 C<RGBA>

Holds a Numeric between 0 and 1, inclusive.

=head4 C<Align>

Holds an Int in the range of 0 to 3.

=item 0: Fill
=item 1: Start
=item 2: Center
=item 3: End

=head4 C<At>

Holds an Int in the range of 0 to 3.

=item 0: Left
=item 1: Top
=item 2: Right
=item 3: Bottom

=end Types
