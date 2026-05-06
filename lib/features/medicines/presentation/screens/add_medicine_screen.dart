import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:el_bershama/core/style/app_colors.dart';
import 'package:el_bershama/core/style/app_styles.dart';
import 'package:el_bershama/core/widgets/button_widget.dart';
import 'package:el_bershama/features/notifications/presentation/providers/notifications_provider.dart';
import 'package:el_bershama/features/medicines/data/models/medicine_model.dart';
import 'package:el_bershama/features/medicines/presentation/providers/medicines_provider.dart';
import 'dart:io';

class AddMedicineScreen extends ConsumerStatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  ConsumerState<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends ConsumerState<AddMedicineScreen> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  int _doseCount = 1;
  List<TimeOfDay?> _times = [null];
  DateTime? _startDate;
  DateTime? _endDate;
  String? _imagePath;
  bool _isLoading = false;

  Map<String, String> _errors = {};

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  void _validateForm() {
    _errors.clear();

    if (_nameController.text.isEmpty) {
      _errors['name'] = 'اسم الدواء مطلوب';
    }

    if (_dosageController.text.isEmpty) {
      _errors['dosage'] = 'الجرعة مطلوبة';
    }

    if (_times.any((t) => t == null)) {
      _errors['times'] = 'جميع أوقات الجرعات مطلوبة';
    }

    if (_startDate == null) {
      _errors['startDate'] = 'تاريخ البداية مطلوب';
    }

    setState(() {});
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _imagePath = image.path);
    }
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _endDate = picked);
    }
  }

  Future<void> _pickTime(int index) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _times[index] ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _times[index] = picked);
    }
  }

  void _updateDoseCount(int newCount) {
    setState(() {
      if (newCount > _times.length) {
        _times.add(null);
      } else if (newCount < _times.length) {
        _times.removeLast();
      }
      _doseCount = newCount;
    });
  }

  Future<void> _save() async {
    _validateForm();

    if (_errors.isNotEmpty) return;

    setState(() => _isLoading = true);

    try {
      final medicine = MedicineModel(
        name: _nameController.text.trim(),
        dosage: _dosageController.text.trim(),
        dailyDoseCount: _doseCount,
        doseTimes: _times
            .whereType<TimeOfDay>()
            .map((t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}')
            .toList(),
        startDate: _startDate!,
        endDate: _endDate,
        imagePath: _imagePath,
      );

      await ref.read(medicinesProvider.notifier).addMedicine(medicine);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('إضافة دواء جديد'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePicker(),
              const SizedBox(height: 32),
              _buildTextField('اسم الدواء', _nameController, 'name'),
              const SizedBox(height: 16),
              _buildTextField('الجرعة', _dosageController, 'dosage'),
              const SizedBox(height: 24),
              _buildDoseStepper(),
              const SizedBox(height: 24),
              _buildDoseTimesSection(),
              const SizedBox(height: 24),
              _buildDatePicker(
                label: 'تاريخ البداية',
                date: _startDate,
                onTap: _pickStartDate,
                errorKey: 'startDate',
              ),
              const SizedBox(height: 16),
              _buildDatePicker(
                label: 'تاريخ النهاية (اختياري)',
                date: _endDate,
                onTap: _pickEndDate,
              ),
              const SizedBox(height: 48),
              ButtonWidget(
                text: 'حفظ الدواء',
                onPressed: _save,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: Stack(
        children: [
          if (_imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(_imagePath!),
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: const Icon(
                Icons.medication,
                size: 80,
                color: AppColors.primary,
              ),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String errorKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.bodyLarge),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            errorText: _errors[errorKey],
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildDoseStepper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('عدد الجرعات يومياً', style: AppStyles.bodyLarge),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _doseCount > 1 ? () => _updateDoseCount(_doseCount - 1) : null,
              icon: const Icon(Icons.remove_circle_outline),
              iconSize: 32,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: Text(
                '$_doseCount',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: _doseCount < 6 ? () => _updateDoseCount(_doseCount + 1) : null,
              icon: const Icon(Icons.add_circle_outline),
              iconSize: 32,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDoseTimesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('مواعيد الجرعات', style: AppStyles.bodyLarge),
            if (_errors.containsKey('times'))
              Text(
                _errors['times']!,
                style: const TextStyle(color: AppColors.error, fontSize: 12),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(_times.length, (index) {
            final time = _times[index];
            return GestureDetector(
              onTap: () => _pickTime(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: time != null ? AppColors.primary : Colors.white,
                  border: Border.all(
                    color: time != null ? AppColors.primary : AppColors.textLight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  time != null
                      ? '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'
                      : '+ أضف وقت',
                  style: TextStyle(
                    color: time != null ? Colors.white : AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    String? errorKey,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.bodyLarge),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: errorKey != null && _errors.containsKey(errorKey)
                    ? AppColors.error
                    : AppColors.textLight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date != null
                      ? intl.DateFormat('dd/MM/yyyy', 'ar_SA').format(date)
                      : 'اختر التاريخ',
                  style: TextStyle(
                    color: date != null ? AppColors.textDark : AppColors.textLight,
                  ),
                ),
                const Icon(Icons.calendar_today, color: AppColors.primary),
              ],
            ),
          ),
        ),
        if (errorKey != null && _errors.containsKey(errorKey))
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _errors[errorKey]!,
              style: const TextStyle(color: AppColors.error, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
