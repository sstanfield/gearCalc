import 'calc.dart';
import 'package:flutter/material.dart';

enum ResultsAs {
	GEAR_INCHES,
	METERS_OF_DEV,
	GEAR_RATIO
}

class AppState {
	GearCalc _calc;
	List<InputValue> _chainrings;
	List<InputValue> _sprockets;

	AppState() {
		_calc = new GearCalc();
		_chainrings = new List<InputValue>();
		_sprockets = new List<InputValue>();
		syncViews();
	}

	ResultsAs type = ResultsAs.GEAR_INCHES;  // Type of results to display.
	InputValue diameterIn;
	InputValue diameterCm;
	GearCalc get calc => _calc;
	List<InputValue> get chainrings => _chainrings;
	List<InputValue> get sprockets => _sprockets;

	void syncViews() {
		diameterIn = new InputValue(text: calc.wheelDiameterInches.toStringAsFixed(2));
		diameterCm = new InputValue(text: calc.wheelDiameterCm.toStringAsFixed(2));
		_chainrings.clear();
		for (int i = 0; i < calc.numFrontGears; i++) {
			_chainrings.add(new InputValue(text: calc.getFrontGear(i).toString()));
		}
		_sprockets.clear();
		for (int i = 0; i < calc.numRearGears; i++) {
			_sprockets.add(new InputValue(text: calc.getRearGear(i).toString()));
		}
	}
}
