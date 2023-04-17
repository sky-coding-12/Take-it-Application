import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../Constant/const_variable.dart';
import '../../../Models/loan_request_model.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../services/api_calling.dart';
import 'bank_dashboard.dart';

class BankLoanOfferApproveRejectByBank extends StatefulWidget {
  final int loanId;
  const BankLoanOfferApproveRejectByBank({Key? key, required this.loanId})
      : super(key: key);

  @override
  State<BankLoanOfferApproveRejectByBank> createState() =>
      _BankLoanOfferApproveRejectByBankState();
}

class _BankLoanOfferApproveRejectByBankState
    extends State<BankLoanOfferApproveRejectByBank> {
  late int loanId;
  late Future<LoanRequestModel> particularLoanRequest;

  late int bankId;
  late int vendorId;
  late int amount;
  late int duration;
  late int interest;
  late String status;

  @override
  void initState() {
    super.initState();
    loanId = widget.loanId;
    setState(() {
      particularLoanRequest = getParticularLoanRequest(loanId.toString());
    });
    particularLoanRequest.then((value) => {
          status = value.status!,
          interest = value.loanInterest!,
          duration = value.duration!,
          amount = value.loanAmount!,
          vendorId = value.vendorId!,
          bankId = value.bankId!,
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              CupertinoIcons.back,
              color: mainColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Give or Not",
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Center(
              child: FutureBuilder(
                  future: particularLoanRequest,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 80.0,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                elevation: 8.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Vendor Number : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.vendorId}",
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            SizedBox(
                              height: 80.0,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                elevation: 8.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Amount : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "₹${snapshot.data!.loanAmount}",
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            SizedBox(
                              height: 80.0,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                elevation: 8.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Loan Interest : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.loanInterest}%",
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            SizedBox(
                              height: 80.0,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                elevation: 8.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Duration : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.duration} Year",
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            FutureBuilder(
                              future: fetchParticularVendor(
                                  snapshot.data!.vendorId!.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                } else if (snapshot.hasData) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.065,
                                            child: ElevatedButton(
                                              style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.green)),
                                              onPressed: () {
                                                updateLoanRequest(
                                                  loanId,
                                                  bankId,
                                                  vendorId,
                                                  amount,
                                                  duration,
                                                  interest,
                                                  "Approved",
                                                ).then((value) => {
                                                      saveBankLoan(
                                                        value.bankId.toString(),
                                                        value.vendorId
                                                            .toString(),
                                                        value.loanAmount
                                                            .toString(),
                                                        value.loanInterest
                                                            .toString(),
                                                        value.duration
                                                            .toString(),
                                                      ).then((value) => {
                                                            updateVendorLoanAmount(
                                                              value.vendorId!
                                                                  .toString(),
                                                              snapshot.data!
                                                                  .password,
                                                              snapshot.data!
                                                                  .vendorName!,
                                                              snapshot.data!
                                                                  .totalDebit,
                                                              snapshot.data!
                                                                  .address!,
                                                              snapshot.data!
                                                                  .totalLoanAmount,
                                                              snapshot.data!
                                                                  .vendorId,
                                                              snapshot.data!
                                                                  .shopName!,
                                                              snapshot
                                                                  .data!.email!,
                                                              snapshot
                                                                  .data!.image,
                                                              value.loanAmount!,
                                                            )
                                                                .whenComplete(
                                                                    () => {
                                                                          AwesomeDialog(
                                                                            context:
                                                                                context,
                                                                            headerAnimationLoop:
                                                                                true,
                                                                            animType:
                                                                                AnimType.scale,
                                                                            btnCancelColor:
                                                                                mainColor,
                                                                            dialogType:
                                                                                DialogType.success,
                                                                            btnOkOnPress:
                                                                                () {
                                                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BankDashBoard()));
                                                                            },
                                                                            btnOkColor:
                                                                                mainColor,
                                                                            title:
                                                                                'Success',
                                                                            desc:
                                                                                'Loan Offer Approved Successfully',
                                                                          ).show()
                                                                        })
                                                          }),
                                                    });
                                              },
                                              child: const Text(
                                                "APPROVE",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.065,
                                            child: ElevatedButton(
                                              style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.red)),
                                              onPressed: () {
                                                updateLoanRequest(
                                                  loanId,
                                                  bankId,
                                                  vendorId,
                                                  amount,
                                                  duration,
                                                  interest,
                                                  "Rejected",
                                                ).whenComplete(() => {
                                                      AwesomeDialog(
                                                        context: context,
                                                        headerAnimationLoop:
                                                            true,
                                                        animType:
                                                            AnimType.scale,
                                                        btnCancelColor:
                                                            mainColor,
                                                        dialogType:
                                                            DialogType.success,
                                                        btnOkOnPress: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const BankDashBoard()));
                                                        },
                                                        btnOkColor: mainColor,
                                                        title: 'Success',
                                                        desc:
                                                            'Loan Offer Rejected Successfully',
                                                      ).show()
                                                    });
                                              },
                                              child: const Text(
                                                "REJECT",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 2 - 100,
                          ),
                          CircularProgressIndicator(
                            color: mainColor,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Future<LoanRequestModel> updateLoanRequest(
      int loanId,
      int? bankId,
      int? vendorId,
      int? loanAmount,
      int? duration,
      int? loanInterest,
      String status) async {
    final response = await http.put(
      Uri.https(baseUrl, "/loanRequest/updateLoanRequest"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'bankId': bankId,
        'vendorId': vendorId,
        'loanAmount': loanAmount,
        'loanInterest': loanInterest,
        'status': status,
        'duration': duration,
        'loanRequestId': loanId,
      }),
    );

    if (response.statusCode == 200) {
      return LoanRequestModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update transaction.');
    }
  }

  Future<VendorSpringBootModel> updateVendorLoanAmount(
      String phone,
      String? password,
      String vendorName,
      int? totalDebit,
      String address,
      int? totalLoanAmount,
      int? vendorId,
      String shopName,
      String email,
      String? image,
      int amount) async {
    final response = await http.put(
      Uri.https(baseUrl, "/vendor/updateVendor"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'vendorName': vendorName,
        'phoneNumber': phone,
        'email': email,
        'password': password,
        'totalLoanAmount': totalLoanAmount! + amount,
        'totalDebit': totalDebit,
        'shopName': shopName,
        'address': address,
        'image': image,
        'vendorId': vendorId
      }),
    );

    if (response.statusCode == 200) {
      return VendorSpringBootModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update vendor password.');
    }
  }
}
