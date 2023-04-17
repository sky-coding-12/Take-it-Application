import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/bank_spring_boot_model.dart';
import '../../../services/api_calling.dart';
import 'all_approved_loan.dart';
import 'all_loan_offers_by_bank.dart';
import 'all_loan_request.dart';
import 'loan_request.dart';

class ParticularBank extends StatefulWidget {
  final String vendorPhone;
  final int bankPhone;
  const ParticularBank(
      {Key? key, required this.bankPhone, required this.vendorPhone})
      : super(key: key);

  @override
  State<ParticularBank> createState() => _ParticularBankState();
}

class _ParticularBankState extends State<ParticularBank> {
  late String vendorPhone;
  late int bankPhone;
  late Future<BankSpringBootModel> bank;

  @override
  void initState() {
    super.initState();
    vendorPhone = widget.vendorPhone;
    bankPhone = widget.bankPhone;
    setState(() {
      bank = fetchParticularBank(bankPhone.toString());
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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllLoanOfferByBank(
                              vendorPhone: vendorPhone,
                              bankId: bankPhone,
                            )));
              },
              tooltip: "Loan Offer",
              icon: Icon(
                CupertinoIcons.square_grid_2x2,
                color: mainColor,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllLoanRequest(
                              bankId: bankPhone,
                              vendorPhone: vendorPhone,
                            )));
              },
              tooltip: "Loan Request List",
              icon: Icon(
                CupertinoIcons.square_list,
                color: mainColor,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllApprovedLoans(
                              bankId: bankPhone,
                              vendorPhone: vendorPhone,
                            )));
              },
              tooltip: "Total Loans",
              icon: Icon(
                CupertinoIcons.archivebox,
                color: mainColor,
              ),
            ),
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Center(
              child: FutureBuilder(
                  future: bank,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage("${snapshot.data!.image}"),
                              radius: 70,
                            ),
                            const SizedBox(height: 5.0),
                            const Divider(thickness: 2.0),
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
                                        "Bank Name : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.bankName}",
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
                                        "Bank Branch : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.bankBranch}",
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
                                        "Phone Number : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.phoneNumber}",
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
                                        "Bank Address : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.bankAddress}",
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
                              width: MediaQuery.of(context).size.width * 0.93,
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromRGBO(63, 72, 204, 1))),
                                child: const Text(
                                  "Request for Loan",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoanRequest(
                                                bankPhone: bankPhone,
                                                vendorPhone: vendorPhone,
                                              )));
                                },
                              ),
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
}
