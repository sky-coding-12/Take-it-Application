import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/vendor_spring_boot_model.dart';
import '../../../services/api_calling.dart';

class QR_Code_Screen extends StatefulWidget {
  final String phone;
  const QR_Code_Screen({Key? key, required this.phone}) : super(key: key);

  @override
  State<QR_Code_Screen> createState() => _QR_Code_ScreenState();
}

class _QR_Code_ScreenState extends State<QR_Code_Screen> {
  late String phone;

  late Future<VendorSpringBootModel> vendor;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    setState(() {
      vendor = fetchParticularVendor(phone);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              color: mainColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "QR Code",
            style: TextStyle(
              color: mainColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            const Spacer(),
            FutureBuilder(
              future: vendor,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 1.25,
                    child: QrImage(
                      foregroundColor: mainColor,
                      data: "${snapshot.data!.phoneNumber}",
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator(
                  color: mainColor,
                );
              },
            ),
            const Spacer(),
            const Center(
              child: Text(
                "©2023 take_it 🗿 | all rights reserved",
                style: TextStyle(height: 5.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
