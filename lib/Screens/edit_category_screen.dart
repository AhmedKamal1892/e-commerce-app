import 'dart:io';
import 'dart:convert';
import 'package:adminpage/Models/Category.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class EditCategoryScreen extends StatefulWidget {
  final String categoryId;

  const EditCategoryScreen({super.key, required this.categoryId});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _service = FirestoreService();
  final picker = ImagePicker();

  String name = '';
  int noOfCategories = 0;
  String? imageData;
  File? newImageFile;

  bool isLoading = false;
  bool dataLoaded = false;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => newImageFile = File(pickedFile.path));
    }
  }

  Future<void> updateCategory() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => isLoading = true);

    try {
      final updatedImage = newImageFile != null
          ? await _service.encodeImageToBase64(newImageFile!)
          : imageData ?? '';

      final updatedCategory = Category(
        id: widget.categoryId,
        name: name,
        imageUrl: updatedImage,
      );

      await _service.updateCategory(updatedCategory);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Category updated successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print(' Error updating category: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update category: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Category')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('categories')
            .doc(widget.categoryId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          if (!dataLoaded) {
            name = data['name'] ?? '';
            noOfCategories = (data['NoOfCategories'] as num?)?.toInt() ?? 0;
            imageData = data['imageUrl'];
            dataLoaded = true;
          }

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E1E1E), Color(0xFF1E1E1E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      initialValue: name,
                      decoration:  InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFC83F21), width: 2),

                        ),
                        labelText: 'Category Name',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (val) =>
                      val == null || val.isEmpty ? 'Enter category name' : null,
                      onSaved: (val) => name = val!,
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    if (newImageFile != null)
                      Image.file(newImageFile!, height: 150)
                    else if (imageData != null && imageData!.isNotEmpty)
                      Image.memory(base64Decode(imageData!),
                          height: 150, fit: BoxFit.cover)
                    else
                      const Text('No image available',
                          style: TextStyle(color: Colors.white)),
                    TextButton.icon(
                      onPressed: pickImage,
                      icon: const Icon(Icons.image, color: Colors.white),
                      label: const Text('Change Image',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC83F21),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color: Color(0xFFC83F21), width: 2),
                        ),
                      ),
                      onPressed: updateCategory,
                      child: const Text('Save Changes',style: TextStyle(color: Color(0xFFFFFFFF)),),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
