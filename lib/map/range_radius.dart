import 'package:example1/map/bloc/bloc.dart';
import 'package:example1/map/bloc/maps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RangeRadius extends StatefulWidget {
  final bool isRadiusFixed;
  const RangeRadius({@required this.isRadiusFixed});

  @override
  _RangeRadiusState createState() => _RangeRadiusState();
}

class _RangeRadiusState extends State<RangeRadius> {
  double _radius = 100;
  MapsBloc _mapsBloc;
  @override
  void initState() {
    super.initState();
    _mapsBloc = BlocProvider.of<MapsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _mapsBloc,
      listener: (context, state) {
        if (state is RadiusUpdate) {
          _radius = state.radius;
        }
      },
      child: Positioned(
        bottom: 20.0,
        left: 10.0,
        right: 10.0,
        child: Card(
            child: BlocBuilder(
          bloc: _mapsBloc,
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Text(_radius.toInt().toString() + ' Mtrs'),
                Slider(
                  max: 700,
                  min: 100,
                  value: _radius,
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey,
                  divisions: 12,
                  onChanged: (double value) {
                    if (!widget.isRadiusFixed) {
                      _mapsBloc.add(UpdateRangeValues(radius: value));
                    }
                  },
                ),
                FlatButton(
                  child: Text(widget.isRadiusFixed != true
                      ? 'Fijar Radio'
                      : 'Cancelar'),
                  onPressed: () => _mapsBloc.add(IsRadiusFixedPressed(
                      isRadiusFixed: widget.isRadiusFixed)),
                  color:
                      widget.isRadiusFixed != true ? Colors.blue : Colors.red,
                )
              ],
            );
          },
        )),
      ),
    );
  }
}
