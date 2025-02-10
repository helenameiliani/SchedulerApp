import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = _dateFormat.format(picked);
      });
    }
  }

  String? validatePassword(String password) {
    if (password.length < 8) {
      return "Password harus minimal 8 karakter";
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$').hasMatch(password)) {
      return "Password harus mengandung huruf besar, huruf kecil, dan angka";
    }
    return null;
  }

  Future<void> signUp() async {
    String? passwordError = validatePassword(_passwordController.text.trim());
    if (passwordError != null) {
      showMessage(passwordError);
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print("User signed up: ${userCredential.user?.email}");

      showMessage("Sign up successful!", success: true, navigateToLogin: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showMessage("Email sudah terdaftar. Gunakan email lain.");
      } else if (e.code == 'invalid-email') {
        showMessage("Format email tidak valid.");
      } else if (e.code == 'weak-password') {
        showMessage("Password terlalu lemah.");
      } else {
        showMessage("Terjadi kesalahan: ${e.message}");
      }
    } catch (e) {
      showMessage("Terjadi kesalahan: ${e.toString()}");
    }
  }

  void showMessage(String message,
      {bool success = false, bool navigateToLogin = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(success ? "Success" : "Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (navigateToLogin) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(IconData icon, String hintText,
      {bool obscureText = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.redAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFFFA6C61),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'image/signup_image.png',
                          height: 150,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already registered? ",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  buildTextField(Icons.person, "Name",
                      controller: _nameController),
                  SizedBox(height: 15),
                  buildTextField(Icons.email, "Email",
                      controller: _emailController),
                  SizedBox(height: 15),
                  buildTextField(Icons.lock, "Password",
                      obscureText: true, controller: _passwordController),
                  SizedBox(height: 15),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Date of Birth",
                      prefixIcon:
                          Icon(Icons.calendar_today, color: Colors.redAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: signUp,
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
