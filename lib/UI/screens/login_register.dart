// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:wajed_delivery/UI/navigationPage.dart';
// import 'package:wajed_delivery/UI/widgets/BlockButtonWidget.dart';
// import 'package:wajed_delivery/models/user.dart';
// import 'package:wajed_delivery/shared_data.dart';
// import 'package:http/http.dart' as http;
// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }
// class _LoginState extends State<Login> {
//   String title = 'الدخول إلي حسابك';
//   bool isRegister = false;
//  GlobalKey<FormState> _formKey = new GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: 300,
//               color: firstColor,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // ClipRRect(
//                   //   borderRadius: BorderRadius.circular(20),
//                   //   child: Image.asset(
//                   //     'assets/img/logo.png',
//                   //     height: 120,
//                   //     width: 120,
//                   //     fit: BoxFit.fill,
//                   //   ),
//                   // ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     'Wajed Delivery',
//                     style: TextStyle(
//                         fontSize: 22,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     title,
//                     style: TextStyle(
//                         fontSize: 22,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               height: 60,
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           isRegister = false;
//                           title = 'الدخول إلي حسابك';
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             'تسجيل الدخول',
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 color: isRegister
//                                     ? firstColor.withOpacity(0.7)
//                                     : firstColor,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             height: 2,
//                             margin: EdgeInsets.symmetric(
//                                 vertical: 3, horizontal: 15),
//                             width: double.infinity,
//                             color: isRegister ? Colors.white : firstColor,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           isRegister = true;
//                           title = 'إنشاء حساب جديد';
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             'إنشاء حساب',
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 color:
//                                     !isRegister ? Colors.black45 : firstColor,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             height: 1,
//                             margin: EdgeInsets.symmetric(
//                                 vertical: 3, horizontal: 15),
//                             width: double.infinity,
//                             color: !isRegister ? Colors.white : firstColor,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             !isRegister ? buildLoginForm() : buildRegisterForm()
//           ],
//         ),
//       ),
//     );
//   }
//
//   String loginEmail;
//   String loginPass;
//   bool loginHidePass = true;
//   final Map<String, dynamic> loginformData = {};
//
//   buildLoginForm() {
//     return Container(
//       padding: EdgeInsets.only(left: 20, right: 20, top: 50),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               keyboardType: TextInputType.number,
//               onChanged: (input) => loginformData['email'] = input,
//               validator: (input) =>
//                   (!input.startsWith('05') || input.length != 10)
//                       ? 'بريد الكتروني غير صالح'
//                       : null,
//               decoration: InputDecoration(
//                 labelText: "رقم الهاتف",
//                 labelStyle: TextStyle(color: Colors.grey),
//                 contentPadding: EdgeInsets.all(20),
//                 hintText: '05xxxxxxxx',
//                 hintStyle: TextStyle(
//                     color: Theme.of(context).focusColor.withOpacity(0.7)),
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Icon(Icons.phone_android, color: firstColor),
//                 ),
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Theme.of(context).focusColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10)),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: firstColor),
//                     borderRadius: BorderRadius.circular(10)),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Theme.of(context).focusColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 30),
//             TextFormField(
//               keyboardType: TextInputType.text,
//               onChanged: (input) => loginformData['password'] = input,
//               validator: (input) => input.length < 3
//                   ? 'كلمة المرور يجب ان تكون اكبر من 3 عناصر'
//                   : null,
//               obscureText: loginHidePass,
//               decoration: InputDecoration(
//                 labelText: "كلمة المرور",
//                 labelStyle: TextStyle(color: Colors.grey),
//                 contentPadding: EdgeInsets.all(20),
//                 hintText: '••••••••••••',
//                 hintStyle: TextStyle(
//                     color: Theme.of(context).focusColor.withOpacity(0.7)),
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Icon(Icons.lock_outline, color: firstColor),
//                 ),
//                 suffixIcon: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         loginHidePass = !loginHidePass;
//                       });
//                     },
//                     color: Theme.of(context).focusColor,
//                     icon: Icon(loginHidePass
//                         ? Icons.visibility
//                         : Icons.visibility_off),
//                   ),
//                 ),
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Theme.of(context).focusColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10)),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: firstColor),
//                     borderRadius: BorderRadius.circular(10)),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Theme.of(context).focusColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 30),
//             Container(
//               width: double.infinity,
//               color: Colors.white,
//               child: BlockButtonWidget(
//                 text: Text(
//                   "دخول",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 color: firstColor,
//                 onPressed: () {
//                   loginRegister(loginformData, isRegister);
//                 },
//               ),
//             ),
//             SizedBox(height: 15),
//             FlatButton(
//               onPressed: () {
//                 Navigator.of(context)
//                     .pushReplacementNamed('/Pages', arguments: 0);
//               },
//               shape: StadiumBorder(),
//               textColor: Theme.of(context).hintColor,
//               // child: Text("تخطي"),
//               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
//             ),
// //                      SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
//
//   final Map<String, dynamic> registerFormData = {};
//
//   buildRegisterForm() {
//     return Container(
//       padding: EdgeInsets.only(left: 20, right: 20, top: 50),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               keyboardType: TextInputType.text,
//               onSaved: (input) => registerFormData['name'] = input,
//               validator: (input) =>
//                   input.length < 3 ? "الاسم يجب ان يكون اكبر من 3 عناصر" : null,
//               decoration: InputDecoration(
//                 labelText: 'الاسم بالكامل',
//                 labelStyle: TextStyle(color: Colors.grey),
//                 contentPadding: EdgeInsets.all(20),
//                 hintText: "احمد علي",
//                 hintStyle: TextStyle(
//                     color: Theme.of(context).focusColor.withOpacity(0.7)),
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Icon(Icons.person_outline, color: firstColor),
//                 ),
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Theme.of(context).focusColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10)),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: firstColor),
//                     borderRadius: BorderRadius.circular(10)),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Theme.of(context).focusColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 30),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               onSaved: (input) => registerFormData['email'] = input,
//               decoration: InputDecoration(
//                 labelText: "رقم الهاتف",
//                 labelStyle: TextStyle(color: Colors.grey),
//                 focusColor: firstColor,
//                 contentPadding: EdgeInsets.all(20),
//                 hintText: '05xxxxxxxx',
//                 hintStyle: TextStyle(
//                     color: Theme.of(context).focusColor.withOpacity(0.7)),
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Icon(Icons.phone_android, color: firstColor),
//                 ),
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Theme.of(context).focusColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10)),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: firstColor),
//                     borderRadius: BorderRadius.circular(10)),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Theme.of(context).focusColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 30),
//             TextFormField(
//               obscureText: loginHidePass,
//               onSaved: (input) => registerFormData['password'] = input,
//               validator: (input) => input.length < 6
//                   ? "كلمة السر يجب ان تكون اكبر من ستة عناصر"
//                   : null,
//               decoration: InputDecoration(
//                 labelText: "كلمة المرور",
//                 labelStyle: TextStyle(color: Colors.grey),
//                 contentPadding: EdgeInsets.all(20),
//                 hintText: '••••••••••••',
//                 hintStyle: TextStyle(
//                     color: Theme.of(context).focusColor.withOpacity(0.7)),
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Icon(Icons.lock_outline, color: firstColor),
//                 ),
//                 suffixIcon: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         loginHidePass = !loginHidePass;
//                       });
//                     },
//                     color: Theme.of(context).focusColor,
//                     icon: Icon(loginHidePass
//                         ? Icons.visibility
//                         : Icons.visibility_off),
//                   ),
//                 ),
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Theme.of(context).focusColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10)),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: firstColor),
//                     borderRadius: BorderRadius.circular(10)),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Theme.of(context).focusColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 30),
//             buildPrivacyView(),
//             SizedBox(height: 30),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               child: BlockButtonWidget(
//                 text: Text(
//                   "إنشاء الحساب",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 color: firstColor,
//                 onPressed: () {
//                   _formKey.currentState.save();
//                   loginRegister(registerFormData, isRegister);
//                 },
//               ),
//             ),
//             SizedBox(height: 25),
//           ],
//         ),
//       ),
//     );
//   }
//
//   bool isloading = false;
//
//   loginRegister(Map<String, dynamic> params, isRegister) async {
//
//     params['device_token'] = 'and';
//     setState(() {
//       isloading = true;
//     });
//     print(params);
//     String endpoint = isRegister ? "api/driver/register" : "api/driver/login";
//     isRegister ? print("") : params.remove("name");
//     try {
//       final Uri url = Uri.parse("$baseUrl$endpoint");
//       final response = await http.post(
//         url,
//         body: params,
//       );
//       print("response : ${response.body}");
//       final jsonData = json.decode(response.body) as Map<String, dynamic>;
//       user = User.fromJSON(jsonData['data']);
//       saveToken();
//       if(response.statusCode==200){
//         navigateTo(page: NavigationPage(),context: context);
//       }
//       setState(() {
//         isloading = false;
//       });
//     } catch (error) {
//       isRegister
//           ? showSnackBar("رقم الهاتف الذي أدخلته مسجل من قبل", context)
//           : showSnackBar(
//               "رقم الهاتف او كلمة السر غير صحيحة , الرجاء التأكد والمحاولة مجددا",
//               context);
//       setState(() {
//         isloading = false;
//       });
//     }
//   }
// }
//
// bool isSelected = false;
//
// class buildPrivacyView extends StatefulWidget {
//   @override
//   _buildPrivacyViewState createState() => _buildPrivacyViewState();
// }
//
// class _buildPrivacyViewState extends State<buildPrivacyView> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         InkWell(
//           onTap: () {
//             setState(() {
//               isSelected = !isSelected;
//             });
//           },
//           child: Icon(
//             isSelected ? Icons.check_box : Icons.check_box_outline_blank,
//             size: 25,
//             color: isSelected ? Colors.black : Colors.black45,
//           ),
//         ),
//         SizedBox(
//           width: 20,
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.of(context).pushNamed('/privacy');
//           },
//           child: Text('أوافق علي سياسة الخصوصية وشروط الإستخدام',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 15,
//                   decoration: TextDecoration.underline)),
//         ),
//       ],
//     );
//   }
// }
