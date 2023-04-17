import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../services/api_calling.dart';

class AllApprovedLoans extends StatefulWidget {
  final int bankId;
  final String vendorPhone;
  const AllApprovedLoans({
    Key? key,
    required this.bankId,
    required this.vendorPhone,
  }) : super(key: key);

  @override
  State<AllApprovedLoans> createState() => _AllApprovedLoansState();
}

class _AllApprovedLoansState extends State<AllApprovedLoans> {
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
            "All Approved Loans",
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
                future:
                    getAllLoan(widget.bankId.toString(), widget.vendorPhone),
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
                          return Card(
                            clipBehavior: Clip.hardEdge,
                            elevation: 8.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 90.0,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
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
                                              "${snapshot.data[index].interestRate}%",
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
