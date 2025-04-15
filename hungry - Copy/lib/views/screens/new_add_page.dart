import 'package:flutter/material.dart';
import 'package:hungry/views/screens/page_switcher.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final caloriesController = TextEditingController();
  final timeController = TextEditingController();
  final imageUrlController = TextEditingController();
  final ingredientsController = TextEditingController(); // comma separated
  final stepsController = TextEditingController();       // comma separated

  Future<void> _submitRecipe() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('recipes').add({
          'userEmail': FirebaseAuth.instance.currentUser?.email ?? 'guest',
          'name': nameController.text.trim(),
          'description': descriptionController.text.trim(),
          'calories': caloriesController.text.trim(),
          'time': timeController.text.trim(),
          'imageUrl': imageUrlController.text.trim(),
          'ingredients': ingredientsController.text.split(',').map((e) => e.trim()).toList(),
          'steps': stepsController.text.split(',').map((e) => e.trim()).toList(),
        });

       /* ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recipe added successfully!')),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        ); */

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Recipe added successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // close the dialog

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => PageSwitcher(initialIndex: 0),
                      ),
                        (route) => false, // remove all previous routes
                  );



                },
                child: const Text('OK'),
              ),
            ],
          ),
        );



      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recipe')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Recipe Name', nameController),
              _buildTextField('Description', descriptionController),
              _buildTextField('Calories (e.g. 450 kcal)', caloriesController),
              _buildTextField('Time (e.g. 30 min)', timeController),
              _buildTextField('Image URL', imageUrlController),
              _buildTextField('Ingredients (comma separated)', ingredientsController),
              _buildTextField('Steps (comma separated)', stepsController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitRecipe,
                child: const Text('Add Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }
}
