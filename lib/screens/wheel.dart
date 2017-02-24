import 'package:flutter/material.dart';
import '../state.dart';

class WheelScreen extends StatefulWidget {
	final AppState _appstate;

	WheelScreen(this._appstate);

	@override
	_State createState() => new _State(_appstate);
}

class _State extends State<WheelScreen> {
	final AppState _appstate;

	_State(this._appstate);

	@override
	Widget build(BuildContext context) {
		List<Widget> cols = new List<Widget>();
		cols.add(new Input(labelText: "Diameter Inches:", keyboardType: TextInputType.number, value: _appstate.diameterIn, onChanged: (InputValue val) {
			setState(() {
				_appstate.diameterIn = val;
				if (val.text.length > 0) {
					try {
						_appstate.calc.wheelDiameterInches = double.parse(val.text);
						_appstate.diameterCm = _appstate.diameterCm.copyWith(text: _appstate.calc.wheelDiameterCm.toStringAsFixed(2));
					} catch (ex) { }
				}
			});
		}));
		cols.add(new Input(labelText: "Diameter CM:", keyboardType: TextInputType.number, value: _appstate.diameterCm, onChanged: (InputValue val) {
			setState(() {
				_appstate.diameterCm = val;
				if (val.text.length > 0) {
					try {
						_appstate.calc.wheelDiameterCm = double.parse(val.text);
						_appstate.diameterIn = _appstate.diameterIn.copyWith(text: _appstate.calc.wheelDiameterInches.toStringAsFixed(2));
					} catch (ex) { }
				}
			});
		}));
		ListView c3 = new ListView(children: cols);
		return c3;
	}
}
