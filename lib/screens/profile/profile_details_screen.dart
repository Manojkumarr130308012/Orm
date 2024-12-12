import 'package:dms_dealers/screens/profile/profile_details_bloc.dart';
import 'package:dms_dealers/screens/profile/profile_details_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../base/base_state.dart';
import '../../utils/color_resources.dart';
import '../../utils/contants.dart';
import '../../utils/image_resources.dart';
import '../../widgets/logout_sheet.dart';
import '../../widgets/main_menu_card.dart';
import 'model/profile_details.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileDetailsScreen> {
  late ProfileDetailsBloc bloc;  String username = "";
  String mobileno = "";
  String name = "";
  String designation = "";
  String emailid = "";
  String address = "";
  late ProfileData profileData;
  final List<Map<String, dynamic>> items = [
    {'icon': ImageResource.vehicle3, 'title': '02', 'subtitle': 'Vehicle'},
    {'icon': ImageResource.spare2, 'title': '05', 'subtitle': 'Spare'},
    {'icon': ImageResource.acc, 'title': '__', 'subtitle': 'Accessory'},
    {'icon': ImageResource.acc, 'title': '__', 'subtitle': 'Accessory'},
  ];
  bool _isSwitched = false;


  @override
  void initState() {
    bloc = BlocProvider.of<ProfileDetailsBloc>(context);
    bloc.add(ProfileDetailsApiEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: bloc,
        listener: (BuildContext context, BaseState state) async {},
        child: BlocBuilder(
            bloc: bloc,
            builder: (BuildContext context, BaseState state) {
              if (state is InitialState) {
                return const Center(
                  child: Text('New'),
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
              return SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           MainMenuCard(
                            img: ImageResource.profile,
                            title: username != "" ? username : Constants.name,
                            subTitle: mobileno != "" ? mobileno : Constants.mobileNo,
                            isProfile: true
                          ),
                          const Divider(
                            color: ColorResource.lightGrey2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            runSpacing: 16,
                            spacing: 16,
                            children: [
                              for (int i = 0; i < items.length; i++)
                                Container(
                                  width: MediaQuery.of(context).size.width / 2.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                      Border.all(color: ColorResource.lightGrey2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Image.asset(items[i]['icon']),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                items[i]['title'],
                                                style: const TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                items[i]['subtitle'],
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ])
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: ColorResource.lightGrey2)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Dealer Details',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    color: ColorResource.lightGrey2,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(ImageResource.ev),
                                      Row(
                                        children: [
                                          Image.asset(ImageResource.cmnt),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(ImageResource.call),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  buildDetails('Name', name != "" ? name : "N/A", 'Mobile No.',  mobileno != "" ? mobileno : "N/A",
                                      'Designation', designation != "" ? designation : "N/A", 'Email ID',emailid != "" ? emailid : "N/A"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  buildDetailText(
                                      'Address', address != "" ? address : "N/A")
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorResource.lightGrey),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'My Vehicle',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Switch(
                                    value: _isSwitched,
                                    onChanged: (value) {
                                      setState(() {
                                        _isSwitched = value;
                                      });
                                    },
                                    activeColor: Colors.white,
                                    inactiveThumbColor: Colors.grey,
                                    activeTrackColor: ColorResource.primaryColor,
                                    activeThumbImage:
                                    const AssetImage(ImageResource.check),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorResource.lightGrey),
                            child: const Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                              child: Text(
                                'Support',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorResource.lightGrey),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return const LogoutSheet();
                                            });
                                      },
                                      icon: const Icon(Icons.logout))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Version 8.2.12',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}


class ServiceDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const ServiceDetailItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}


class ReceiptDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const ReceiptDetailItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}


Widget buildDetails(String label1, String value1, String label2, String value2,
    String label3, String value3, String label4, String value4) {
  return Row(
    children: [
      Expanded(child: _buildDetailColumn(label1, value1, label2, value2)),
      Expanded(child: _buildDetailColumn(label3, value3, label4, value4)),
    ],
  );
}

Widget _buildDetailColumn(
    String label1, String value1, String label2, String value2) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildDetailText(label1, value1),
      const SizedBox(height: 10),
      buildDetailText(label2, value2),
    ],
  );
}

Widget buildDetailText(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorResource.lightGrey3,
          fontFamily: 'Inter',
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorResource.black1,
          fontFamily: 'Inter',
        ),
      ),
    ],
  );
}