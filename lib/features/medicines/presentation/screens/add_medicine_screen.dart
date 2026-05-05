import 'dart:io';
import 'package:el_bershama/core/constants/app_colors.dart';
import 'package:el_bershama/features/medicines/data/models/medicine_model.dart';
import 'package:el_bershama/features/medicines/presentation/providers/medicine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;

class AddMedicineScreen extends ConsumerStatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  ConsumerState<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends ConsumerState<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  
  int _dailyDoseCount = 2;
  List<TimeOfDay> _doseTimes = [
    const TimeOfDay(hour: 8, minute: 0),
    const TimeOfDay(hour: 20, minute: 0),
  ];
  
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  String? _imagePath;
  bool _isLoading = false;

  void _updateDoseCount(int count) {
    setState(() {
      _dailyDoseCount = count.clamp(1, 6);
      if (_doseTimes.length < _dailyDoseCount) {
        _doseTimes.addAll(List.generate(_dailyDoseCount - _doseTimes.length, (_) => const TimeOfDay(hour: 12, minute: 0)));
      } else if (_doseTimes.length > _dailyDoseCount) {
        _doseTimes = _doseTimes.sublist(0, _dailyDoseCount);
      }
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imagePath = pickedFile.path);
    }
  }

  Future<void> _selectTime(int index) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _doseTimes[index],
    );
    if (pickedTime != null) {
      setState(() => _doseTimes[index] = pickedTime);
    }
  }

  Future<void> _selectDate(bool isStart) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : (_endDate ?? DateTime.now()),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  Future<void> _saveMedicine() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    final medicine = MedicineModel(
      name: _nameController.text.trim(),
      dosage: _dosageController.text.trim(),
      dailyDoseCount: _dailyDoseCount,
      doseTimes: _doseTimes.map((t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}').toList(),
      startDate: _startDate,
      endDate: _endDate,
      imagePath: _imagePath,
    );

    await ref.read(medicinesProvider.notifier).addMedicine(medicine);
    
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة دواء جديد'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Picker
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                          ],
                        ),
                        child: _imagePath == null
                            ? const Icon(Icons.medication, size: 80, color: AppColors.primary)
                            : ClipOval(child: Image.file(File(_imagePath!), fit: BoxFit.cover)),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                _buildLabel('اسم الدواء'),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'اكتب اسم الدواء'),
                  validator: (v) => v == null || v.isEmpty ? 'يرجى إدخال اسم الدواء' : null,
                ),

                _buildLabel('الجرعة'),
                TextFormField(
                  controller: _dosageController,
                  decoration: const InputDecoration(hintText: 'مثال: 500 مجم'),
                  validator: (v) => v == null || v.isEmpty ? 'يرجى إدخال الجرعة' : null,
                ),

                _buildLabel('عدد الجرعات يومياً'),
                _buildStepper(),

                _buildLabel('مواعيد الجرعات'),
                Wrap(
                  spacing: 8,
                  children: List.generate(_dailyDoseCount, (index) {
                    final time = _doseTimes[index];
                    return ActionChip(
                      label: Text('${time.hour}:${time.minute.toString().padLeft(2, '0')}'),
                      avatar: const Icon(Icons.access_time, size: 16),
                      onPressed: () => _selectTime(index),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    );
                  }),
                ),

                _buildLabel('تاريخ البداية'),
                _buildDatePicker(intl.DateFormat('yyyy-MM-dd').format(_startDate), () => _selectDate(true)),

                _buildLabel('تاريخ النهاية (اختياري)'),
                _buildDatePicker(
                  _endDate == null ? 'اختر التاريخ' : intl.DateFormat('yyyy-MM-dd').format(_endDate!),
                  () => _selectDate(false),
                ),

                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveMedicine,
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('حفظ الدواء'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildStepper() {
    return Container(
      width: 150,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: () => _updateDoseCount(_dailyDoseCount - 1), icon: const Icon(Icons.remove)),
          Text('$_dailyDoseCount', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(onPressed: () => _updateDoseCount(_dailyDoseCount + 1), icon: const Icon(Icons.add, color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildDatePicker(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: AppColors.textLight, size: 20),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(color: AppColors.textDark)),
          ],
        ),
      ),
    );
  }
}
