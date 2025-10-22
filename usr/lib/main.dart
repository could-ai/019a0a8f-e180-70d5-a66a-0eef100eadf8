import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/tuition_income.dart';
import 'screens/add_income_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuition Income Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const IncomeTrackerScreen(),
    );
  }
}

class IncomeTrackerScreen extends StatefulWidget {
  const IncomeTrackerScreen({super.key});

  @override
  State<IncomeTrackerScreen> createState() => _IncomeTrackerScreenState();
}

class _IncomeTrackerScreenState extends State<IncomeTrackerScreen> {
  final List<TuitionIncome> _incomeList = [];

  double get _totalIncome {
    return _incomeList.fold(0.0, (sum, item) => sum + item.amount);
  }

  void _addIncome(TuitionIncome income) {
    setState(() {
      _incomeList.add(income);
    });
  }

  void _navigateToAddIncomeScreen() async {
    final newIncome = await Navigator.push<TuitionIncome>(
      context,
      MaterialPageRoute(builder: (context) => const AddIncomeScreen()),
    );

    if (newIncome != null) {
      _addIncome(newIncome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tuition Income Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Income',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${_totalIncome.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: _incomeList.isEmpty
                ? const Center(
                    child: Text(
                      'No income recorded yet.\nTap the "+" button to add one!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _incomeList.length,
                    itemBuilder: (context, index) {
                      final income = _incomeList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(income.studentName, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(DateFormat.yMMMd().format(income.date)),
                          trailing: Text(
                            '+\$${income.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddIncomeScreen,
        tooltip: 'Add Income',
        child: const Icon(Icons.add),
      ),
    );
  }
}
