// ignore_for_file: library_private_types_in_public_api

import 'package:dms_dealers/router.dart';
import 'package:dms_dealers/screens/otp_screen/model/OtpVerify.dart';
import 'package:dms_dealers/screens/otp_screen/otp_event.dart';
import 'package:dms_dealers/utils/perference_helper.dart';
import 'package:dms_dealers/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../base/base_state.dart';

import '../../utils/color_resources.dart';
import '../../utils/contants.dart';
import 'otp_bloc.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late OTPBloc bloc;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileNo = TextEditingController();
  final _pinCntrl = TextEditingController();
  BuildContext? showpopcontext;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<OTPBloc>(context);
    print("phone${FlashSingleton.instance.phone}");
    print("phoneotp${FlashSingleton.instance.otp}");
  }

  otpVerify(OTPBloc bloc) async {
    showLoader();
    final Map<String, dynamic> data = {
      "phone":FlashSingleton.instance.phone,
      "otp": _pinCntrl.text.trim().toString(),
    };
    bloc.add(OtpUserEvent(context: context, arguments: data));

  }

  @override
  void dispose() {
    _pinCntrl.dispose();
    super.dispose();
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
                child: Text('Loading state'),
              );
            } else if (state is SuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (state.successResponse is OtpVerify) {
                  final OtpVerify response = state.successResponse;
                  print("response$response");
                  // PreferenceHelper.setBearer(response.data.token);
                  // PreferenceHelper.setUserName("${response.data.firstName}${response.data.lastName}");
                  // PreferenceHelper.setId(response.res.id);
                  // PreferenceHelper.setLoginStatus(true);
                  FlashSingleton.instance.id = response.data.id;
                  // Navigator.pushReplacementNamed(context, AppRoutes.aboutVahicle);
                }
              });

            }
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                            SizedBox(height: 20,),
                            const Text(
                              Constants.otp,
                              style: TextStyle(
                                  color: ColorResource.loginWel,
                                  fontFamily: 'Poppins-Semibold',
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              Constants.enterCode,
                              style: TextStyle(
                                  color: ColorResource.color191919,
                                  // fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Pinput(
                              preFilledWidget: const Text('0'),
                              controller: _pinCntrl,
                              separatorBuilder: (index) =>
                                  const SizedBox(width: 15),
                              defaultPinTheme: PinTheme(
                                height: 70,
                                width: 70,
                                textStyle: const TextStyle(
                                  fontSize: 22,
                                  color: Color.fromRGBO(30, 60, 87, 1),
                                ),
                                decoration: BoxDecoration(
                                  color: ColorResource.lightGrey,
                                  borderRadius: BorderRadius.circular(19),
                                  border: Border.all(
                                      color: ColorResource.lightGrey2),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Constants.otp2,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorResource.color000000),
                                ),
                                Text(
                                  Constants.resend,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorResource.blue),
                                )
                              ],
                            ),
                            Text(
                              "${Constants.current_otp} ${FlashSingleton.instance.otp}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorResource.blue),
                            )
                          ],
                        ),
                        Column(children: [
                          SizedBox(
                              height: 45,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                      ColorResource.primaryColor,
                                    ),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    otpVerify(bloc);
                                  },
                                  child: const Text(
                                    Constants.verify,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ))),
                          const SizedBox(
                            height: 15,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Constants.agree),
                              Text(
                                Constants.tc,
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                              Text(' & '),
                              Text(
                                Constants.privacy,
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              )
                            ],
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        showpopcontext = context;
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
