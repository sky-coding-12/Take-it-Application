import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../services/api_calling.dart';
import 'all_approved_loan.dart';
import 'all_loan_offer.dart';
import 'all_loan_request_by_vendor.dart';
import 'loan_offer_screen.dart';

class ParticularVendor extends StatefulWidget {
  final int phone;
  final String bankId;
  const ParticularVendor({Key? key, required this.phone, required this.bankId})
      : super(key: key);

  @override
  State<ParticularVendor> createState() => _ParticularVendorState();
}

class _ParticularVendorState extends State<ParticularVendor> {
  late Future<VendorSpringBootModel> vendor;
  late int phone;
  late String bankId;
  late Future<List<int>> ans;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    bankId = widget.bankId;
    setState(() {
      vendor = fetchParticularVendor(phone.toString());
      ans = getCustomerCount(phone.toString());
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
                        builder: (context) => AllLoanRequestByVendor(
                              vendorPhone: phone,
                              bankPhone: bankId,
                            )));
              },
              tooltip: "Loan Request",
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
                        builder: (context) => AllLoanOffers(
                              bankId: bankId,
                              vendorPhone: phone,
                            )));
              },
              tooltip: "Loan Offer List",
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
                        builder: (context) => AllApprovedLoan(
                              bankId: bankId.toString(),
                              vendorPhone: phone,
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
                  future: vendor,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage("${snapshot.data!.image}"),
                                  radius: 70,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  snapshot.data!.vendorName!.toUpperCase(),
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 18.0,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Shop Name : ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      "${snapshot.data!.shopName}",
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                                        "Shop Address : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.address}",
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
                              child: FutureBuilder(
                                future: ans,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  } else if (snapshot.hasData) {
                                    return Card(
                                      elevation: 8.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Total Customers : ",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: mainColor,
                                              ),
                                            ),
                                            const SizedBox(height: 5.0),
                                            Text(
                                              "${snapshot.data!.first}",
                                              style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
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
                                        "Email ID : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.email}",
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
                                        "Total Debit Amount : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.totalDebit}",
                                        style: const TextStyle(
                                          color: Colors.red,
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
                                        "Total Loan Amount : ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: mainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${snapshot.data!.totalLoanAmount}",
                                        style: const TextStyle(
                                          color: Colors.red,
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
                                  "Give Loan Offer",
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
                                          builder: (context) => LoanOffer(
                                                bankId: bankId,
                                                vendorId: phone,
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
