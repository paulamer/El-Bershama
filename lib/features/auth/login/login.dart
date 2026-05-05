import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:el_bershama/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late TextEditingController emailController;
  late TextEditingController passwordController;
   @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorsManger.withColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    
                Image.asset('images/part bershama.png',width: 120,),
                Text('تسجيل الدخول',style: StylesManger.black50Bold,),
                SizedBox(height:50),
                CustomTextField(hint: 'البريد الالكتروني ', icon:Icons.email,),
                CustomTextField(hint: 'كلمه المرور ', icon:Icons.lock,isPassword: true,),
                SizedBox(height:20),
                ButtonWidget(onpress: (){
                  Navigator.pushReplacementNamed(context, 'Home');
                },
                 text: "تسجيل الدخول"),
                 SizedBox(height:20),
                 Text('______________ أو ________________'),
                 SizedBox(height:20),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, 'singUp');
                    }, 
                    child: Text('انشاء حساب',style: StylesManger.titleText20Style,)),
                     Text('ليس لديك حساب ؟ ',style: StylesManger.titleText20Style,),
                    
                  ],
                    
                 )
                
              ],
              
            ),
          ),
        ),
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
   final String hint;
  final IconData icon;
  final bool isPassword;
  

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
  });
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: TextEditingController(),
        textDirection: TextDirection.rtl, 
         textAlign: TextAlign.right,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
       );
  }
}

