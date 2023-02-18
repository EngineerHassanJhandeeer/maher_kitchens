// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:khan_foods/Widgets/CheckoutS_Screen_Widget.dart';
// import 'package:khan_foods/bloc/ConfirmOrder_Bloc/confirm_order_bloc.dart';

// class CheckoutScreen extends StatelessWidget {
//   const CheckoutScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(body: BlocBuilder<ConfirmOrderBloc, ConfirmOrderState>(
//       builder: (context, state) {
//         if (state is ConfirmOrderInitialState) {
//           print('ConfirmOrderInitialState');
//           return CheckoutScreenInitialUI();
//         } else if (state is ConfirmOrderSuccessfullyState) {
//           print('ConfirmOrderSuccessfullyState');
//           SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//               ),
//             );
//           });
//           return CheckoutScreenInitialUI();
//         } else if (state is ConfirmOrderFailedState) {
//           SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//               ),
//             );
//           });
//           print('ConfirmOrderFailedState');
//           return CheckoutScreenInitialUI();
//         }
//         //  else if (state is GetCurrentLocationOfUserSuccessfullyState) {
//         //   // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//         //   //   ScaffoldMessenger.of(context).showSnackBar(
//         //   //     SnackBar(
//         //   //       content: Text(state.message),
//         //   //     ),
//         //   //   );
//         //   // });

//         //   //print(GetCurrentLocationOfUserSuccessfullyState);
//         //   print('Address:$state.address');
//         //   return CheckoutScreenInitialUI();
//         // }

//         else {
//           print('Checkout screen  builder error');
//           return CheckoutScreenInitialUI();
//           //     Center(
//           //   child: Text('Checkout screen  builder error'),
//           // );
//         }
//       },
//     )));
//   }
// }nes (41 sloc)  1.45 KB

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khan_foods/Widgets/Address_Screen_Widget.dart';
import 'package:khan_foods/bloc/ConfirmOrder_Bloc/confirm_order_bloc.dart';

class AddreesPageScreen extends StatelessWidget {
  const AddreesPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        //CheckoutScreenInitialUI(),
        Container(child: BlocBuilder<ConfirmOrderBloc, ConfirmOrderState>(
          builder: (context, state) {
            if (state is ConfirmOrderInitialState) {
              return CheckoutScreenInitialUI();
            } else if (state is ConfirmOrderSuccessfullyState) {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              });
              return CheckoutScreenInitialUI();
            }

            //else if (state is GetCurrentLocationOfUserSuccessfullyState) {
            //   String myLocation = state.address;

            //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         content: Text(state.address),
            //       ),
            //     );
            //   });
            //   return CheckoutScreenInitialUI(
            //     location: myLocation,
            //   );
            // }
            else if (state is ConfirmOrderFailedState) {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              });
              return CheckoutScreenInitialUI();
            } else {
              return Center(child: CheckoutScreenInitialUI()
                  //Text('Checkout screen builder error'),
                  );
            }
          },
        )),
      ],
    )));
  }
}
