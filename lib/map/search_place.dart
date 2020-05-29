import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/maps_bloc.dart';
import 'bloc/maps_event.dart';
import 'bloc/maps_state.dart';

class SearchPlace extends StatelessWidget {
  final VoidCallback _onPressed;

  SearchPlace({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 0,
      left: 0,
      child: Column(
        children: <Widget>[
          Card(
            elevation: 5,
            child: TextField(
              onSubmitted: (_) => BlocProvider.of<MapsBloc>(context)
                  .add(FetchPlaceFromAddressPressed(place: _)),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: 'Buscar',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                filled: true,
              ),
            ),
          ),
          BlocBuilder(
            bloc: BlocProvider.of<MapsBloc>(context),
            builder: (context, state) {
              if (state is LocationFromPlaceFound) {
                return Card(
                  child: ListTile(
                      title: Text(state.locationModel.nombre),
                      subtitle: Text(state.locationModel.direccion),
                      leading: Icon(
                        Icons.place,
                      ),
                      onTap: _onPressed),
                );
              } else {
                return Container();
              }
            },
          )

          // : Container();
        ],
      ),
    );
  }

  void submitPlaceSearch(String _place) {
    print(_place);
  }
}
