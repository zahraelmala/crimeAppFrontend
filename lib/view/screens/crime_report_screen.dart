import 'package:a/constant/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/view_model/crime_report_controller.dart';

class CrimeReportScreen extends StatelessWidget {
  const CrimeReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CrimeReportController());

    return Obx(() {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ToggleButtons(
              constraints: const BoxConstraints(minHeight: 40, minWidth: 120),
              borderColor: Colors.red,
              selectedBorderColor: Colors.red,
              fillColor: Colors.red,
              selectedColor: Colors.white,
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              isSelected: [
                controller.isReportSelected.value,
                !controller.isReportSelected.value,
              ],
              onPressed: controller.toggleReportPost,
              children: const [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Report")),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Post")),
              ],
            ),
            const SizedBox(height: 20),
            controller.isReportSelected.value
                ? _buildReportForm(controller)
                : _buildPostForm(context, controller),
          ],
        ),
      );
    });
  }

  Widget _buildReportForm(CrimeReportController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: controller.notesController,
          decoration: InputDecoration(
            hintText: "Add notes",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(16),
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 24),
        Row(
          children: const [
            Icon(Icons.camera_alt, color: Colors.red, size: 28),
            SizedBox(width: 10),
            Text("Add photos / video", style: TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 24),
        Obx(() {
          return ToggleButtons(
            constraints: const BoxConstraints(minHeight: 45, minWidth: 140),
            borderColor: Colors.red,
            selectedBorderColor: Colors.red,
            fillColor: Colors.red,
            selectedColor: Colors.white,
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
            isSelected: [
              controller.isAnonymous.value,
              !controller.isAnonymous.value
            ],
            onPressed: controller.toggleAnonymous,
            children: const [Text("Anonymous"), Text("Your Name")],
          );
        }),
        const SizedBox(height: 16),
        Obx(() {
          return controller.isAnonymous.value
              ? const SizedBox.shrink()
              : TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                );
        }),
        const SizedBox(height: 32),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // TODO: Submit logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Submit",
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildPostForm(
      BuildContext context, CrimeReportController controller) {
    return GetBuilder<CrimeReportController>(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            controller.image == null
                ? Image.asset(
                    'assets/images/report.png',
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    controller.image!,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            // const SizedBox(height: 12),
            // TextField(
            //   controller: controller.directionController,
            //   decoration: const InputDecoration(labelText: 'Additional Direction'),
            // ),
            const SizedBox(height: 12),
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.selectDate(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(controller.formattedDate),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.selectTime(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Time',
                          prefixIcon: Icon(Icons.access_time),
                        ),
                        child: Text(controller.formattedTime(context)),
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 12),
            Obx(() {
              return DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Crime',
                  prefixIcon: Icon(Icons.report),
                ),
                value: controller.selectedCrime.value,
                onChanged: (value) => controller.selectedCrime.value = value,
                items: controller.crimes.map((crime) {
                  return DropdownMenuItem<String>(
                    value: crime,
                    child: Text(crime),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 12),
            TextField(
              controller: controller.postNotesController,
              decoration: const InputDecoration(labelText: 'Add Notes'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: context.width,
              child: ElevatedButton.icon(
                onPressed: controller.pickImage,
                icon: const Icon(Icons.camera_alt, color: Colors.red),
                label: const Text('Add photos / video',
                    style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await controller.createPost();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Center(
                child: controller.createPostState == FutureState.loading
                    ? CircularProgressIndicator()
                    : Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        );
      }
    );
  }
}
