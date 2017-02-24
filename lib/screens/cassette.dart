import 'package:flutter/material.dart';
import '../state.dart';

class CassetteScreen extends StatefulWidget {
	final AppState _appstate;

	CassetteScreen(this._appstate);

	@override
	_State createState() => new _State(_appstate);
}

class _State extends State<CassetteScreen> {
	final AppState _appstate;

	_State(this._appstate);

	@override
	Widget build(BuildContext context) {
		List<Widget> cols = new List<Widget>();
		for (int i = 0; i < _appstate.calc.numRearGears; i++) {
			cols.add(new Input(labelText: "Sprocket ${i+1}:", keyboardType: TextInputType.number, value: _appstate.sprockets[i], onChanged: (InputValue val) {
				setState(() {
					_appstate.sprockets[i] = val;
					if (val.text.length > 0) {
						try {
							_appstate.calc.setRearGear(i, int.parse(val.text));
						} catch (ex) { }
					}
				});
			}));
		}
		ListView c3 = new ListView(children: cols);
		return c3;
	}
}