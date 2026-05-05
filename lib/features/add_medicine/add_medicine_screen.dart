import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:el_bershama/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  int doseCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.withColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 40), // Spacer for centering title
            const Text(
              'إضافة دواء جديد',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Medicine Image with Camera Icon
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'images/bersham.png',
                          width: 100,
                          errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.medication, size: 80, color: ColorsManger.primaryColor),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xff7BA2F7), // Light blue from the camera button in image
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Medicine Name
              _buildLabel('اسم الدواء'),
              _buildTextField(hint: 'اكتب اسم الدواء'),

              // Dosage
              _buildLabel('الجرعة'),
              _buildTextField(hint: 'مثال: 500 مجم'),

              // Number of doses
              _buildLabel('عدد الجرعات يومياً'),
              Container(
                width: 150,
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add, color: ColorsManger.primaryColor),
                      onPressed: () => setState(() => doseCount++),
                    ),
                    Text('$doseCount', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.grey),
                      onPressed: () => setState(() {
                        if (doseCount > 1) doseCount--;
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Dose times
              _buildLabel('مواعيد الجرعات'),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18, color: ColorsManger.primaryColor),
                label: const Text('إضافة موعد', style: TextStyle(color: ColorsManger.primaryColor, fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xffE0E0E0)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Start Date
              _buildLabel('تاريخ البداية'),
              _buildDatePickerField(hint: 'اختر التاريخ'),

              // End Date
              _buildLabel('تاريخ النهاية (اختياري)'),
              _buildDatePickerField(hint: 'اختر التاريخ'),

              const SizedBox(height: 40),
              
              // Save Button
              Center(
                child: ButtonWidget(
                  onpress: () {},
                  text: 'حفظ الدواء',
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _buildTextField({required String hint}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xffBDBDBD), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }

  Widget _buildDatePickerField({required String hint}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: TextField(
        readOnly: true,
        textAlign: TextAlign.right,
        onTap: () {
          // Show date picker
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xffBDBDBD), fontSize: 14),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(right: 15, left: 10),
            child: Icon(Icons.calendar_today_outlined, color: Color(0xffBDBDBD), size: 20),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }
}
