import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back & Notification Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  const Icon(Icons.notifications_none, size: 24),
                ],
              ),

              const SizedBox(height: 24),

              // Profile Info
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/images/pias.png'), // Replace with your asset
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Md G R Pias",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "ID: TG0642",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Work Type Selection
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select work type",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _WorkTypeRadio(label: "Home", selected: true),
                        const SizedBox(width: 16),
                        _WorkTypeRadio(label: "Onsite", selected: false),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Time Display
              const Text(
                "08 : 00 : 00 am",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A2542),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "16 April 2025, Thursday",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const Spacer(),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.login),
                    label: const Text("Check In"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      backgroundColor: const Color(0xFF002A51),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.face),
                    label: const Text("Face attendance"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(color: Color(0xFF002A51)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkTypeRadio extends StatelessWidget {
  final String label;
  final bool selected;

  const _WorkTypeRadio({
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<bool>(
          value: true,
          groupValue: selected,
          onChanged: (_) {},
        ),
        Text(label),
      ],
    );
  }
}
