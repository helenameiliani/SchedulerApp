import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      showMessage("Login berhasil!", success: true, navigateToHome: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showMessage("Email belum terdaftar. Silakan signup terlebih dahulu.");
      } else if (e.code == 'wrong-password') {
        showMessage("Password yang Anda masukkan salah.");
      } else {
        showMessage("Terjadi kesalahan: ${e.message}");
      }
    } catch (e) {
      showMessage("Terjadi kesalahan. Silakan coba lagi.");
    }
  }

  void showMessage(String message,
      {bool success = false, bool navigateToHome = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(success ? "Sukses" : "Kesalahan"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (navigateToHome) {
                Navigator.pushReplacementNamed(context, '/home');
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('image/login_image.png', height: 150),
            SizedBox(height: 10),
            Text("Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            buildTextField(Icons.email, "Email", controller: _emailController),
            SizedBox(height: 15),
            buildTextField(Icons.lock, "Password",
                obscureText: true, controller: _passwordController),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: login,
              child: Text("Login", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/signup'),
                  child: Text("Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
