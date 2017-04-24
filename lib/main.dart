import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/config.dart';
//import 'screens/wheel.dart';
//import 'screens/chainring.dart';
//mport 'screens/cassette.dart';
import 'screens/results.dart';
import 'state.dart';

void main() {
	//runApp(new App());
	runApp(new MaterialApp(title: "Gear Calc", home: new HomePage(title: 'Gear Calclator')));
}

class App extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return new MaterialApp(
			title: 'Flutter Demo',
			theme: new ThemeData(
			// This is the theme of your application.
			//
			// Try running your application with "flutter run". You'll see
			// the application has a blue toolbar. Then, without quitting
			// the app, try changing the primarySwatch below to Colors.green
			// and press "r" in the console where you ran "flutter run".
			// We call this a "hot reload". Notice that the counter didn't
			// reset back to zero -- the application is not restarted.
				primarySwatch: Colors.blue,
			),
			home: new HomePage(title: 'Gear Calculator'),
		);
	}
}

class HomePage extends StatefulWidget {
	HomePage({Key key, this.title}) : super(key: key);

	// This widget is the home page of your application. It is stateful,
	// meaning that it has a State object (defined below) that contains
	// fields that affect how it looks.

	// This class is the configuration for the state. It holds the
	// values (in this case the title) provided by the parent (in this
	// case the App widget) and used by the build method of the State.
	// Fields in a Widget subclass are always marked "final".

	final String title;

	@override
	_HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomePage> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
	//GearCalc _calc;// = new GearCalc();
	AppState _appstate = new AppState();
	TabController _tabController;

	final List<Tab> myTabs = <Tab>[
		new Tab(text: 'Bike Config'),
		//new Tab(text: 'Wheel'),
		//new Tab(text: 'Chainring'),
		//new Tab(text: 'Cassette'),
		new Tab(text: 'Results'),
	];

	Future<File> _getLocalFile() async {
		// get the path to the document directory.
		String dir = (await PathProvider.getApplicationDocumentsDirectory()).path;
		print("XXXX using file: $dir/default_gears.json");
		return new File('$dir/default_gears.json');
	}

	Future<String> _readState() async {
		try {
			File file = await _getLocalFile();
			// read the variable as a string from the file.
			String contents = await file.readAsString();
			return contents;
		} on FileSystemException {
			return "";
		}
	}

	@override
	//void didChangeAppLifecycleState(AppLifecycleState state) {
	Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
		if (state == AppLifecycleState.paused) {
			var json = _appstate.calc.toJson();
			print("XXXX SAVE: $json");
			await (await _getLocalFile()).writeAsString(json);
		}
	}

	@override
	void initState() {
		super.initState();
		WidgetsBinding.instance.addObserver(this);
		_tabController = new TabController(vsync: this, length: myTabs.length);
		_readState().then((String value) {
			setState(() {
				print("XXXX READ: $value");
				if (value.length > 0) {
					_appstate.calc.loadJson(value);
					_appstate.syncViews();
				}
			});
		});
	}

	@override
	void dispose() {
		_tabController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		AppBar appBar = new AppBar(
		// Here we take the value from the MyHomePage object that
		// was created by the App.build method, and use it to set
		// our appbar title.
			title: new Text(config.title),
			bottom: new TabBar(
				controller: _tabController,
				tabs: myTabs,
			),
		);
		FloatingActionButton floatingActionButton = new FloatingActionButton(
			onPressed: () {},
			tooltip: 'Increment',
			child: new Icon(Icons.add),
		);
		// This method is rerun every time setState is called, for instance
		// as done by the _incrementCounter method above.
		// The Flutter framework has been optimized to make rerunning
		// build methods fast, so that you can just rebuild anything that
		// needs updating rather than having to individually change
		// instances of widgets.
		return new Scaffold(
			appBar: appBar,
			body:new TabBarView(
				controller: _tabController,
				//children: [new WheelScreen(_appstate), new ChainringScreen(_appstate), new CassetteScreen(_appstate), new ResultsScreen(_appstate)]
				children: [new ConfigScreen(_appstate), new ResultsScreen(_appstate)]
			),
			floatingActionButton: floatingActionButton, // This trailing comma tells the Dart formatter to use
		// a style that looks nicer for build methods.
		);
	}
}
