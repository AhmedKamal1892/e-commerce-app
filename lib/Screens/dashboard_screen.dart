import 'dart:convert';
import 'package:adminpage/Screens/Categories_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_item_screen.dart';
import 'add_category_screen.dart';
import 'edit_item_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final itemsRef = FirebaseFirestore.instance.collection('products');
  final categoriesRef = FirebaseFirestore.instance.collection('categories');

  String searchQuery = '';
  bool showOnlyWithImage = false;

  static const Color bgColor = Color(0xFF1E1E1E);
  static const Color cardColor = Color(0xFF2B2828);
  static const Color accent = Color(0xFFC83F21);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        backgroundColor: bgColor,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildActionRow(),
            const SizedBox(height: 16),
            _buildStatsRow(),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 12),
            Expanded(child: _buildItemsList()),
          ],
        ),
      ),
    );
  }

  // Top action buttons row
  Widget _buildActionRow() {
    return Row(

      children: [
        _buildActionButton(Icons.add, 'Add Item', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddItemScreen()))
              .then((_) => setState(() {}));
        }),
SizedBox(width: 4,),
        _buildActionButton(Icons.category, 'Add Category', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddCategoryScreen()))
              .then((_) => setState(() {}));
        }),
        SizedBox(width: 4,),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: accent),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoriesScreen())),
          icon: const Icon(Icons.list),

          label: const Text('Categories'),
        ),
        const Spacer(),
      ],
    );
  }

  // Helper to create action buttons
  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }

  // Stats cards row
  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: itemsRef.snapshots(),
            builder: (context, snapshot) {
              final count = snapshot.hasData ? snapshot.data!.docs.length : 0;
              return _StatsCard(title: 'Total Items', value: '$count', accent: accent, cardColor: cardColor);
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: categoriesRef.snapshots(),
            builder: (context, snapshot) {
              final count = snapshot.hasData ? snapshot.data!.docs.length : 0;
              return _StatsCard(title: 'Categories', value: '$count', accent: accent, cardColor: cardColor);
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatsCard(
            title: 'Search',
            value: searchQuery.isEmpty ? 'All' : searchQuery,
            accent: accent,
            cardColor: cardColor,
            smallSubtitle: 'Query',
          ),
        ),
      ],
    );
  }

  // Search bar
  Widget _buildSearchBar() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: cardColor,
        hintText: 'Search by name or category',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
      onChanged: (v) => setState(() => searchQuery = v.trim()),
    );
  }

  // Items list
  Widget _buildItemsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: itemsRef.orderBy('name').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        var docs = snapshot.data!.docs;

        if (searchQuery.isNotEmpty) {
          final q = searchQuery.toLowerCase();
          docs = docs.where((d) {
            final name = (d['name'] ?? '').toString().toLowerCase();
            final cat = (d['category'] ?? '').toString().toLowerCase();
            return name.contains(q) || cat.contains(q);
          }).toList();
        }

        if (showOnlyWithImage) docs = docs.where((d) => (d['imageUrl'] ?? '').toString().isNotEmpty).toList();
        if (docs.isEmpty) return const Center(child: Text('No items found.', style: TextStyle(color: Colors.white)));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTableHeader(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: docs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) => _buildItemRow(docs[index]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          SizedBox(width: 70, child: Text('Image', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600))),
          SizedBox(width: 15),
          Expanded(flex: 3, child: Text('Name', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text('Price', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600))),
          Expanded(flex: 3, child: Text('Category', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600))),
          SizedBox(width: 120, child: Text('Actions', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  // Single item row
  Widget _buildItemRow(QueryDocumentSnapshot item) {
    final name = (item['name'] ?? '').toString();
    final category = (item['category'] ?? '—').toString();
    final finalPrice = item.data().toString().contains('finalPrice') ? item['finalPrice'].toString() : '—';
    final imageUrl = (item['imageUrl'] ?? '').toString();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withOpacity(0.5), width: 1.5),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: _buildImageWidget(imageUrl),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(flex: 3, child: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
          Expanded(flex: 3, child: Text(finalPrice.startsWith('\$') ? finalPrice : '\$${finalPrice}', style: const TextStyle(color: Colors.white))),
          Expanded(flex: 2, child: Text(category, style: const TextStyle(color: Colors.white70))),
          SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orangeAccent),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditItemScreen(itemId: item.id)),
                  ).then((_) => setState(() {})),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
                  onPressed: () => _confirmDelete(item.id, item['name'] ?? 'item'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Image helper
  Widget _buildImageWidget(String base64String) {
    if (base64String.isEmpty) {
      return Container(
        color: Colors.black26,
        child: const Center(child: Icon(Icons.image_not_supported, color: Colors.white54)),
      );
    }
    try {
      final bytes = base64Decode(base64String);
      return Image.memory(bytes, fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    } catch (e) {
      return Container(
        color: Colors.black26,
        child: const Center(child: Icon(Icons.broken_image_outlined, color: Colors.white54)),
      );
    }
  }

  // Delete confirmation
  void _confirmDelete(String id, String name) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: bgColor,
        title: Text('Delete "$name"?', style: const TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to permanently delete this item?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (ok == true) {
      try {
        await itemsRef.doc(id).delete();
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item deleted')));
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
      }
    }
  }
}

// Stats card (separate widget)
class _StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color accent;
  final Color cardColor;
  final String? smallSubtitle;

  const _StatsCard({
    required this.title,
    required this.value,
    required this.accent,
    required this.cardColor,
    this.smallSubtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withOpacity(0.6)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(8)),
            width: 30,
            height: 30,
            child: const Icon(Icons.analytics, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                if (smallSubtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(smallSubtitle!, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
