import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/bank_spring_boot_model.dart';
import '../../../services/api_calling.dart';

class ViewBankProfile extends StatefulWidget {
  final String phone;
  const ViewBankProfile({Key? key, required this.phone}) : super(key: key);

  @override
  State<ViewBankProfile> createState() => _ViewBankProfileState();
}

class _ViewBankProfileState extends State<ViewBankProfile> {
  late String phone;
  late Future<BankSpringBootModel> bank;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    setState(() {
      bank = fetchParticularBank(phone);
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
            "Bank Profile",
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: FutureBuilder(
                  future: bank,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage("${snapshot.data!.image}"),
                              radius: 120,
                            ),
                            const SizedBox(height: 15.0),
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
                                        snapshot.data!.bankName!.toUpperCase(),
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
                                        "Address : ",
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
                            SizedBox(height: 5.0),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
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
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
