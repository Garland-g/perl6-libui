use Libui::Raw :control, :uicontrol;

unit role Libui::Control;

method !WIDGET() { ... }

method Control( --> uiControl) {
  return uicontrol(self!WIDGET());
}

method destroy() {
  uiControlDestroy(self.Control);
}

multi method parent() returns uiControl {
  return uiControlParent(self.Control);
}

method set-parent(Libui::Control $control)  {
  uiControlSetParent(self.Control, $control.Control);
}

multi method parent(Libui::Control $control) {
  self.set-parent($control.Control);
}

method top-level() returns int32 {
  return uiControlToplevel(self.Control);
}

method visible() returns int32 {
  return uiControlVisible(self.Control);
}

method show() {
  uiControlShow(self.Control);
}

method hide() {
  uiControlHide(self.Control);
}

method enabled() returns int32 {
  return uiControlEnabled(self.Control);
}

method enable() {
  uiControlEnable(self.Control);
}

method disable() {
  uiControlDisable(self.Control);
}


