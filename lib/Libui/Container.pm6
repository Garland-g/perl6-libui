use Libui::Raw;
use Libui::Control;
unit role Libui::Container does Libui::Control;

method set-content(Libui::Control $control) { ... }

=begin Container
=head2 Libui::Container

=head3 Methods

C<set-content(Libui::Control $control)>

Places $control inside the Container. This method is always available on all Containers. Some have more sensibly-named methods to do the same thing, but this one will always work. For containers that hold more than one Widget, it uses the C<append> method.

=end Container
