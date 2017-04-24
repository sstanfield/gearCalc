import 'package:flutter/material.dart';
import '../state.dart';

class ResultsScreen extends StatefulWidget {
	final AppState _appstate;

	ResultsScreen(this._appstate);

	@override
	_State createState() => new _State(_appstate);
}

class _State extends State<ResultsScreen> {
	final AppState _appstate;

	_State(this._appstate);

	void typeSelected(ResultsAs val) {
		setState(() {
			_appstate.type = val;
		});
	}

	List<PopupMenuEntry<ResultsAs>> typeMenuItemBuilder(BuildContext context) {
		return [new PopupMenuItem<ResultsAs>(
			value: ResultsAs.GEAR_INCHES,
			child: new Text('Gear Inches')
		),
		new PopupMenuItem<ResultsAs>(
			value: ResultsAs.METERS_OF_DEV,
			child: new Text('Meters of Development')
		),
		new PopupMenuItem<ResultsAs>(
			value: ResultsAs.GEAR_RATIO,
			child: new Text('Gear Ratios')
		),
		];
	}

	@override
	Widget build(BuildContext context) {
		List<Widget> cols = new List<Widget>();
		List<Widget> children = new List<Widget>();
		children.add(new Text("  X  "));
		for (int c = 0; c < _appstate.calc.numRearGears; c++) {
			children.add(new Text("  ${_appstate.calc.getRearGear(c)}  "));
		}
		cols.add(new Column(children: children));
		for (int i = 0; i < _appstate.calc.numFrontGears; i++) {
			List<Widget> children = new List<Widget>();
			children.add(new Text("  ${_appstate.calc.getFrontGear(i)}  "));
			for (int c = 0; c < _appstate.calc.numRearGears; c++) {
				if (_appstate.type == ResultsAs.GEAR_INCHES)
					children.add(new Text("  ${_appstate.calc.gearInches(i, c).toStringAsFixed(2)}  "));
				if (_appstate.type == ResultsAs.METERS_OF_DEV)
					children.add(new Text("  ${_appstate.calc.metersOfDev(i, c).toStringAsFixed(2)}  "));
				if (_appstate.type == ResultsAs.GEAR_RATIO)
					children.add(new Text("  ${_appstate.calc.gearRatio(i, c).toStringAsFixed(2)}  "));
			}
			cols.add(new Expanded(child: new Column(children: children)));
		}
		Row row = new Row(children: cols);
		Row selRow;
		if (_appstate.type == ResultsAs.GEAR_INCHES) {
			selRow = new Row(children: [
				new Text( "Gear Inches (${_appstate.calc.wheelDiameterInches.toStringAsFixed(2)} inches diameter)"),
				new PopupMenuButton(onSelected: typeSelected, itemBuilder: typeMenuItemBuilder)
			]);
		}
		else if (_appstate.type == ResultsAs.METERS_OF_DEV) {
			selRow = new Row(children: [
				new Text("Meters of Development (${_appstate.calc.wheelDiameterM.toStringAsFixed(3)}M circumference)"),
				new PopupMenuButton(onSelected: typeSelected, itemBuilder: typeMenuItemBuilder)
			]);
		}
		else { // _GEAR_RATIO
			selRow = new Row(children: [
				new Text("Gear Ratios (wheel size not relevent)"),
				new PopupMenuButton(onSelected: typeSelected, itemBuilder: typeMenuItemBuilder)
			]);
		}
		return new ListView(children: [selRow, row]);
	}
}
