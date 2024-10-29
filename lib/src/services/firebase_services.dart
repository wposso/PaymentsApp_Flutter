import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/data/models/Balance.dart';
import 'package:paymentsapp/src/data/models/Deposit.dart';
import 'package:paymentsapp/src/data/models/Loan.dart';
import 'package:paymentsapp/src/data/models/Person.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

late String uid;

/* ****************************************************************************/
/* ***************************** LOGIN **************************************/
/* ****************************************************************************/

Future<User?> register(String email, String pin) async {
  try {
    UserCredential credential =
        await auth.createUserWithEmailAndPassword(email: email, password: pin);
    return credential.user;
  } catch (e) {
    print("Error de datos");
  }
  return null;
}

Future<User?> login(String email, String pin) async {
  try {
    UserCredential credential =
        await auth.signInWithEmailAndPassword(email: email, password: pin);
    return credential.user;
  } catch (e) {
    print("Error de credenciales");
  }
  return null;
}

/* ****************************************************************************/
/* ******************************** USER **************************************/
/* ****************************************************************************/

Future<Person?> getUserData(String uid) async {
  try {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('records')
        .doc(uid)
        .collection('information')
        .doc('personal')
        .get();

    if (userSnapshot.exists) {
      return Person.fromFirestore(userSnapshot);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

/* ****************************************************************************/
/* ***************************** BALANCE **************************************/
/* ****************************************************************************/

Future<Balance?> getUserBalance(String uid) async {
  try {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('records')
        .doc(uid)
        .collection('finance')
        .doc('balance')
        .get();

    if (userSnapshot.exists) {
      return Balance.fromFirestore(userSnapshot);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

/* ****************************************************************************/
/* ******************************* LIABILITES *********************************/
/* ****************************************************************************/

Future<List> getLiabilities() async {
  List liabilities = [];

  CollectionReference tblLiabilities = db.collection('liabilities');

  QuerySnapshot query = await tblLiabilities.get();

  for (var doc in query.docs) {
    liabilities.add(doc.data());
  }

  await Future.delayed(const Duration(seconds: 3));

  return liabilities;
}

/* ****************************************************************************/
/* ***************************** DEPOSIT **************************************/
/* ****************************************************************************/

Future<void> saveDeposit(BuildContext context, Deposit deposit) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    uid = user.uid;
    print('========== USER CONNECTED ==========');
    print(uid);
    try {
      QuerySnapshot next = await FirebaseFirestore.instance
          .collection('records')
          .doc(uid)
          .collection('deposit')
          .get();

      String reg;
      if (next.docs.isNotEmpty) {
        String lastDocumentId = next.docs.first.id;
        int nextReg = int.parse(lastDocumentId) + 1;
        reg = nextReg.toString();
      } else {
        reg = '1';
      }

      await db
          .collection('records')
          .doc(uid)
          .collection('deposit')
          .doc(reg)
          .set({
        "date": deposit.dtDeposit,
        "description": deposit.description,
        "amount": deposit.amount,
        "observations": deposit.observations,
        "status": deposit.status
      });

      /*if (balance.exists) {
        Map<String, dynamic>? data = balance.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('deposit')) {
          dynamic amount = data['deposit'];
          if (amount != null) {
            print('Valor del campo deposit: $amount');
            sum = amount + deposit.amount;
            print('Total en ingresos: $sum');
          } else {
            print('El campo deposit es nulo.');
          }
        } else {
          print('El campo deposit no está presente en el documento.');
        }
      } else {
        print('El documento balance no existe.');
      }*/
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Error al guardar el depósito',
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: colorSkin3,
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'No se pudo realizar la consulta',
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: colorSkin3,
      ),
    );
  }
}

Future<double> getBalanceUpdated(double? ing) async {
  DocumentSnapshot balance = await FirebaseFirestore.instance
      .collection('records')
      .doc(uid)
      .collection('finance')
      .doc('balance')
      .get();

  double sum = 0;

  if (balance.exists) {
    // Obtener los datos del DocumentSnapshot como un Map
    Map<String, dynamic>? data = balance.data() as Map<String, dynamic>?;
    print(data);
    if (data != null) {
      // Verificar si el campo 'deposit' está presente en los datos
      if (data.containsKey('deposit')) {
        // Obtener el valor del campo 'deposit'
        dynamic depositValue = data['deposit'];
        print('Valor del campo deposit: $depositValue');
        sum = depositValue + ing;
        print('Total en ingresos: $sum');
      } else {
        print('El campo deposit no está presente en los datos.');
      }
    } else {
      print('Los datos son nulos.');
    }
  } else {
    print('El documento balance no existe.');
  }
  return sum;
}

Future<void> updateDeposit(
    BuildContext context, double total, String uid) async {
  try {
    await FirebaseFirestore.instance
        .collection('records')
        .doc(uid)
        .collection('finance')
        .doc('balance')
        .update({'deposit': total});
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Error al actualizar el valor del depósito',
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: colorSkin3,
      ),
    );
  }
}

/* ****************************************************************************/
/* ******************************* LOANS **************************************/
/* ****************************************************************************/

Future<List<Loan>> getLoans() async {
  List<Loan> loans = [];

  CollectionReference tblLoans = db.collection('loan');

  QuerySnapshot query = await tblLoans.get();

  for (var doc in query.docs) {
    //loans.add(doc.data());
    loans.add(
      Loan(
          idLoan: doc['id'],
          person: doc['person'],
          dtLoan: doc['dtLoan'],
          description: doc['description'],
          amount: doc['amount'],
          observations: doc['observations'],
          due: doc['due'],
          totalDue: doc['totalDue'],
          action: doc['action'],
          status: doc['status']),
    );
  }

  await Future.delayed(const Duration(seconds: 3));

  return loans;
}

Future<List<String>> getDebtorLoans() async {
  List<String> debtors = [];
  CollectionReference tblLoans = FirebaseFirestore.instance.collection('loan');

  QuerySnapshot query = await tblLoans.get();

  for (var doc in query.docs) {
    debtors.add(doc['person']['name']);
  }

  await Future.delayed(const Duration(seconds: 3));

  return debtors;
}

Future<void> updateLoan(String uid, Loan loan) async {
  await db.collection('loan').doc(uid).set({
    "description": loan.description,
    "amount": loan.amount,
    "observations": loan.observations,
    "status": loan.status
  });
}
