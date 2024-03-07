//Cubit para manejar los estados de place
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:favorite_places/models/place.dart';

class PlaceCubit extends Cubit<List<Place>> {
  PlaceCubit() : super(<Place>[]);

  void addPlace(Place place) {
    state.add(place);
    emit(List<Place>.from(state));
  }

  void removePlace(Place place) {
    state.remove(place);
    emit(List<Place>.from(state));
  }
}
