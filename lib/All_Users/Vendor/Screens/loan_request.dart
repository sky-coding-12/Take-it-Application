import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/const_variable.dart';
import '../../../services/api_calling.dart';

class LoanRequest extends StatefulWidget {
  final int bankPhone;
  final String vendorPhone;
  const LoanRequest(
      {Key? key, required this.bankPhone, required this.vendorPhone})
      : super(key: key);

  @override
  State<LoanRequest> createState() => _LoanRequestState();
}

class _LoanRequestState extends State<LoanRequest> {
  late int bankPhone;
  late String vendorPhone;

  late TextEditingController _amountController;
  late TextEditingController _durationController;
  late TextEditingController _interestController;

  @override
  void initState() {
    super.initState();
    bankPhone = widget.bankPhone;
    vendorPhone = widget.vendorPhone;
    _amountController = TextEditingController();
    _durationController = TextEditingController();
    _interestController = TextEditingController();
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
            "Request for Loan",
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/loan_request.png"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(
                    height: 2.0,
                    color: Colors.black38,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "Enter Loan Details 💵",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) => {},
                    controller: _amountController,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 22.0,
                        vertical: 12.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: mainColor,
                          width: 1.5,
                        ),
                      ),
                      hintText: "Loan Amount",
                      prefixIcon: Icon(
                        CupertinoIcons.money_dollar,
                        color: mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) => {},
                    controller: _interestController,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 22.0,
                        vertical: 12.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: mainColor,
                          width: 1.5,
                        ),
                      ),
                      hintText: "Loan Interest",
                      prefixIcon: Icon(
                        CupertinoIcons.percent,
                        color: mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) => {},
                    controller: _durationController,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 22.0,
                        vertical: 12.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: mainColor,
                          width: 1.5,
                        ),
                      ),
                      hintText: "Loan Duration",
                      prefixIcon: Icon(
                        CupertinoIcons.calendar,
                        color: mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(63, 72, 204, 1))),
                      child: const Text(
                        "REQUEST LOAN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      onPressed: () {
                        loanRequest(
                          bankPhone.toString(),
                          vendorPhone,
                          _amountController.text.trim(),
                          _interestController.text.trim(),
                          "Pending",
                          _durationController.text.trim(),
                        ).whenComplete(() => {
                              AwesomeDialog(
                                context: context,
                                headerAnimationLoop: true,
                                animType: AnimType.scale,
                                btnCancelColor: mainColor,
                                dialogType: DialogType.success,
                                btnOkOnPress: () {
                                  Navigator.pop(context);
                                },
                                btnOkColor: mainColor,
                                title: 'Success',
                                desc: 'Make Offer Successfully',
                              ).show(),
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
