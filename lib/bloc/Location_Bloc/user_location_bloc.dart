import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geocoding/geocoding.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:geocoding/geocoding.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:khan_foods/Utils/ApiServices/Api_Services.dart';
import 'package:khan_foods/Utils/Utlis/Util.dart';
import 'package:meta/meta.dart';

part 'user_location_event.dart';
part 'user_location_state.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState> {
  UserLocationBloc() : super(UserLocationInitialState()) {
    on<GetCurrentLocationOfUserSuccessfullyEvent>((event, emit) async {
      ApiServices apiService = ApiServices();
      String? name;
      String? area;
      String? country;
      String? street;
      String? completeAddress;
      try {
        Position position = await apiService.getUserCurrentLocation();
        // 1********************
        print('Try Position:$position');
        double longitude = position.longitude;
        double latitude = position.latitude;
        List<Placemark> placeMarks =
            await placemarkFromCoordinates(latitude, longitude);
        // 2 *********************
        print('Try placeMarks:$placeMarks');
        //for (int i = 0; i < placeMarks.length; i++) {
        name = placeMarks[0].name;
        // 3 ******************
        print('Try Name placeMarks.Name:$placeMarks[i].name');
        area = placeMarks[1].administrativeArea;
        // 4 ***********************
        print(
            'Try Area  placeMarks.administrativeArea:$placeMarks[i].administrativeArea');
        street = placeMarks[2].subThoroughfare;
        // 5 *****************
        print(
            'Try Street  placeMarks[i].subThoroughfare;:$placeMarks[i].subThoroughfare');
        country = placeMarks[3].country;
        // 6 *******************
        print('Try  Country placeMarks[i].country;:$placeMarks[i].country');
        // }
        completeAddress = '$name $street $area $country';
        //placeMarks.toString();

        emit.call(GetCurrentLocationOfUserSuccessfullyState(
            address: completeAddress.toString()));
        Utils().toastMessage('location:$completeAddress');
        // 7 **********************
        print('Try completeAddress location:$completeAddress');
      } catch (e) {
        emit.call(GetCurrentLocationOfUserfaildedState(message: e.toString()));
        Utils().toastMessage('Sorry Location : $e.toString()');
        print('Catch Location Error: $e.toString()');
      }
    });

    on<UserLocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
