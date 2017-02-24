import "dart:convert";

class GearCalc {
	static final String _KEY_DIAMETER = "wheelDiameterCm";
	static final String _KEY_FRONT = "frontGears";
	static final String _KEY_REAR = "rearGears";

	double _wheelDiameterCm = 66.04;
	List<int> _frontGears = [48, 36, 24];
	List<int> _rearGears = [11, 13, 15, 17, 19, 21, 24, 28, 32, 36, 40];

	GearCalc();

	void clearGears() {
		_frontGears.clear();
		_rearGears.clear();
	}

	void addFrontGear(int gear) {
		_frontGears.add(gear);
	}

	void addRearGear(int gear) {
		_rearGears.add(gear);
	}

	void setFrontGear(int slot, int gear) {
		_frontGears[slot] = gear;
	}

	void setRearGear(int slot, int gear) {
		_rearGears[slot] = gear;
	}

	int getFrontGear(int slot) {
		return _frontGears[slot];
	}

	int getRearGear(int slot) {
		return _rearGears[slot];
	}

	int get numFrontGears => _frontGears.length;
	int get numRearGears => _rearGears.length;
	double get wheelDiameterInches => _wheelDiameterCm / 2.54;
	double get wheelDiameterCm => _wheelDiameterCm;
	double get wheelDiameterM => _wheelDiameterCm / 100.0;
	set wheelDiameterInches(double inches) => _wheelDiameterCm = inches * 2.54;
	set wheelDiameterCm(double cm) => _wheelDiameterCm = cm;

	double gearInches(int frontGear, int rearGear) {
		return (_wheelDiameterCm / 2.54) * (_frontGears[frontGear] / _rearGears[rearGear]);
	}
	double gearRatio(int frontGear, int rearGear) {
		return _frontGears[frontGear] / _rearGears[rearGear];
	}
	double metersOfDev(int frontGear, int rearGear) {
		return ((_wheelDiameterCm * 3.14) / 100.0)  * (_frontGears[frontGear] / _rearGears[rearGear]);
	}

	GearCalc.fromJson(String json) {
		var m = JSON.decode(json);
		if (m.containsKey(_KEY_DIAMETER)) _wheelDiameterCm = double.parse(m[_KEY_DIAMETER]);
		if (m.containsKey(_KEY_FRONT)) {
			_frontGears.clear();
			_frontGears.addAll(m[_KEY_FRONT]);
		}
		if (m.containsKey(_KEY_REAR)) {
			_rearGears.clear();
			_rearGears.addAll(m[_KEY_REAR]);
		}
	}

	String toJson() {
		var m = new Map<String, Object>();
		m[_KEY_DIAMETER] = _wheelDiameterCm;
		m[_KEY_FRONT] = _frontGears;
		m[_KEY_REAR] = _rearGears;
		return JSON.encode(m);
	}

	void loadJson(String json) {
		var m = JSON.decode(json);
		if (m.containsKey(_KEY_DIAMETER)) _wheelDiameterCm = m[_KEY_DIAMETER];
		if (m.containsKey(_KEY_FRONT)) {
			_frontGears.clear();
			_frontGears.addAll(m[_KEY_FRONT]);
		}
		if (m.containsKey(_KEY_REAR)) {
			_rearGears.clear();
			_rearGears.addAll(m[_KEY_REAR]);
		}
	}
}