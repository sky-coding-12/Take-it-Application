import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/RemainderModel.dart';
import '../../../services/api_calling.dart';

class AllRemainderScreen extends StatefulWidget {
  final String userPhone;
  final int vendorPhone;
  const AllRemainderScreen(
      {Key? key, required this.vendorPhone, required this.userPhone})
      : super(key: key);

  @override
  State<AllRemainderScreen> createState() => _AllRemainderScreenState();
}

class _AllRemainderScreenState extends State<AllRemainderScreen> {
  late int vendorPhone;
  late String userPhone;

  late Future<List<RemainderModel>> allRemainders;

  @override
  void initState() {
    super.initState();
    vendorPhone = widget.vendorPhone;
    userPhone = widget.userPhone;
    setState(() {
      allRemainders = getAllRemainders(vendorPhone.toString(), userPhone);
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
            "All Remainders",
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllRemainderScreen(
                              vendorPhone: vendorPhone,
                              userPhone: userPhone,
                            )));
              },
              icon: Icon(
                CupertinoIcons.refresh,
                size: 26.0,
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
            child: Align(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: allRemainders,
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
                                height: 120.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 10.0),
                                    Row(
                                      children: [
                                        Text(
                                          "Vendor Number : ",
                                          style: TextStyle(
                                              fontSize: 16.0, color: mainColor),
                                        ),
                                        Text(
                                          "${snapshot.data[index]!.vendorId}",
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Send Date : ",
                                          style: TextStyle(
                                              fontSize: 16.0, color: mainColor),
                                        ),
                                        Text(
                                          "${snapshot.data[index]!.sendTime}",
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${snapshot.data[index]!.message}",
                                      style: TextStyle(
                                        color: Colors.red.shade400,
                                        fontSize: 15.0,
                                      ),
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
