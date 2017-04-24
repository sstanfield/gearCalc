import 'calc.dart';
import 'package:flutter/material.dart';

enum ResultsAs {
	GEAR_INCHES,
	METERS_OF_DEV,
	GEAR_RATIO
}

class AppState {
	GearCalc _calc;
	List<String> _chainrings;
	List<String> _sprockets;

	AppState() {
		_calc = new GearCalc();
		_chainrings = new List<String>();
		_sprockets = new List<String>();
		syncViews();
	}

	ResultsAs type = ResultsAs.GEAR_INCHES;  // Type of results to display.
	String diameterIn;
	String diameterCm;
	GearCalc get calc => _calc;
	List<String> get chainrings => _chainrings;
	List<String> get sprockets => _sprockets;

	void syncViews() {
		diameterIn = calc.wheelDiameterInches.toStringAsFixed(2);
		diameterCm = calc.wheelDiameterCm.toStringAsFixed(2);
		_chainrings.clear();
		for (int i = 0; i < calc.numFrontGears; i++) {
			_chainrings.add(calc.getFrontGear(i).toString());
		}
		_sprockets.clear();
		for (int i = 0; i < calc.numRearGears; i++) {
			_sprockets.add(calc.getRearGear(i).toString());
		}
	}
}
