import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:el_bershama/core/widgets/button_widget.dart';
import 'package:el_bershama/features/account/accountScreen.dart';
import 'package:el_bershama/features/alarm/alrmScreen.dart';
import 'package:el_bershama/features/medicine/medicien.dart';
import 'package:el_bershama/core/models/medicine_model.dart';
import 'package:el_bershama/features/newMdeicien/add_medic.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 3;

  void navigate(int index, BuildContext context) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AccountScreen()),
      ).then((_) => setState(() {})); // Refresh when returning
    } 
    else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AlarmScreen()),
      ).then((_) => setState(() {})); // Refresh when returning
    } 
    else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MedicineScreen()),
      ).then((_) => setState(() {})); // Refresh when returning
    }

    setState(() {
      currentIndex = index;
    });
  }

  Future<void> _navigateToAddMedicine() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddMedicineScreen()),
    );
    
    // Refresh the UI after returning from adding a medicine
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Use the global list instead of a local one
    final medicines = Medicine.savedMedicines;

    return Scaffold(
      backgroundColor: ColorsManger.withColor,

      appBar: AppBar(
        backgroundColor: ColorsManger.withColor,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.notifications_none, color: Colors.black),
            Text(
              'مرحبًا بك',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: ColorsManger.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'لا تنسَ دواءك',
                            style: StylesManger.white20Bold,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'نحن هنا لمساعدتك على تذكير مواعيد أدويتك',
                            style: StylesManger.white14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'images/bersham.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.medication, size: 80, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "أدويتي اليوم",
                style: StylesManger.black18Bold.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: medicines.isEmpty 
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.medication_liquid, size: 100, color: Colors.grey),
                        const SizedBox(height: 10),
                        Text("لا يوجد أدوية مضافة بعد", style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: medicines.length,
                    itemBuilder: (context, index) {
                      final med = medicines[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFE8F0FE),
                            child: Icon(Icons.medication, color: ColorsManger.primaryColor),
                          ),
                          title: Text(med.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("${med.dose} - ${med.dailyCount} جرعات يومياً"),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      );
                    },
                  ),
            ),

            const SizedBox(height: 20),

            ButtonWidget(
             onpress: _navigateToAddMedicine,
             text: "اضافة دواء جديد",
            )
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsManger.withColor,
        currentIndex: currentIndex,

        selectedItemColor: ColorsManger.primaryColor,
        unselectedItemColor: Colors.grey,

        onTap: (index) => navigate(index, context),

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "الحساب",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: "التنبيهات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: "الأدوية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),
        ],
      ),
    );
  }
}