import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final ProfileController controller = Get.find<ProfileController>();

  late TextEditingController nameCtrl;
  late TextEditingController ageCtrl;
  late TextEditingController heightCtrl;
  late TextEditingController weightCtrl;
  String selectedFitnessLevel = 'Intermediate';
  String selectedGoal = 'Muscle Tone & Endurance';
  String selectedUnits = 'Metric';

  @override
  void initState() {
    super.initState();
    final p = controller.userProfile.value;
    nameCtrl = TextEditingController(text: p?.name ?? 'Alex Morgan');
    ageCtrl = TextEditingController(text: '${p?.age ?? 28}');
    heightCtrl = TextEditingController(text: '${p?.heightCm ?? 178.0}');
    weightCtrl = TextEditingController(text: '${p?.weightKg ?? 72.5}');
    selectedFitnessLevel = p?.fitnessLevel ?? 'Intermediate';
    selectedGoal = p?.fitnessGoal ?? 'Muscle Tone & Endurance';
    selectedUnits = p?.unitSystem ?? 'Metric';
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    ageCtrl.dispose();
    heightCtrl.dispose();
    weightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBg : AppColors.lightBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit Profile & Metrics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ageCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Age (Years)',
                            prefixIcon: Icon(Icons.cake_rounded),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: heightCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Height (cm)',
                            prefixIcon: Icon(Icons.height_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: weightCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                      prefixIcon: Icon(Icons.monitor_weight_rounded),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: selectedFitnessLevel,
                    decoration: const InputDecoration(
                      labelText: 'Fitness Level',
                      prefixIcon: Icon(Icons.speed_rounded),
                    ),
                    items: ['Beginner', 'Intermediate', 'Advanced']
                        .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => selectedFitnessLevel = val);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: selectedGoal,
                    decoration: const InputDecoration(
                      labelText: 'Primary Fitness Goal',
                      prefixIcon: Icon(Icons.track_changes_rounded),
                    ),
                    items:
                        [
                              'Weight Loss',
                              'Muscle Tone & Endurance',
                              'Cardiovascular Health',
                              'Flexibility & Mobility',
                              'General Wellness',
                            ]
                            .map(
                              (g) => DropdownMenuItem(value: g, child: Text(g)),
                            )
                            .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => selectedGoal = val);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: selectedUnits,
                    decoration: const InputDecoration(
                      labelText: 'Unit System',
                      prefixIcon: Icon(Icons.straighten_rounded),
                    ),
                    items: ['Metric', 'Imperial']
                        .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => selectedUnits = val);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Save Changes',
            variant: ButtonVariant.accent,
            width: double.infinity,
            onPressed: () async {
              await controller.updateProfile(
                name: nameCtrl.text.trim(),
                age: int.tryParse(ageCtrl.text) ?? 28,
                heightCm: double.tryParse(heightCtrl.text) ?? 178.0,
                weightKg: double.tryParse(weightCtrl.text) ?? 72.5,
                fitnessLevel: selectedFitnessLevel,
                fitnessGoal: selectedGoal,
                unitSystem: selectedUnits,
              );
              Get.back();
              Get.snackbar(
                'Profile Updated',
                'Your metrics have been successfully saved.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primary,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
            },
          ),
        ],
      ),
    );
  }
}
