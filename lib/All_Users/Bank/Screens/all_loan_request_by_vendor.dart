import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/loan_request_model.dart';
import '../../../services/api_calling.dart';
import 'loan_approve_reject_by_bank.dart';

class AllLoanRequestByVendor extends StatefulWidget {
  final int vendorPhone;
  final String bankPhone;
  const AllLoanRequestByVendor(
      {Key? key, required this.vendorPhone, required this.bankPhone})
      : super(key: key);

  @override
  State<AllLoanRequestByVendor> createState() => _AllLoanRequestByVendorState();
}

class _AllLoanRequestByVendorState extends State<AllLoanRequestByVendor> {
  late Future<List<LoanRequestModel>> loanRequests;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loanRequests =
          getAllLoanRequest(widget.bankPhone, widget.vendorPhone.toString());
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
            "All Loan Requests",
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
            child: Align(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: loanRequests,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data.length != 0) {
                          return GestureDetector(
                            onTap: () {
                              snapshot.data[index].status == "Pending"
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BankLoanOfferApproveRejectByBank(
                                                loanId: snapshot
                                                    .data[index].loanRequestId,
                                              )))
                                  : print("");
                            },
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              elevation: 8.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 110.0,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          snapshot.data[index].status ==
                                                      "Pending" ||
                                                  snapshot.data[index].status ==
                                                      "Rejected"
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      "Status : ",
                                                      style: TextStyle(
                                                        color: mainColor,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${snapshot.data[index].status}",
                                                      style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      "Status : ",
                                                      style: TextStyle(
                                                        color: mainColor,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${snapshot.data[index].status}",
                                                      style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            children: [
                                              Text(
                                                "Loan Amount : ",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: mainColor),
                                              ),
                                              Text(
                                                "₹${snapshot.data[index].loanAmount}",
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            children: [
                                              Text(
                                                "Loan Interest : ",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: mainColor),
                                              ),
                                              Text(
                                                "${snapshot.data[index].loanInterest}%",
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            children: [
                                              Text(
                                                "Duration : ",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: mainColor),
                                              ),
                                              Text(
                                                "${snapshot.data[index].duration} Year",
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Text("No Data Found");
                        }
                      },
                    );
                  }
                  return Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2 - 100,
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
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
