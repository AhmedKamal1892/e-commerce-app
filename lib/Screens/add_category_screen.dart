import 'dart:io';
import 'package:adminpage/Models/Category.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import '../services/firestore_service.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _service = FirestoreService();
  final _uuid = const Uuid();

  String categoryName = '';
  File? imageFile;
  bool isLoading = false;
  final picker = ImagePicker();


  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => imageFile = File(picked.path));
    }
  }

  Future<String> encodeImage(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }


  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    setState(() => isLoading = true);
    _formKey.currentState!.save();

    try {
      final imageBase64 = await encodeImage(imageFile!);

      final category = Category(
        id: _uuid.v4(),
        name: categoryName,
        imageUrl: imageBase64,
      );

      await _service.addCategory(category);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Category added successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print(' Error adding category: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add category: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Category')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1E1E), Color(0xFF1E1E1E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                  decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFC83F21), width: 2),

                      ),

                      labelText: 'Category Name',labelStyle: TextStyle(color: Color(0xFFFFFFFF))),

                  onSaved: (val) => categoryName = val!.trim(),
                  validator: (val) =>
                  val == null || val.isEmpty ? 'Enter category name' : null,
                ),
                const SizedBox(height: 20),
                imageFile != null
                    ? Image.file(imageFile!, height: 150)
                    : const Text('No image selected'),
                TextButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC83F21),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: Color(0xFFC83F21),
                        width: 2,
                      ),
                    ),),
                  onPressed: pickImage,
                  icon: const Icon(Icons.image,color: Color(0xFFFFFFFF),),
                  label: const Text('Pick Image',style: TextStyle(color: Color(0xFFFFFFFF)),),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC83F21),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: Color(0xFFC83F21),
                        width: 2,
                      ),
                    ),),
                  onPressed: submit,
                  icon: const Icon(Icons.add,color: Color(0xFFFFFFFF),),
                  label: const Text('Add Category',style: TextStyle(color: Color(0xFFFFFFFF)),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
