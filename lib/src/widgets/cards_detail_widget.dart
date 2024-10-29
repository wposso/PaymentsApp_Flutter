import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class CardsDetail extends StatelessWidget {
  const CardsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(),
            const SizedBox(height: 5.0),
            const Expanded(child: ModuleList()),
          ],
        ),
      ),
    );
  }

  Text _buildTitle() => const Text(
        'Información detallada',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      );
}

class ModuleList extends StatelessWidget {
  const ModuleList({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      minItemWidth: 300,
      minItemsPerRow: 2,
      maxItemsPerRow: 3,
      verticalGridSpacing: 10,
      horizontalGridSpacing: 10,
      // verticalGridMargin: 50,
      // horizontalGridMargin: 50,
      listViewBuilderOptions: ListViewBuilderOptions(
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      children: List.generate(
        _modules.length,
        (index) => _cardModule(
          icon: _modules[index]['icon'],
          color: _modules[index]['color'],
          title: _modules[index]['title'],
          amount: _modules[index]['amount'],
          onTap: () {
            print(_modules[index]['breadcrumbName']);
            Navigator.pushNamed(context, _modules[index]['breadcrumbName']);
          },
        ),
      ),
    );
  }

  Widget _cardModule({
    required Color color,
    required String icon,
    required String title,
    required double amount,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 30.0,
              color: sombraColor,
              offset: Offset(0, 10.0),
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: color.withOpacity(.2),
              child: Image.asset(icon, color: color, width: 20.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              title,
              style:
                  const TextStyle(color: colorTextoSecundario, fontSize: 11.0),
            ),
            Text(
              NumberFormat.currency(symbol: '\$ ', decimalDigits: 0)
                  .format(amount),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _modules = [
  {
    "color": colorPrimario,
    "icon": 'assets/pagar1.png',
    "title": 'Ingresos',
    "amount": 1000000.00,
    "breadcrumbName": 'deposit',
  },
  {
    "color": Colors.pinkAccent,
    "icon": 'assets/egress.png',
    "title": 'Egresos',
    "amount": 1420000.00,
    "breadcrumbName": 'egress',
  },
  {
    "color": Colors.deepPurpleAccent,
    "icon": 'assets/payment_history.png',
    "title": 'Pendientes',
    "amount": 500000.00,
    "breadcrumbName": 'pending',
  },
  {
    "color": colorSecundario,
    "icon": 'assets/send.png',
    "title": 'Enviar',
    "amount": 80.50,
    "breadcrumbName": 'send',
  },
  {
    "color": Colors.red.shade900,
    "icon": 'assets/debt.png',
    "title": 'Deudas',
    "amount": 100000.00,
    "breadcrumbName": 'liabilities',
  },
  {
    "color": colorPrimario,
    "icon": 'assets/insert_money.png',
    "title": 'Pagar',
    "amount": 500000.00,
    "breadcrumbName": 'pay',
  },
  {
    "color": Colors.orange.shade700,
    "icon": 'assets/loans.png',
    "title": 'Prestamos',
    "amount": 100000.00,
    "breadcrumbName": 'loans', //no esta
  },
  {
    "color": colorPrimario,
    "icon": 'assets/add_money.png',
    "title": 'Abonos',
    "amount": 500000.00,
    "breadcrumbName": 'fertilizers', //no esta
  },
];
