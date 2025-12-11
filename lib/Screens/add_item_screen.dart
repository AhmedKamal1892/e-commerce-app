import 'dart:io';
import 'package:adminpage/Models/Product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../services/firestore_service.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _service = FirestoreService();
  final _uuid = const Uuid();
  final picker = ImagePicker();

  String name = '';
  double price = 0.0;
  double discount = 0.0;
  String description = '';
  String? category;
  File? imageFile;

  List<String> sizes = [];
  List<String> colors = [];
  List<String> sizeOptions = ['S', 'M', 'L', 'XL', 'XXL'];
  List<String> selectedSizes = [];

  List<String> colorOptions = ['Black', 'Grey', 'White'];
  List<String> selectedColors = [];

  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  bool isLoading = false;


  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => imageFile = File(pickedFile.path));
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


  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (imageFile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select an image')));
      return;
    }

    _formKey.currentState!.save();
    setState(() => isLoading = true);

    try {
      final base64Image = await _service.encodeImageToBase64(imageFile!);

      final product = Product(
        id: _uuid.v4(),
        name: name,
        price: price,
        category: category ?? '',
        discount: discount,
        finalPrice: price - (price * discount / 100),
        description: description,
        size: selectedSizes,
        color: selectedColors,
        quantity: 1,
        imageUrl: base64Image,
      );

      await _service.addProduct(product);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Product added successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print(' Error adding product: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add product: $e')));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1E1E), Color(0xFF1E1E1E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder(
            stream: _service.getCategories(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final categories = snapshot.data!.docs;

              return Form(
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
                        labelText: 'Product Name',
                        labelStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                      onSaved: (val) => name = val!.trim(),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Enter product name'
                          : null,
                    ),
                    SizedBox(height: 20),

                    TextFormField(
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      decoration:  InputDecoration(

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFC83F21), width: 2),

                        ),
                        labelText: 'Price',
                        labelStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (val) =>
                          price = double.tryParse(val ?? '0') ?? 0.0,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter price' : null,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      decoration:  InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFC83F21), width: 2),

                        ),
                        labelText: 'discount',
                        labelStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (val) =>
                          discount = double.tryParse(val ?? '0') ?? 0.0,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter discount' : null,
                    ),
                    SizedBox(height: 20),

                    TextFormField(

                      style:  TextStyle(color: Color(0xFFFFFFFF)),
                      decoration:  InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFC83F21), width: 2),

                        ),

                        labelText: 'Description (optional)',
                        labelStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      ),

                      onSaved: (val) => description = val ?? '',
                    ),
        SizedBox(height: 20),

                    DropdownButtonFormField<String>(
                      borderRadius: BorderRadius.circular(20),
                      style: TextStyle(color: Colors.orange),
                      decoration:  InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFC83F21), width: 2),

                        ),
                        labelText: 'Category',
                        labelStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                      items: categories
                          .map(
                            (c) => DropdownMenuItem<String>(
                              value: c['name'],
                              child: Text(c['name']),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => category = val),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Select a category'
                          : null,
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


                    imageFile != null
                        ? Image.file(imageFile!, height: 150)
                        : const Text('No image selected'),
                    TextButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC83F21),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xFFC83F21),
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: pickImage,
                      icon: const Icon(Icons.image, color: Color(0xFFFFFFFF)),
                      label: const Text(
                        'Pick Image',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),

                    const SizedBox(height: 20),


                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC83F21),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Color(0xFFC83F21),
                                  width: 2,
                                ),
                              ),
                            ),
                            onPressed: submit,
                            icon: const Icon(
                              Icons.add,
                              color: Color(0xFFFFFFFF),
                            ),
                            label: const Text(
                              'Add Product',
                              style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
