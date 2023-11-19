import 'package:flutter/material.dart';

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: text,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(width: 0, style: BorderStyle.none))),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container reusableButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? "LOG IN" : "SIGN UP",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.orangeAccent;
            }
            return Colors.deepPurpleAccent;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Row signUpOption(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Don't have an account? "),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/signup_screen");
        },
        child: Text(
          "Sign Up",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
        ),
      )
    ],
  );
}

Row divLine() {
  return Row(
    children: [
      Expanded(
        child: Divider(
          thickness: 0.5,
          color: Colors.grey[400],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Or continue with'),
      ),
      Expanded(
        child: Divider(
          thickness: 0.5,
          color: Colors.grey[400],
        ),
      ),
    ],
  );
}

Widget socialLogin(String imgPath, Function onClicked) {
  return GestureDetector(
    onTap: (){onClicked();},
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation:2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          imgPath,
          width: 35,
        ),
      ),
    ),
  );
}


