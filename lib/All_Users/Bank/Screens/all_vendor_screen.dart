import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../services/api_calling.dart';

class AllVendors extends StatefulWidget {
  const AllVendors({Key? key}) : super(key: key);

  @override
  State<AllVendors> createState() => _AllVendorsState();
}

class _AllVendorsState extends State<AllVendors> {
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
            "All Vendors",
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FutureBuilder(
              future: fetchAllVendors(),
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
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 120.0,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage: NetworkImage(
                                      "${snapshot.data[index].image}"),
                                ),
                                const SizedBox(width: 12.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data[index].vendorName!
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18.0, color: mainColor),
                                    ),
                                    Row(
                                      children: [
                                        const Text("Shop Name : "),
                                        Text(
                                          "${snapshot.data[index].shopName}",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: mainColor),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Phone Number : "),
                                        Text(
                                          "${snapshot.data[index].phoneNumber}",
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Total Debit Amount : "),
                                        Text(
                                          "${snapshot.data[index].totalDebit}",
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Total Loan Amount : "),
                                        Text(
                                          "${snapshot.data[index].totalLoanAmount}",
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
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
    );
  }
}
