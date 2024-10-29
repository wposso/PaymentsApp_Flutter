
import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';

import '../widgets/background_app.dart';
// import 'package:web/helpers.dart';

class ContactSupport extends StatefulWidget {
  const ContactSupport({super.key});

  @override
  State<ContactSupport> createState() => _ContactSupportState();
}

class _ContactSupportState extends State<ContactSupport> {

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController message = TextEditingController();
  bool errorname = false;
  bool erroremail = false;
  bool errormessage = false;
  String activemessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCirculo,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: colorPrimario,
        foregroundColor: colorTextoBlanco,
        title: const Text('Contactar soporte'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 570,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
              topRight: Radius.circular(10)),
              color: colorTextoBlanco
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
              child: Column(
                children: [
                  const Text(
                    'Completa el siguiente formulario para ponerte en contacto con nuestro equipo de soporte. Nos pondremos en contacto contigo a la mayor brevedad posible.',
                    textAlign: TextAlign.center,),
                  const SizedBox(height: 40,),
                  TextFormField(
                    onChanged: (value) {
                      onChangedFields();
                    },
                    controller: name,
                    decoration: InputDecoration(
                      label: const Text('Nombre'),
                      border: const OutlineInputBorder(),
                      errorText: errorname ? activemessage : null,
                      errorStyle: const TextStyle(fontSize: 1),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorDenied
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    onChanged: (value) {
                      onChangedFields();
                    },
                    controller: email,
                    decoration: InputDecoration(
                      label: const Text('Correo electrónico'),
                      border: const OutlineInputBorder(),
                      errorText: erroremail ? activemessage : null,
                      errorStyle: const TextStyle(fontSize: 1),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorDenied
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    onChanged: (value) {
                      onChangedFields();
                    },
                    controller: message,
                    maxLines: 5,
                    decoration: InputDecoration(
                      label: const Text('Escribe tu mensaje'),
                      alignLabelWithHint: true,
                      border: const OutlineInputBorder(),
                      errorText: errormessage ? activemessage : null,
                      errorStyle: const TextStyle(fontSize: 1),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorDenied
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 60,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      fixedSize: const Size(250, 45),
                      backgroundColor: colorPrimario,
                      foregroundColor: colorTextoBlanco
                    ),
                    onPressed: (){
                      sendSupport(context, name.text, email.text, message.text);
                    }, 
                    child: const Text('Enviar')),
                ],
              ),),
          )
        ],
      ),
    );
  }
  void sendSupport(
    BuildContext context, String name, String email, String message){
      if(name.isEmpty && email.isEmpty && message.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorDenied,
          duration: Duration(seconds: 3),
          content: Text(
            'Hay campos requeridos vacios', 
            style: TextStyle(color: colorTextoBlanco), 
            textAlign: TextAlign.center,)));
            setState(() {
              errorname = true;
              erroremail = true;
              errormessage = true;
            });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorPrimario,
          duration: Duration(seconds: 3),
          content: Text(
            'Mensaje enviado correctamente', 
            style: TextStyle(color: colorTextoBlanco), 
            textAlign: TextAlign.center,)));
            setState(() {
              errorname = false;
              erroremail = false;
              errormessage = false;
            });
      }
      clearControllers();
    }
  void clearControllers(){
      name.clear(); email.clear();message.clear();
  }
  void onChangedFields(){
    if(erroremail == true && errormessage == true && errorname == true){
      setState(() {
        erroremail = false; errormessage = false; errorname = false;  
      });
    }
  }
}