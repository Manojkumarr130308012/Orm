import 'package:dms_dealers/router.dart';
import 'package:dms_dealers/screens/drawer/drawer_bloc.dart';
import 'package:dms_dealers/utils/color_resources.dart';
import 'package:dms_dealers/utils/contants.dart';
import 'package:dms_dealers/utils/image_resources.dart';
import 'package:dms_dealers/widgets/main_menu_card.dart';
import 'package:dms_dealers/widgets/nav_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_state.dart';
import '../../utils/singleton.dart';

import '../profile/model/profile_details.dart';
import 'drawer_event.dart';

class DmsDrawer extends StatefulWidget {
  const DmsDrawer({super.key});

  @override
  State<DmsDrawer> createState() => _DmsDrawerState();
}

class _DmsDrawerState extends State<DmsDrawer> {
  late DrawerBloc bloc;
  String mobileno = "";
  String name = "";
  String username = "";
  String designation = "";
  String emailid = "";
  String address = "";
  late ProfileData profileData;
  String ProductName = "";
  String ChasisNo = "";
  final List<Map<String, String>> navMenu = [
    {'img': ImageResource.vehicle2, 'title': Constants.aboutVahicle},
    {'img': ImageResource.service, 'title': Constants.service},
    {'img': ImageResource.spare, 'title': Constants.spare}
  ];
  void navigateToScreen(String title) {
    print("title$title");
    switch (title) {
      case Constants.aboutVahicle:
        // BlocProvider(
        //       create: (BuildContext context) =>
        //       AboutVehicleBloc()..add(AboutVehicleInitialEvent(context: context)),
        //       child: const AboutVahicle());

         // Navigator.pushNamed(context, AppRoutes.aboutVahicle);
        break;
      case Constants.service:
        // Navigator.pushNamed(context, AppRoutes.serviceWarranty);
        break;
      case Constants.spare:
        // Navigator.pushNamed(context, AppRoutes.spareScreen);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<DrawerBloc>(context);
    bloc.add(ProfileDetailsApiEvent(context: context));
    bloc.add(GetUserVehicleEvent(context: context, arguments: FlashSingleton.instance.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, BaseState state) {
        if (state is InitialState) {
          return const Center(
            child: Text('Loading state'),
          );
        } else if (state is SuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.successResponse is ProfileDetails) {
              ProfileDetails response = state.successResponse;
              profileData = response.data;
              setState(() {
                username = "${profileData.firstName}${profileData.lastName}";
                mobileno = "${profileData.customerPhoneMobile}";
                name = profileData.firstName;
                designation = profileData.customerType;
                emailid = profileData.email;
                address = "${profileData.billingAddress.address},${profileData.billingAddress.city},${profileData.billingAddress.state},${profileData.billingAddress.country},${profileData.billingAddress.pincode}";
              });
            }
          });
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      Constants.mainManu,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(ImageResource.back))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.profile);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: ColorResource.lightGrey),
                      child:  MainMenuCard(
                        img: ImageResource.profile,
                        title: username,
                        subTitle: mobileno,
                        isDrawer: true,
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorResource.lightGrey2, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:  MainMenuCard(
                      img: ImageResource.vehicle1,
                      title: ProductName,
                      subTitle: ChasisNo,
                    )),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  Constants.navManu,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: navMenu.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NavMenuCard(
                              img: navMenu[index]['img']!,
                              title: navMenu[index]['title']!,
                              onTap: () {
                                print("testig${navMenu[index]['title']!}");
                                navigateToScreen(navMenu[index]['title']!);
                              }),
                        );
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
