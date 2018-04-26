use Libui::Raw;

unit role Libui::Control;

method !WIDGET() { ... }

method Control( --> uiControl) { 
	return uicontrol(self!WIDGET()); 
}

method destroy() {
	uiControlDestroy(self.Control);
}

method parent() returns uiControl {
	return uiControlParent(self.Control);
}

method set-parent(uiControl $control)  {
	uiControlSetParent(self.Control, $control); 
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


