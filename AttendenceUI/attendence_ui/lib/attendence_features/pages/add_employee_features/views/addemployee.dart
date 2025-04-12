import 'dart:io';
import 'dart:math';

import 'package:attendence_ui/attendence_features/models/employee.dart';
import 'package:attendence_ui/attendence_features/pages/employee_list_features/provider/employee_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Colors/colors.dart';
import '../provider/add_employee_provider.dart';
import 'face_detection_screen.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  String? alreadyregisteruserName;

  bool _isProcessing = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AddEmployeeProvider>(context,listen: false);
    provider.employeeIdController.text = generateRandomEmployeeId();
  }
  Future<String> getDeviceId() async
  {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if(Platform.isAndroid)
      {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
        return androidDeviceInfo.id;
      }else if(Platform.isIOS)
        {
          IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
          return iosDeviceInfo.identifierForVendor ?? "ios device id not found";
        }
    else
      {
        return 'Unknown Device';
      }


  }

  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
  }
  String get_formattedDate()
  {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
  }
  String get_formattedTime()
  {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh:mm a').format(now);
    return formattedTime;
  }

  Future<void> _registerUser(
    AddEmployeeProvider addemployeeProvider,
    BuildContext context,
  ) async {
    if (!_formKey.currentState!.validate() ||
        addemployeeProvider.image == null) {
      showToast("⚠️ Please fill up all the fields");
      return;
    }

    setState(() => _isProcessing = true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    await Future.delayed(Duration(seconds: 2));

    try {

      final employeeprovider = Provider.of<EmployeeProvider>(
        context,
        listen: false,
      );
      if (await employeeprovider.emailExists(
        addemployeeProvider.emailController.text,
      )) {
        Navigator.pop(context); // Close loading dialog
        showToast("Email already registered!");

        setState(() => _isProcessing = false);
        return;
      }

      final embedding = await addemployeeProvider.getEmbedding();

      Uint8List? byteimage = await addemployeeProvider.ImagetoByteImage();
      alreadyregisteruserName = (await addemployeeProvider
          .checkFaceAlreadyRegisterOrNot(embedding));
      if (alreadyregisteruserName != null) {
        Navigator.pop(context);
        showToast(
          'This face is already registered here.named:$alreadyregisteruserName',
        );
        return;
      }
      String dId = await getDeviceId();

      final Employee employee = Employee(
        name: addemployeeProvider.nameController.text,
        employeeId: addemployeeProvider.employeeIdController.text,
        designation: addemployeeProvider.designation,
        address: addemployeeProvider.addressController.text,
        email: addemployeeProvider.emailController.text.toLowerCase(),
        contactNumber: addemployeeProvider.contactController.text,
        deviceId: dId,
        salary: double.parse(addemployeeProvider.salaryController.text),
        overtimeRate: double.parse(
          addemployeeProvider.overtimeRateController.text,
        ),
        startDate: get_formattedDate(),
        startTime: get_formattedTime(),
        embedding: embedding,
        imageFile: byteimage!,
      );

      //insert user
      employeeprovider.insertUser(employee);

      // Close loading dialog

      Navigator.pop(context);


      showSuccessPopup(context);

      addemployeeProvider.clearFields();
      hideKeyboard(context);
    } catch (e) {
      Navigator.pop(context);
      showToast("Registration failed: ${e.toString()}");
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  void showSuccessPopup(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 10),
          Text("Employee added successfully!"),
        ],
      ),
      backgroundColor: Color(0xFF004368),
      // Primary color
      duration: Duration(seconds: 2),
      // Auto-dismiss after 2 seconds
      behavior: SnackBarBehavior.floating,
      // Floating style
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
  String generateRandomEmployeeId() {
    final random = Random();
    // Generate a random number (you can adjust the range as per your requirement)
    int randomNumber = random.nextInt(10000)+1111; // Random number up to 999999
    return "${randomNumber.toString().padLeft(5, '0')}"; // Format it with "TG-" and a 6-digit number
  }

  void showWarningToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEmployeeProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Add Employee',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 20.sp,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final imgFile = await Navigator.push<File?>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FaceDetectionScreen(),
                        ),
                      );
                      if (imgFile != null) {
                        final embedding = await provider.getEmbeddingfromfile(
                          imgFile,
                        );
                        String? name = (await provider
                            .checkFaceAlreadyRegisterOrNot(embedding));
                        if (name != null) {
                          provider.pickImage(null);
                          showWarningToast(
                            'Hey $name you are already registered',
                          );
                        } else {
                          provider.pickImage(imgFile);
                        }
                      }
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 158.w,
                          height: 158.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.w,
                              color: Cl.primaryColor,
                            ),
                            shape: BoxShape.circle,
                            image:
                                provider.image != null
                                    ? DecorationImage(
                                      image: FileImage(provider.image!),
                                      fit: BoxFit.cover,
                                    )
                                    : null,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Cl.primaryColor.withOpacity(0.6),
                              ],
                              stops: [0.75, 1.0],
                            ),
                          ),
                          child: Center(
                            child:
                                provider.image == null
                                    ? Icon(
                                      Icons.person,
                                      color: Colors.blue.shade900,
                                      size: 100.sp,
                                    )
                                    : null,
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 30,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildTextField(
                    "Full Name",
                    provider.nameController,
                    TextInputType.text,
                  ),
                  buildTextField(
                    "Employee ID",
                    provider.employeeIdController,
                    TextInputType.number,
                    prefix: "TG-",
                  ),
                  DesignationDropdown(provider,"Designation"),
                  buildTextField(
                    "Address",
                    provider.addressController,
                    TextInputType.streetAddress,
                  ),
                  buildTextField(
                    "Email Address",
                    provider.emailController,
                    TextInputType.emailAddress,
                  ),
                  buildTextField(
                    "Contact Number",
                    provider.contactController,
                    TextInputType.number,
                  ),
                  buildTextField(
                    "Salary",
                    provider.salaryController,
                    TextInputType.number,
                  ),
                  buildTextField(
                    "Overtime Rate",
                    provider.overtimeRateController,
                    TextInputType.number,
                    hintText: "e.g., 15.50",
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton.icon(
                      onPressed:
                          _isProcessing
                              ? null
                              : () async {
                                await _registerUser(provider, context);
                              },
                      icon: SvgPicture.asset(
                        "assets/icons/button_icon.svg",
                        width: 20.w,
                        height: 20.h,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: Text(
                        "Save Employee",
                        style: TextStyle(fontSize: 15.sp, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004368),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.w),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller,
    TextInputType textInputType, {
    String? prefix,
        String? hintText
  }) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Cl.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: textInputType,
            decoration: InputDecoration(
              hintText: hintText ?? label,
              prefixText: prefix,
              floatingLabelBehavior: FloatingLabelBehavior.never,

              labelStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.black.withOpacity(0.6),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 9,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Color(0x66004368)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide:  BorderSide(color: Cl.primaryColor),
              ),
            ),
            validator: (value) => validateInput(value, "required"),
          ),
        ],
      ),
    );
  }

  String? validateInput(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null; // Validation successful
  }
  Widget DesignationDropdown(AddEmployeeProvider addemployeeProvider,String label)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Cl.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,

            labelStyle: TextStyle(
              fontSize: 12.sp,
              color: Colors.black.withOpacity(0.6),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 9,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0x66004368)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
          value: addemployeeProvider.designation,
          onChanged: (value) {
            addemployeeProvider.set_designation(value!);
          },
          items: addemployeeProvider.designations.map((designation) {
            return DropdownMenuItem<String>(
              value: designation,
              child: Text(designation),
            );
          }).toList(),
          validator: (value) =>
          value == null ? 'Please select a designation' : null,
        ),
      ],
    );
  }
}
