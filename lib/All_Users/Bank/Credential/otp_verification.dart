import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../provider/bank_auth_provider.dart';
import '../../../utils/utils.dart';
import '../Screens/bank_dashboard.dart';
import 'bank_information_screen.dart';

class BankOtpScreen extends StatefulWidget {
  final String verificationId;
  const BankOtpScreen({super.key, required this.verificationId});

  @override
  State<BankOtpScreen> createState() => _BankOtpScreenState();
}

class _BankOtpScreenState extends State<BankOtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<BankAuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: isLoading == true
              ? Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                      CircularProgressIndicator(
                        color: mainColor,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(CupertinoIcons.back),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 200,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple.shade50,
                          ),
                          child: Image.asset(
                            "assets/images/otp.png",
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Verification",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Enter the OTP send to your phone number",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: mainColor,
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.065,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromRGBO(63, 72, 204, 1))),
                            child: const Text("Verify"),
                            onPressed: () {
                              if (otpCode != null) {
                                verifyOtp(context, otpCode!);
                              } else {
                                showSnackBar(context, "Enter 6-Digit code");
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<BankAuthProvider>(context, listen: false);
    ap.verifyBankOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingBank().then(
          (value) async {
            if (value == true) {
              // user exists in our app
              ap.getBankDataFromFireStore().then(
                    (value) => ap.saveBankDataToSP().then(
                          (value) => ap.setBankSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BankDashBoard(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BankInformationScreen()),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}
