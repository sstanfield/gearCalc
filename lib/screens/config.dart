import 'package:flutter/material.dart';
import '../state.dart';

class ConfigScreen extends StatefulWidget {
	final AppState _appstate;

	ConfigScreen(this._appstate);

	@override
	_State createState() => new _State(_appstate);
}

class _State extends State<ConfigScreen> {
	final AppState _appstate;

	_State(this._appstate);

	Widget buildWheel() {
		List<Widget> cols = new List<Widget>();
		cols.add(new Text("Wheel"));
		cols.add(new TextField(
			decoration: new InputDecoration(labelText: "Diameter Inches:"),
			keyboardType: TextInputType.number,
			controller: new TextEditingController(text: _appstate.diameterIn),
			onChanged: (String val) {
			setState(() {
				_appstate.diameterIn = val;
				if (val.length > 0) {
					try {
						_appstate.calc.wheelDiameterInches = double.parse(val);
						_appstate.diameterCm = _appstate.diameterCm.copyWith(text: _appstate.calc.wheelDiameterCm.toStringAsFixed(2));
					} catch (ex) { }
				}
			});
		}));
		cols.add(new TextField(
			decoration: new InputDecoration(labelText: "Diameter CM:"),
			keyboardType: TextInputType.number,
			controller: new TextEditingController(text: _appstate.diameterCm),
			onChanged: (String val) {
			setState(() {
				_appstate.diameterCm = val;
				if (val.text.length > 0) {
					try {
						_appstate.calc.wheelDiameterCm = double.parse(val);
						_appstate.diameterIn = _appstate.diameterIn.copyWith(text: _appstate.calc.wheelDiameterInches.toStringAsFixed(2));
					} catch (ex) { }
				}
			});
		}));
		//ListView c3 = new ListView(children: cols);
		Column c3 = new Column(children: cols);
		return c3;
	}

	Widget buildChainring() {
		List<Widget> cols = new List<Widget>();
		for (int i = 0; i < _appstate.calc.numFrontGears; i++) {
			var ringLabel = "Big";
			if (i == 1) ringLabel = "Mid";
			if (i == 2) ringLabel = "Small";
			cols.add(
				new Expanded(
						child: new TextField(
							decoration: new InputDecoration(labelText: ringLabel),
							keyboardType: TextInputType.number,
							controller: new TextEditingController(text: _appstate.chainrings[i]),
							onChanged: (String val) {
								setState(() {
									_appstate.chainrings[i] = val;
									if (val.length > 0) {
										try {
											_appstate.calc.setFrontGear(i, int.parse(val));
										} catch (ex) {}
									}
								});
							}),
				));
		}
		// ListView seems to handle the Input widgets attempt to scroll to center,
		// without it you can not edit the last field.
		//ListView c3 = new ListView(children: [new Text("Chainring"), new Row(children: cols, crossAxisAlignment: CrossAxisAlignment.start)]);
		Column c3 = new Column(children: [new Text("Chainring"), new Row(children: cols, crossAxisAlignment: CrossAxisAlignment.start)]);
		return c3;
	}

	Widget buildCassette() {
		List<Widget> cols = new List<Widget>();
		for (int i = 0; i < _appstate.calc.numRearGears; i++) {
			cols.add(
				new Expanded(
					//child: new Container(
						child: new TextField(
							decoration: new InputDecoration(labelText: "${i+1}"),
							keyboardType: TextInputType.number,
							controller: new TextEditingController(text: _appstate.sprockets[i]),
							onChanged: (String val) {
								setState(() {
									_appstate.sprockets[i] = val;
									if (val.text.length > 0) {
										try {
											_appstate.calc.setRearGear(i, int.parse(val));
										} catch (ex) { }
									}
								});
							}),
						//margin: new EdgeInsets.all(1.0)),
				));
		}
		//ListView c3 = new ListView(children: [new Text("Cassette"), new Row(children: cols, crossAxisAlignment: CrossAxisAlignment.start), new Divider()]);
		Column c3 = new Column(children: [new Text("Cassette"), new Row(children: cols, crossAxisAlignment: CrossAxisAlignment.start)]);
		return c3;
	}

	@override
	Widget build(BuildContext context) {
		List<Widget> cols = new List<Widget>();
		cols.add(new Divider());
		cols.add(buildWheel());
		cols.add(new Divider());
		cols.add(buildChainring());
		cols.add(new Divider());
		cols.add(buildCassette());
		cols.add(new Divider());
		/*cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());
		cols.add(new Divider());*/
		//cols.add(new Container(padding: new EdgeInsets.all(500.0)));
		ListView c3 = new ListView(children: cols);//, itemExtent: 120.0);
		//PageView c3 = new PageView(children: cols);
		return c3;
	}
}
