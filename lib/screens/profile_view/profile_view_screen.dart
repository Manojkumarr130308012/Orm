import 'package:dms_dealers/screens/profile_view/profile_view_bloc.dart';
import 'package:dms_dealers/screens/profile_view/profile_view_event.dart';
import 'package:dms_dealers/utils/color_resources.dart';
import 'package:dms_dealers/widgets/main_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../base/base_state.dart';
import '../../utils/image_resources.dart';
import '../profile/model/profile_details.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileViewBloc bloc;
  late ProfileData profileData;
  String username = "";
  String mobileno = "";
  String name = "";
  String designation = "";
  String emailid = "";
  String address = "";
  String firstname = "";
  String lastname = "";
  String country = "";
  String stateStr = "";
  String city = "";
  String pincode = "";
  String aadharcard = "";
  String pancard = "";
  String lincence = "";
  String panDocUrl = "";
  String aadharDocUrl = "";
  String licenceDocUrl = "";

  @override
  void initState() {
    bloc = BlocProvider.of<ProfileViewBloc>(context);
    bloc.add(ProfileViewApiEvent(context: context));
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
                  firstname = profileData.firstName;
                  lastname = profileData.lastName;
                  mobileno = "${profileData.customerPhoneMobile}";
                  name = profileData.firstName;
                  designation = profileData.customerType;
                  emailid = profileData.email;
                  address =
                  "${profileData.billingAddress.address},${profileData.billingAddress.city},${profileData.billingAddress.state},${profileData.billingAddress.country},${profileData.billingAddress.pincode}";
                  country = profileData.billingAddress.country;
                  stateStr = profileData.billingAddress.state;
                  city = profileData.billingAddress.city;
                  pincode = profileData.billingAddress.pincode;
                  aadharcard = profileData.aadharNo;
                  pancard = profileData.panNo;
                  lincence = profileData.licenceNo;
                  panDocUrl = profileData.panDoc;
                  aadharDocUrl = profileData.aadharDoc;
                  licenceDocUrl = profileData.licenceDoc;
                });
              }
            });
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Personal Details',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: ColorResource.black1,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: MainMenuCard(
                          img: ImageResource.profile,
                          title: firstname != "" ? firstname : "N/A",
                          subTitle: mobileno != '' ? mobileno : 'N/A'
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Personal Information',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              color: ColorResource.lightGrey2,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            buildDetails(
                              'Name',
                              firstname != "" ? firstname : "N/A",
                              'Mobile No.',
                              mobileno != "" ? mobileno : "N/A",
                              'Last',
                              lastname != "" ? lastname : "N/A",
                              'Email ID',
                              emailid != "" ? emailid : "N/A",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Billing Address',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              color: ColorResource.lightGrey2,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            buildDetails(
                              'Country/Region',
                              country != "" ? country : "N/A",
                              'City.',
                              city != "" ? city : "N/A",
                              'State',
                              stateStr != "" ? stateStr : "N/A",
                              'Pin code',
                              pincode != "" ? pincode : "N/A",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildDetailText(
                              'Address',
                              address,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Document',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              color: ColorResource.lightGrey2,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            buildDocumentRow(
                              label: 'Aadhaar No',
                              value: aadharcard != "" ? aadharcard : "N/A",
                              docUrl: aadharDocUrl,
                              onViewTap: () {
                                showPopup(context, 'Aadhaar No', aadharcard, aadharDocUrl);
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            buildDocumentRow(
                              label: 'Pan No',
                              value: pancard != "" ? pancard : "N/A",
                              docUrl: panDocUrl,
                              onViewTap: () {
                                showPopup(context, 'Pan No', pancard, panDocUrl);
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            buildDocumentRow(
                              label: 'Licence',
                              value: lincence != "" ? lincence : "N/A",
                              docUrl: licenceDocUrl,
                              onViewTap: () {
                                showPopup(context, 'Licence', lincence, licenceDocUrl);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showPopup(BuildContext context, String title, String content, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(content),
              const SizedBox(height: 10),
              Image.network(imageUrl),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Widget buildDocumentRow(
    {required String label, required String value, required String docUrl, required VoidCallback onViewTap}) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      children: [
        const Icon(
          Icons.file_copy_outlined,
          color: Colors.black,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: ColorResource.lightGrey3,
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: ColorResource.black1,
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onViewTap,
          child: const Text(
            'View',
            style: TextStyle(
              color: ColorResource.blue,
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDetails(String label1, String value1, String label2, String value2, String label3, String value3, String label4, String value4) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: buildDetailText(label1, value1),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: buildDetailText(label2, value2),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: buildDetailText(label3, value3),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: buildDetailText(label4, value4),
          ),
        ],
      ),
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
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorResource.lightGrey2,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    ],
  );
}
