# paymentsapp

project for payments

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# para usar el app se necesita hacer un registro 

# 1. datos del usuario:
# uid / information

{
    docType: "cc",                  //requerido
    docNumber: "123456789",         //requerido
    name: "Usuario nuevo",          //requerido
    email: "user@mail.com",         //opcional
    phone: "1234567",               //opcional
    photo: "",                      //opcional
    status: true,                   //automatico
}


# 2. crear automaticamente la sgte tabla: 
# uid / finance

{
    balance: 0,                     //auto generado
    debts: 0,
    deposits: 0,
    expenses: 0,
    loans: 0,
    payments: 0
}

