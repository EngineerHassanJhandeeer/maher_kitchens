import 'package:bloc/bloc.dart';
//import 'package:geocoding/geocoding.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:khan_foods/Models/Conform_Order_Model.dart';
import 'package:khan_foods/Utils/ApiServices/Api_Services.dart';
import 'package:khan_foods/Utils/Local_Database/DbProvider.dart';
import 'package:khan_foods/Utils/Utlis/Util.dart';
import 'package:meta/meta.dart';
part 'confirm_order_event.dart';
part 'confirm_order_state.dart';

class ConfirmOrderBloc extends Bloc<ConfirmOrderEvent, ConfirmOrderState> {
  ProductDbProvider productDbProvider = ProductDbProvider();
  ConfirmOrderBloc() : super(ConfirmOrderInitialState()) {
    on<ConfirmOrderSuccessfullyEvent>((event, emit) async {
      try {
        ConfirmOrderModel model = event.model;
        Map<String, dynamic> data = await ApiServices.confirmOrder(model);
        if (data['Status'] == 'Order Inserted Successfully') {
          emit.call(ConfirmOrderSuccessfullyState(
              message: 'Your Order Has been placed Successfully'));
          // Utils().toastMessage('Your Order Has been placed Successfully');
          try {
            bool result = await productDbProvider.deleteAllProducts();
            if (result) {
              //Utils().toastMessage('deleted all data in database');
              print('deleted all data in database');
            } else {
              // Utils().toastMessage('can not delete data from database');
              print('can not delete data from database');
            }
          } catch (e) {
            // Utils().toastMessage('Exception in deletion from confirm order');
            print('Exception in deletion from confirm order');
          }
          emit.call(ConfirmOrderSuccessfullyState(
              message: 'Your Order Has been placed Successfully'));
        } else if (data['Status'] == 'Order Insertion Failed') {
          emit.call(ConfirmOrderFailedState(
              message: 'Sorry we can not place your Order'));
          //Utils().toastMessage('Sorry we can not place your Order');
        } else {
          emit.call(ConfirmOrderFailedState(
              message: 'else bloc of confirm Order bloc'));
          //Utils().toastMessage('else bloc of confirm Order bloc');
        }
      } catch (e) {
        emit.call(ConfirmOrderFailedState(message: e.toString()));
        // Utils().toastMessage(e.toString());
      }
    });

    // on<GetCurrentLocationOfUserSuccessfullyEvent>((event, emit) async {
    //   ApiServices apiService = ApiServices();
    //   String? name;
    //   String? area;
    //   String? country;
    //   String? street;
    //   String? completeAddress;
    //   try {
    //     Position position = await apiService.getUserCurrentLocation();
    //     // 1********************
    //     print('Try Position:$position');
    //     double longitude = position.longitude;
    //     double latitude = position.latitude;
    //     List<Placemark> placeMarks =
    //         await placemarkFromCoordinates(latitude, longitude);
    //     // 2 *********************
    //     print('Try placeMarks:$placeMarks');
    //     //for (int i = 0; i < placeMarks.length; i++) {
    //     name = placeMarks[0].name;
    //     // 3 ******************
    //     print('Try Name placeMarks.Name:$placeMarks[i].name');
    //     area = placeMarks[1].administrativeArea;
    //     // 4 ***********************
    //     print(
    //         'Try Area  placeMarks.administrativeArea:$placeMarks[i].administrativeArea');
    //     street = placeMarks[2].subThoroughfare;
    //     // 5 *****************
    //     print(
    //         'Try Street  placeMarks[i].subThoroughfare;:$placeMarks[i].subThoroughfare');
    //     country = placeMarks[3].country;
    //     // 6 *******************
    //     print('Try  Country placeMarks[i].country;:$placeMarks[i].country');
    //     // }
    //     completeAddress = '$name $street $area $country';
    //     //placeMarks.toString();

    //     // emit.call(GetCurrentLocationOfUserSuccessfullyState(
    //     //     address: completeAddress.toString()));
    //     Utils().toastMessage('location:$completeAddress');
    //     // 7 **********************
    //     print('Try completeAddress location:$completeAddress');
    //   } catch (e) {
    //     Utils().toastMessage('Sorry Location : $e.toString()');
    //     print('Catch Location Error: $e.toString()');
    //   }
    // });
    // on<GetCurrentLocationOfUserSuccessfullyEvent>((event, emit) async {
    //   ApiServices apiServices = ApiServices();
    //   String? name;
    //   String? area;
    //   String? country;
    //   String? street;
    //   String? completeAddress;
    //   try {
    //     Position position = await apiServices.getUserCurrentLocation();
    //     double longitude = position.longitude;
    //     double latitude = position.latitude;
    //     List<Placemark> placeMarks =
    //         await placemarkFromCoordinates(latitude, longitude);
    //     for (int i = 0; i < placeMarks.length; i++) {
    //       name = placeMarks[i].name;
    //       area = placeMarks[i].administrativeArea;
    //       street = placeMarks[i].subThoroughfare;
    //       country = placeMarks[i].country;
    //     }
    //     completeAddress = '$name $street $area $country';
    //     emit.call(GetCurrentLocationOfUserSuccessfullyState(
    //         address: completeAddress));
    //     Utils().toastMessage(completeAddress);
    //   } catch (e) {
    //     print('sorry location');
    //     Utils().toastMessage('Sorry Location');
    //   }
    // });
  }
}
/*

on<ConfirmOrderSuccessfullyEvent>((event, emit) async {
      try {
        ConfirmOrderModel model = event.model;
        Map<String, dynamic> data = await apiService.confirmOrder(model);
        if (data['Status'] == 'Order Inserted Successfully') {
          emit.call(ConfirmOrderSuccessfullyState(
              message: 'Your Order Has been placed Successfully'));
          try {
            bool result = await productDbProvider.deleteAllProducts();
            if (result) {
              print('deleted all data in database');
            } else {
              print('can not delete data from database');
            }
          } catch (e) {
            print('Exception in deletion from confirm order');
          }
          emit.call(ConfirmOrderSuccessfullyState(
              message: 'Your Order Has been placed Successfully'));
        } else if (data['Status'] == 'Order Insertion Failed') {
          emit.call(ConfirmOrderFailedState(
              message: 'Sorry we can not place your Order'));
        } else {
          emit.call(ConfirmOrderFailedState(
              message: 'else bloc of confirm Order bloc'));
        }
      } catch (e) {
        emit.call(ConfirmOrderFailedState(message: e.toString()));
      }
    });


*/
