import 'package:flutter/material.dart';
import '../state.dart';

class ChainringScreen extends StatefulWidget {
  final AppState _appstate;

  ChainringScreen(this._appstate);

  @override
  _State createState() => new _State(_appstate);
}

class _State extends State<ChainringScreen> {
  final AppState _appstate;

  _State(this._appstate);

  @override
  Widget build(BuildContext context) {
    List<Widget> cols = new List<Widget>();
    for (int i = 0; i < _appstate.calc.numFrontGears; i++) {
      var ringLabel = "Big";
      if (i == 1) ringLabel = "Mid";
      if (i == 2) ringLabel = "Small";
      cols.add(
          new Expanded(
            child: new Container(
                child: new Input(
                    labelText: ringLabel,
                    isDense: true,
                    keyboardType: TextInputType.number,
                    value: _appstate.chainrings[i],
                    onChanged: (InputValue val) {
                      setState(() {
                        _appstate.chainrings[i] = val;
                        if (val.text.length > 0) {
                          try {
                            _appstate.calc.setFrontGear(i, int.parse(val.text));
                          } catch (ex) {}
                        }
                      });
                    }),
                decoration: new BoxDecoration(
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                margin: new EdgeInsets.all(3.0)),
          ));
    }
    // ListView seems to handle the Input widgets attempt to scroll to center,
    // without it you can not edit the last field.
    ListView c3 = new ListView(children: [new Row(children: cols, crossAxisAlignment: CrossAxisAlignment.start)]);
    return c3;
  }
}
