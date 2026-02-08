import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pracscreen extends StatefulWidget {
  const Pracscreen({super.key});

  @override
  State<Pracscreen> createState() => _PracscreenState();
}

class _PracscreenState extends State<Pracscreen> {
  var input = TextEditingController();
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  // Load saved items
  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      items = prefs.getStringList('items') ?? [];
    });
  }

  // Save items
  Future<void> saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', items);
  }

  void addiem() {
    if (input.text.isNotEmpty) {
      setState(() {
        items.add(input.text);
        input.clear();
      });
      saveItems();
    }
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
    saveItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shared Pref + ListTile')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: input,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Items',
                ),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: addiem, child: const Text('ADD')),
                ],
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(items[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteItem(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
