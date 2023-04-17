import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../Constant/const_variable.dart';
import '../../../Models/bank_spring_boot_model.dart';
import '../../../Modules/visibility_model.dart';
import '../../../services/api_calling.dart';
import '../../../utils/utils.dart';
import 'bank_dashboard.dart';

class UpdateBankProfile extends StatefulWidget {
  final String phone;
  const UpdateBankProfile({Key? key, required this.phone}) : super(key: key);

  @override
  State<UpdateBankProfile> createState() => _UpdateBankProfileState();
}

class _UpdateBankProfileState extends State<UpdateBankProfile> {
  File? image;

  late Future<BankSpringBootModel> bank;
  late String phone;
  late String imageUrl;

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankBranchController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool validBanKName = true;
  bool validBankBranch = true;
  bool validAddress = true;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    setState(() {
      bank = fetchParticularBank(phone);
    });
    bank.then(
      (value) => {
        _bankNameController.text = value.bankName!,
        _bankBranchController.text = value.bankBranch!,
        _addressController.text = value.bankAddress!,
        imageUrl = value.image!,
      },
    );
  }

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
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
            "Update Profile",
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: ChangeNotifierProvider<VisibilityModel>(
          create: (context) => VisibilityModel(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder(
                future: bank,
                builder: (builder, snapshot) {
                  if (snapshot.hasData) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => selectImage(),
                            child: image == null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(imageUrl),
                                    radius: 100,
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(image!),
                                    radius: 100,
                                  ),
                          ),
                          const SizedBox(height: 10),
                          Consumer<VisibilityModel>(
                            builder: (context, myModel, child) {
                              return TextField(
                                onChanged: (val) => {
                                  myModel.changeUsernameValidation(val),
                                  if (myModel.isUsernameValid)
                                    {
                                      validBanKName = true,
                                    }
                                  else
                                    {
                                      validBanKName = false,
                                    }
                                },
                                controller: _bankNameController,
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
                                      color: myModel.isUsernameValid
                                          ? mainColor
                                          : Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                  hintText: "Bank Name",
                                  label: Text(
                                    "Bank Name",
                                    style: TextStyle(
                                      color: mainColor,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    CupertinoIcons.person,
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15.0),
                          Consumer<VisibilityModel>(
                            builder: (context, myModel, child) {
                              return TextField(
                                onChanged: (val) => {
                                  myModel.changeUsernameValidation(val),
                                  if (myModel.isUsernameValid)
                                    {
                                      validBankBranch = true,
                                    }
                                  else
                                    {
                                      validBankBranch = false,
                                    }
                                },
                                controller: _bankBranchController,
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
                                      color: myModel.isUsernameValid
                                          ? mainColor
                                          : Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                  hintText: "Bank Branch",
                                  label: Text(
                                    "Bank Branch",
                                    style: TextStyle(
                                      color: mainColor,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    CupertinoIcons.location_circle,
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15.0),
                          Consumer<VisibilityModel>(
                            builder: (context, myModel, child) {
                              return TextField(
                                onChanged: (val) => {
                                  myModel.changeAddressValidation(val),
                                  if (myModel.isAddressValid)
                                    {
                                      validAddress = true,
                                    }
                                  else
                                    {
                                      validAddress = false,
                                    }
                                },
                                controller: _addressController,
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
                                      color: myModel.isAddressValid
                                          ? mainColor
                                          : Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                  hintText: "Bank Address",
                                  label: Text(
                                    "Bank Address",
                                    style: TextStyle(
                                      color: mainColor,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    CupertinoIcons.location_solid,
                                    color: mainColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15.0),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.065,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromRGBO(63, 72, 204, 1))),
                              child: const Text(
                                "UPDATE PROFILE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              onPressed: () async {
                                if (validBankBranch &&
                                    validBanKName &&
                                    validAddress) {
                                  if (image == null) {
                                    updateBankProfile(
                                      phone,
                                      snapshot.data!.image,
                                      _bankNameController.text.trim(),
                                      _bankBranchController.text.trim(),
                                      _addressController.text.trim(),
                                      snapshot.data!.bankId,
                                    ).whenComplete(() => {
                                          AwesomeDialog(
                                            context: context,
                                            headerAnimationLoop: true,
                                            animType: AnimType.scale,
                                            btnCancelColor: mainColor,
                                            dialogType: DialogType.success,
                                            btnOkOnPress: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BankDashBoard(),
                                                ),
                                              );
                                            },
                                            btnOkColor: mainColor,
                                            title: 'Success',
                                            desc:
                                                'Profile Updated Successfully 😊',
                                          ).show(),
                                        });
                                  } else {
                                    storeUserFileToStorage(
                                            "profilePic/banks/${snapshot.data!.bankName}",
                                            image)
                                        .then((value) => {
                                              updateBankProfile(
                                                phone,
                                                value,
                                                _bankNameController.text.trim(),
                                                _bankBranchController.text
                                                    .trim(),
                                                _addressController.text.trim(),
                                                snapshot.data!.bankId,
                                              ).whenComplete(() => {
                                                    AwesomeDialog(
                                                      context: context,
                                                      headerAnimationLoop: true,
                                                      animType: AnimType.scale,
                                                      btnCancelColor: mainColor,
                                                      dialogType:
                                                          DialogType.success,
                                                      btnOkOnPress: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const BankDashBoard(),
                                                          ),
                                                        );
                                                      },
                                                      btnOkColor: mainColor,
                                                      title: 'Success',
                                                      desc:
                                                          'Profile Updated Successfully 😊',
                                                    ).show(),
                                                  }),
                                            });
                                  }
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    headerAnimationLoop: true,
                                    animType: AnimType.scale,
                                    btnCancelColor: mainColor,
                                    dialogType: DialogType.error,
                                    btnCancelOnPress: () {},
                                    title: 'Invalid Details',
                                    desc: 'Please, enter valid details',
                                  ).show();
                                }
                              },
                            ),
                          ),
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

  Future<BankSpringBootModel> updateBankProfile(
    String phone,
    String? image,
    String bankName,
    String bankBranch,
    String address,
    int? bankId,
  ) async {
    final response = await http.put(
      Uri.https(baseUrl, "/bank/updateBank"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'bankName': bankName,
        'phoneNumber': phone,
        'bankBranch': bankBranch,
        'bankAddress': address,
        'image': image,
        'bankId': bankId
      }),
    );

    if (response.statusCode == 200) {
      return BankSpringBootModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update vendor password.');
    }
  }

  Future<String> storeUserFileToStorage(String ref, File? file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
