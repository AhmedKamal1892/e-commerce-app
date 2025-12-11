import 'dart:convert';
import 'dart:io';
import 'package:adminpage/Models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/firestore_service.dart';

class EditItemScreen extends StatefulWidget {
  final String itemId;
  const EditItemScreen({super.key, required this.itemId});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _service = FirestoreService();
  final picker = ImagePicker();

  String name = '';
  double price = 0.0;
  String description = '';
  String? category;
  List<String> sizes = [];
  List<String> colors = [];
  List<String> sizeOptions = ['S', 'M', 'L', 'XL', 'XXL'];
  List<String> selectedSizes = [];

  List<String> colorOptions = ['Black', 'Grey', 'White'];
  List<String> selectedColors = [];
  String? imageData;
  File? newImageFile;

  bool isLoading = false;
  bool dataLoaded = false; // ✅ prevent reassigning on every rebuild

  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => newImageFile = File(pickedFile.path));
    }
  }

  void addSize() {
    final val = _sizeController.text.trim();
    if (val.isNotEmpty && !sizes.contains(val)) {
      setState(() => sizes.add(val));
      _sizeController.clear();
    }
  }

  void addColor() {
    final val = _colorController.text.trim();
    if (val.isNotEmpty && !colors.contains(val)) {
      setState(() => colors.add(val));
      _colorController.clear();
    }
  }

  Future<void> updateItem() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => isLoading = true);

    try {
      final updatedImage = newImageFile != null
          ? await _service.encodeImageToBase64(newImageFile!)
          : imageData ?? '';

      final product = Product(
        id: widget.itemId,
        name: name,
        price: price,
        finalPrice: price,
        category: category ?? '',
        discount: 0,
        description: description,
        size: selectedSizes,
        color: selectedColors,
        quantity: 1,
        imageUrl: updatedImage,
      );

      await _service.updateProduct(product);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Product updated successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error updating product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('products')
            .doc(widget.itemId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;


          if (!dataLoaded) {
            name = data['name'] ?? '';
            price = (data['price'] as num?)?.toDouble() ?? 0.0;
            description = data['description'] ?? '';
            category = data['category'];
            sizes = List<String>.from(data['size'] ?? []);
            colors = List<String>.from(data['color'] ?? []);
            imageData = data['imageUrl'];
            dataLoaded = true;
          }

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E1E1E), Color(0xFF1E1E1E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<QuerySnapshot>(
                stream: _service.getCategories(),
                builder: (context, catSnapshot) {
                  if (!catSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final categories = catSnapshot.data!.docs;

                  return Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                          initialValue: name,
                          decoration:  InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFFC83F21), width: 2),

                              ),
                              labelText: 'Name', labelStyle: TextStyle(color: Color(0xFFFFFFFF)),),
                          validator: (val) =>
                          val == null || val.isEmpty ? 'Enter name' : null,
                          onSaved: (val) => name = val!,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                          initialValue: price.toString(),
                          decoration:  InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFFC83F21), width: 2),

                              ),
                              labelText: 'Price', labelStyle: TextStyle(color: Color(0xFFFFFFFF)), ),
                          keyboardType: TextInputType.number,
                          validator: (val) => val == null ||
                              double.tryParse(val) == null
                              ? 'Enter valid price'
                              : null,
                          onSaved: (val) => price = double.parse(val!),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(

                          style: TextStyle(color: Color(0xFFFFFFFF)),
                          initialValue: description,
                          decoration:
                           InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFFC83F21), width: 2),

                              ),
                              labelText: 'Description',labelStyle: TextStyle(color: Color(0xFFFFFFFF))),
                          onSaved: (val) => description = val ?? '',
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                          value: category?.isNotEmpty == true ? category : null,
                          decoration:
                           InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFFC83F21), width: 2),

                              ),
                              labelText: 'Category', labelStyle: TextStyle(color: Color(0xFFFFFFFF)),),
                          items: categories.map((c) {
                            final catName = c['name'] ?? '';
                            return DropdownMenuItem<String>(
                              value: catName,
                              child: Text(catName),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => category = val),
                          validator: (val) =>
                          val == null || val.isEmpty ? 'Select category' : null,
                        ),

                        const SizedBox(height: 20),

                        const Text('Sizes'),
                        Wrap(
                          spacing: 10,
                          children: sizeOptions.map((size) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: selectedSizes.contains(size),
                                  onChanged: (checked) {
                                    setState(() {
                                      if (checked!) {
                                        selectedSizes.add(size);
                                      } else {
                                        selectedSizes.remove(size);
                                      }
                                    });
                                  },
                                  checkColor: Colors.white,
                                  activeColor: Color(0xFFC83F21),
                                ),
                                Text(size, style: TextStyle(color: Colors.white)),
                              ],
                            );
                          }).toList(),
                        ),

                        SizedBox(height: 30),

                        const Text('Colors'),
                        Wrap(
                          spacing: 10,
                          children: colorOptions.map((color) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: selectedColors.contains(color),
                                  onChanged: (checked) {
                                    setState(() {
                                      if (checked!) {
                                        selectedColors.add(color);
                                      } else {
                                        selectedColors.remove(color);
                                      }
                                    });
                                  },
                                  checkColor: Colors.white,
                                  activeColor: Color(0xFFC83F21),
                                ),
                                Text(color, style: TextStyle(color: Colors.white)),
                              ],
                            );
                          }).toList(),
                        ),


                        const SizedBox(height: 20),

                        if (newImageFile != null)
                          Image.file(newImageFile!, height: 150)
                        else if (imageData != null && imageData!.isNotEmpty)
                          Image.memory(base64Decode(imageData!),
                              height: 200, fit: BoxFit.cover)
                        else
                          const Text('No image available'),

                        TextButton.icon(
                          onPressed: pickImage,
                          icon: const Icon(Icons.image),
                          label: const Text('Change Image'),
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
                          onPressed: updateItem,
                          child: const Text('Save Changes',style: TextStyle(color: Color(0xFFFFFFFF)),),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
