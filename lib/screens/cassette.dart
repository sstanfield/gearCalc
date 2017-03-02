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
	      cols.add(
          new Expanded(
            child: new Container(
                child: new Input(
                    labelText: "${i+1}",
                    isDense: true,
                    keyboardType: TextInputType.number,
                    value: _appstate.sprockets[i],
                    onChanged: (InputValue val) {
                      setState(() {
	                      _appstate.sprockets[i] = val;
	                      if (val.text.length > 0) {
		                      try {
			                      _appstate.calc.setRearGear(i, int.parse(val.text));
		                      } catch (ex) { }
	                      }
                      });
                    }),
                margin: new EdgeInsets.all(1.0)),
          ));
	      /*for (int i = 0; i < _appstate.calc.numRearGears; i++) {
			cols.add(new Input(labelText: "Sprocket ${i+1}:", keyboardType: TextInputType.number, value: _appstate.sprockets[i], onChanged: (InputValue val) {
				setState(() {
					_appstate.sprockets[i] = val;
					if (val.text.length > 0) {
						try {
							_appstate.calc.setRearGear(i, int.parse(val.text));
						} catch (ex) { }
					}
				});
			}));*/
		}
		//ListView c3 = new ListView(children: cols);
		ListView c3 = new ListView(children: [new Text("Cassette"), new Row(children: cols, crossAxisAlignment: CrossAxisAlignment.start), new Divider()]);
		return c3;/*new Container(child: c3,
			decoration: new BoxDecoration(
			border: new Border.all(
			color: Colors.black,
			width: 1.0,
		),
		));*/
	}
}