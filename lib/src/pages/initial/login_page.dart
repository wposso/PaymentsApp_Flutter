import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:paymentsapp/src/provider/user_provider.dart';
import 'package:paymentsapp/src/utils/custom_snackbar.dart';
import 'package:provider/provider.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() {
  configureAuthPersistence();
  runApp(const LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  late TextEditingController digit1Controller;
  late TextEditingController digit2Controller;
  late TextEditingController digit3Controller;
  late TextEditingController digit4Controller;

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  @override
  void initState() {
    super.initState();
    digit1Controller = TextEditingController();
    digit2Controller = TextEditingController();
    digit3Controller = TextEditingController();
    digit4Controller = TextEditingController();
  }

  @override
  void dispose() {
    digit1Controller.dispose();
    digit2Controller.dispose();
    digit3Controller.dispose();
    digit4Controller.dispose();

    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/billetera.png',
              width: 100.0,
              height: 100.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Hola de nuevo',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Ingresa tu clave',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildNumberTextField(
                  label: '',
                  controller: digit1Controller,
                  focusNode: _focusNode1,
                  def: true,
                ),
                buildNumberTextField(
                  label: '',
                  controller: digit2Controller,
                  focusNode: _focusNode2,
                  def: false,
                ),
                buildNumberTextField(
                  label: '',
                  controller: digit3Controller,
                  focusNode: _focusNode3,
                  def: false,
                ),
                buildNumberTextField(
                  label: '',
                  controller: digit4Controller,
                  focusNode: _focusNode4,
                  def: false,
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                String code =
                    '${digit1Controller.text}${digit2Controller.text}${digit3Controller.text}${digit4Controller.text}57';
                _signIn(context, code);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorPrimario,
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'reset');
              },
              child: const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  color: colorPrimario,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Aún no tengo una cuenta | ',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: colorPrimario,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNumberTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool def,
  }) {
    return SizedBox(
      width: 50.0,
      child: TextField(
        //maxLength: 1,
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        autofocus: def,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        textAlign: TextAlign.center,
        obscureText: true,
        cursorColor: colorPrimario,
        decoration: const InputDecoration(
          //labelText: label,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorPrimario),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  void _signIn(BuildContext context, String code) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "felmont68@hotmail.com",
        password: code,
      );
      User? user = userCredential.user;
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '¡Sesión iniciada con éxito!',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3),
          backgroundColor: colorPrimario,
        ),
      );
      Navigator.pushNamed(context, 'home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Usuario y/o contraseña incorrectos",
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 5),
          backgroundColor: colorSkin3,
        ),
      );
    }
  }
}

void configureAuthPersistence() {
  FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
}


/* 
void _signUp() async {
  String email = _emailController.text;
  String pin = _pinController.text;

  User? user = await auth.signUp(email, pin);

  if (user != null) {
    print("User create sucessfull");
    //ir a login
  } else {
    print("User can't be create");
  }
}

para salir solo es agregar esto en ontap 
// FirebaseAuth.instance.signOut();
//navegar al login o cerrar app
*/