import 'package:flutter/material.dart';

class SearchFilterDialog extends StatefulWidget {
  const SearchFilterDialog({super.key});

  @override
  _SearchFilterDialogState createState() => _SearchFilterDialogState();
}

class _SearchFilterDialogState extends State<SearchFilterDialog> {
  final Set<String> selectedCategories = {};
  final Set<String> selectedLocations = {};
  final Set<String> selectedGenders = {};

  final List<String> categories = [
    "Keluarga", "Sosial", "Bermain", "Belajar",
    "Sekolah", "Belanja", "Pengembangan Diri",
    "Hobi", "Olahraga", "Seni", "Hiburan",
  ];

  final List<String> locations = [
    "Indoor", "Outdoor", "Indoor/Outdoor",
  ];

  final List<String> genders = [
    "Laki-laki", "Perempuan", "Unisex",
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Filter Pencarian',
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const Text("Kategori"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: categories.map((category) {
                final isSelected = selectedCategories.contains(category);
                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  selectedColor: Colors.grey.shade300,
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  onSelected: (_) {
                    setState(() {
                      if (isSelected) {
                        selectedCategories.remove(category);
                      } else {
                        selectedCategories.add(category);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const Text("Lokasi"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: locations.map((location) {
                final isSelected = selectedLocations.contains(location);
                return ChoiceChip(
                  label: Text(location),
                  selected: isSelected,
                  selectedColor: Colors.grey.shade300,
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  onSelected: (_) {
                    setState(() {
                      if (isSelected) {
                        selectedLocations.remove(location);
                      } else {
                        selectedLocations.add(location);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const Text("Jenis Kelamin"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: genders.map((gender) {
                final isSelected = selectedGenders.contains(gender);
                return ChoiceChip(
                  label: Text(gender),
                  selected: isSelected,
                  selectedColor: Colors.grey.shade300,
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  onSelected: (_) {
                    setState(() {
                      if (isSelected) {
                        selectedGenders.remove(gender);
                      } else {
                        selectedGenders.add(gender);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        const Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
            },
            child: const Text(
              'Terapkan',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
