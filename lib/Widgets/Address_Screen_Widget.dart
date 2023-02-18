import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khan_foods/Models/Conform_Order_Model.dart';
import 'package:khan_foods/Utils/Client_ID/Client_Id.dart';
import 'package:khan_foods/Widgets/My_Custom_Widget/My_Custom.dart';
import 'package:khan_foods/bloc/ConfirmOrder_Bloc/confirm_order_bloc.dart';
import 'package:khan_foods/bloc/Location_Bloc/user_location_bloc.dart';

import 'package:provider/provider.dart';

class CheckoutScreenInitialUI extends StatelessWidget {
  String? location;

  CheckoutScreenInitialUI({this.location, Key? key}) : super(key: key);
  final TextEditingController phoneNoTextEditingController =
      TextEditingController();
  final TextEditingController specialInstructionTextEditingController =
      TextEditingController();
  final TextEditingController addressTextEditingController =
      TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var location = Provider.of<UserLocationBloc>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      color: Colors.brown,
      child: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              //row......logo and text
              SizedBox(
                height: height * 0.1,
                child: Row(
                  children: [
                    //icon
                    SizedBox(
                      width: width * 0.15,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    //Text
                    SizedBox(
                      width: width * 0.85,
                      child: Center(
                        child: Text(
                          'YOUR  ADDRESS',
                          style: TextStyle(
                              color: Colors.yellow, fontSize: height * 0.03),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //space
              SizedBox(
                height: height * 0.02,
              ),
              //textField for Phone Number
              SizedBox(
                width: width * 0.8,
                height: height * 0.1,
                child: TextFormField(
                  // key: _phoneNumberKey,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone Number is Must';
                    } else if (value.length != 11) {
                      return 'Enter a Valid Phone No';
                    }
                    return null;
                  },
                  controller: phoneNoTextEditingController,
                  decoration: InputDecoration(
                      labelText: 'Your Contact ',
                      hintText: 'Phone Number',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03))),
                ),
              ),

              //space
              SizedBox(
                height: height * 0.02,
              ),
              //address
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Container(
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(width * 0.05),
                  ),
                  child: Row(
                    children: [
                      //textField
                      BlocBuilder<UserLocationBloc, UserLocationState>(
                        builder: (context, state) {
                          if (state is UserLocationInitialState) {
                            return Text(
                                'Tap on Icon,To Get your Current Location');
                          } else if (state
                              is GetCurrentLocationOfUserSuccessfullyState) {
                            return Text(state.address.toString());
                          } else if (state
                              is GetCurrentLocationOfUserfaildedState) {
                            return Text("Error State");
                          }
                          return Text(" Bloc Error");
                        },
                      ),

                      //space
                      SizedBox(
                        width: width * 0.03,
                      ),
                      //icon
                      SizedBox(
                        width: width * 0.12,
                        child: GestureDetector(
                          onTap: () {
                            // Provider.of<UserLocationBloc>(context,
                            //         listen: false).add(
                            //   GetCurrentLocationOfUserSuccessfullyEvent());
                            location.add(
                                GetCurrentLocationOfUserSuccessfullyEvent());
                            //addressTextEditingController.text =
                            //  location.toString();
                            //'Satellite Town  Punjab Pakistan';
                          },
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //space
              SizedBox(
                height: height * 0.02,
              ),
              //text
              SizedBox(
                height: height * 0.05,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: Text(
                      'Special Instruction',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              //space
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                height: height * 0.05,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: Text(
                      '''Any specific preferences? Let us Know                      ''',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.02,
                      ),
                    ),
                  ),
                ),
              ),
              //textField for special instruction
              //space
              SizedBox(
                height: height * 0.02,
              ),
              //textField
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Container(
                  height: height * 0.12,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(width * 0.03),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: TextField(
                      maxLines: 3,
                      controller: specialInstructionTextEditingController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'e.g  or Tasty etc',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
              //space
              SizedBox(
                height: height * 0.01,
              ),
              //text price
              SizedBox(
                height: height * 0.05,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.2,
                        child: Text(
                          'Total',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: height * 0.03),
                        ),
                      ),
                      //Space
                      SizedBox(
                        width: width * 0.52,
                      ),
                      //Price
                      SizedBox(
                        width: width * 0.2,
                        child: Text(
                          ClientId.orderTotalAmount.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //space
              SizedBox(
                height: height * 0.01,
              ),
              //button
              InkWell(
                onTap: () {
                  if (_key.currentState!.validate()) {
                    Provider.of<ConfirmOrderBloc>(context, listen: false).add(
                        ConfirmOrderSuccessfullyEvent(
                            model: ConfirmOrderModel(
                                clientId: ClientId.clientId,
                                orderTotalAmount: ClientId.orderTotalAmount,
                                orderAmount: ClientId.orderAmount,
                                orderDescription:
                                    specialInstructionTextEditingController
                                        .text,
                                deliveryAddress:
                                    addressTextEditingController.text,
                                deliveryPhoneNumber:
                                    phoneNoTextEditingController.text,
                                taxPercentage: ClientId.taxPercentage,
                                deliveryCharges: ClientId.deliveryCharges,
                                taxAmount: ClientId.taxAmount)));
                    phoneNoTextEditingController.clear();
                    specialInstructionTextEditingController.clear();
                    addressTextEditingController.clear();
                  }
                },
                child: Container(
                  width: width * 0.75,
                  height: height * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(width * 0.03)),
                  child: Center(
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.025),
                    ),
                  ),
                ),
              ),
              //space
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
