import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nutrition_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../data/models/food_item_model.dart';
import '../../../data/models/meal_model.dart';

class AddMealDialog extends StatefulWidget {
  const AddMealDialog({super.key});

  @override
  State<AddMealDialog> createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  final NutritionController controller = Get.find<NutritionController>();
  MealType selectedMealType = MealType.breakfast;
  final TextEditingController nameController = TextEditingController(
    text: 'Healthy Plate',
  );
  final List<FoodItemModel> selectedFoods = [];

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    int totalCals = 0;
    double totalP = 0;
    double totalC = 0;
    double totalF = 0;

    for (final f in selectedFoods) {
      totalCals += f.calories;
      totalP += f.proteinGrams;
      totalC += f.carbsGrams;
      totalF += f.fatGrams;
    }

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
          // Drag handle
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
                'Log New Meal',
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

          const SizedBox(height: 12),

          // Meal Type Selector Pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: MealType.values.map((type) {
                final isSelected = selectedMealType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(type.displayName),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() {
                        selectedMealType = type;
                        nameController.text = '${type.displayName} Bowl';
                      });
                    },
                    selectedColor: AppColors.accent,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.primaryDark
                          : (isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary),
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 12),

          // Meal Name
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Meal Name',
              hintText: 'e.g. Avocado Toast with Eggs',
              prefixIcon: Icon(Icons.restaurant_menu_rounded),
            ),
          ),

          const SizedBox(height: 12),

          // Macro Preview Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.lightCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMacroText(
                  'Calories',
                  '$totalCals kcal',
                  AppColors.caloriesOrange,
                ),
                _buildMacroText(
                  'Protein',
                  '${totalP.toStringAsFixed(1)}g',
                  AppColors.accent,
                ),
                _buildMacroText(
                  'Carbs',
                  '${totalC.toStringAsFixed(1)}g',
                  Colors.amber,
                ),
                _buildMacroText(
                  'Fat',
                  '${totalF.toStringAsFixed(1)}g',
                  AppColors.mindfulPurple,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Select Foods (${selectedFoods.length} added)',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),

          // Food Search
          TextField(
            onChanged: controller.onFoodSearchChanged,
            decoration: const InputDecoration(
              hintText: 'Search 20+ foods (oatmeal, salmon, egg...)',
              prefixIcon: Icon(Icons.search_rounded, size: 20),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Food items list
          Expanded(
            child: Obx(() {
              final list = controller.searchResults;
              return ListView.separated(
                itemCount: list.length,
                separatorBuilder: (ctx, i) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final food = list[index];
                  final isAdded = selectedFoods.any((f) => f.id == food.id);

                  return CustomCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        AppNetworkImage(
                          imageUrl: food.imageUrl,
                          width: 44,
                          height: 44,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                food.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${food.servingSize} • ${food.calories} kcal • P: ${food.proteinGrams}g',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isAdded
                                ? Icons.remove_circle_outline_rounded
                                : Icons.add_circle_outline_rounded,
                            color: isAdded ? AppColors.error : AppColors.accent,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isAdded) {
                                selectedFoods.removeWhere(
                                  (f) => f.id == food.id,
                                );
                              } else {
                                selectedFoods.add(food);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),

          const SizedBox(height: 12),

          // Log Meal Button
          CustomButton(
            text: 'Log ${selectedFoods.length} Items to Daily Plan',
            variant: ButtonVariant.accent,
            width: double.infinity,
            onPressed: selectedFoods.isEmpty
                ? null
                : () async {
                    await controller.logNewMeal(
                      name: nameController.text.trim().isEmpty
                          ? '${selectedMealType.displayName} Plate'
                          : nameController.text.trim(),
                      mealType: selectedMealType,
                      items: selectedFoods,
                    );
                    Get.back();
                    Get.snackbar(
                      'Meal Logged',
                      'Added ${selectedFoods.length} items to ${selectedMealType.displayName}!',
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

  Widget _buildMacroText(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
