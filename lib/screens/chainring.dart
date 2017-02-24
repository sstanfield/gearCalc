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
      cols.add(new Input(labelText: "Chainring ${i+1}:", keyboardType: TextInputType.number, value: _appstate.chainrings[i], onChanged: (InputValue val) {
        setState(() {
          _appstate.chainrings[i] = val;
          if (val.text.length > 0) {
            try {
              _appstate.calc.setFrontGear(i, int.parse(val.text));
            } catch (ex) { }
          }
        });
      }));
    }
    ListView c3 = new ListView(children: cols);
    return c3;
  }
}
