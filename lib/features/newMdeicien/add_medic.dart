import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:el_bershama/core/models/medicine_model.dart';
import 'package:flutter/material.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController doseController = TextEditingController();
  int doseCount = 2;
  DateTime? startDate;
  DateTime? endDate;
  List<TimeOfDay> doseTimes = [];

  @override
  void dispose() {
    nameController.dispose();
    doseController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('ar', 'EG'),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        doseTimes.add(picked);
      });
    }
  }

  void _saveMedicine() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى إدخال اسم الدواء")),
      );
      return;
    }

    if (startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى اختيار تاريخ البداية")),
      );
      return;
    }

    final newMedicine = Medicine(
      name: nameController.text,
      dose: doseController.text,
      dailyCount: doseCount,
      times: doseTimes,
      startDate: startDate!,
      endDate: endDate,
    );

    // Add to the global static list
    Medicine.savedMedicines.add(newMedicine);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم حفظ الدواء بنجاح"),
        backgroundColor: Colors.green,
      ),
    );

    // Return the new medicine object to the previous screen
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop(newMedicine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF9FBFF),
          appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "إضافة دواء جديد",
                  style: StylesManger.black18Bold.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F0FE),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/medicine_bottle.png',
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.medication,
                            size: 80,
                            color: ColorsManger.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: ColorsManger.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildLabel("اسم الدواء"),
              _buildTextField(hint: "اكتب اسم الدواء", controller: nameController),
              const SizedBox(height: 20),
              _buildLabel("الجرعة"),
              _buildTextField(hint: "مثال: 500 مجم", controller: doseController),
              const SizedBox(height: 20),
              _buildLabel("عدد الجرعات يومياً"),
              _buildCounter(),
              const SizedBox(height: 20),
              _buildLabel("مواعيد الجرعات"),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...doseTimes.map((time) => Chip(
                        label: Text(time.format(context)),
                        onDeleted: () {
                          setState(() {
                            doseTimes.remove(time);
                          });
                        },
                      )),
                  _buildAddAppointmentButton(),
                ],
              ),
              const SizedBox(height: 20),
              _buildLabel("تاريخ البداية"),
              _buildDatePickerField(
                hint: startDate == null ? "اختر التاريخ" : "${startDate!.year}-${startDate!.month}-${startDate!.day}",
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 20),
              _buildLabel("تاريخ النهاية (اختياري)"),
              _buildDatePickerField(
                hint: endDate == null ? "اختر التاريخ" : "${endDate!.year}-${endDate!.month}-${endDate!.day}",
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _saveMedicine,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManger.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "حفظ الدواء",
                    style: StylesManger.white20Bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: StylesManger.black18Bold.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFF2F2F2)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }

  Widget _buildCounter() {
    return Container(
      width: 150,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFF2F2F2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (doseCount > 1) doseCount--;
              });
            },
            icon: const Icon(Icons.remove, color: Colors.grey, size: 20),
          ),
          Text(
            "$doseCount",
            style: StylesManger.black18Bold.copyWith(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                doseCount++;
              });
            },
            icon: const Icon(Icons.add, color: Colors.grey, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAppointmentButton() {
    return InkWell(
      onTap: () => _selectTime(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorsManger.primaryColor.withAlpha(50)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, color: ColorsManger.primaryColor, size: 20),
            const SizedBox(width: 8),
            Text(
              "إضافة موعد",
              style: StylesManger.black18Bold.copyWith(
                color: ColorsManger.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerField({required String hint, required VoidCallback onTap}) {
    return TextField(
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.calendar_today_outlined, color: Color(0xFFBDBDBD), size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFF2F2F2)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }
}
