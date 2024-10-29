import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late File? _image = null;
  String? _selectedDocumentType;
  final picker = ImagePicker();
  final TextEditingController _documentNumberController =
      TextEditingController();
  final TextEditingController _documentTypeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfilePicture(),
              const SizedBox(height: 20),
              _buildSpinnerWithEditText(),
              const SizedBox(height: 20),
              _buildCustomTextField('Nombre', _nameController),
              const SizedBox(height: 20),
              _buildCustomTextField('Correo', _emailController),
              const SizedBox(height: 20),
              _buildCustomTextField('Teléfono', _phoneController),
              const SizedBox(height: 20),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return GestureDetector(
      onTap: () {
        _showImagePicker(context);
      },
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey[200],
        child: _image != null
            ? ClipOval(
                child: Image.file(
                  _image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(Icons.camera_alt, size: 40),
      ),
    );
  }

  Future<void> _showImagePicker(BuildContext context) async {
    final action = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccione el medio'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: const Text('Cámara'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              child: const Text('Galería'),
            ),
          ],
        );
      },
    );

    if (action != null) {
      final pickedFile = await picker.pickImage(
        source: action,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

  Widget _buildCustomTextField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSpinnerWithEditText() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: DropdownButton<String>(
            value: _selectedDocumentType,
            underline:
                Container(), // Para eliminar la línea de abajo del DropdownButton
            items: ['Tipo', 'CC', 'CE', 'PAS', 'OTRO'].map((String value) {
              return DropdownMenuItem<String>(
                value: value == 'Tipo' ? null : value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _selectedDocumentType = value;
              });
              if (value != null && value != 'Tipo') {
                _documentTypeController.text = value;
              } else {
                _documentTypeController
                    .clear(); // Limpiar el texto si selecciona el hint
              }
            },
            hint: const Text('Tipo'),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: TextField(
            controller: _documentNumberController,
            decoration: const InputDecoration(
              labelText: 'Número de documento',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle registration process
      },
      child: const Text('Registrarse'),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: RegisterPage(),
  ));
}
