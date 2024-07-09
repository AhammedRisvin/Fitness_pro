import 'package:flutter/material.dart';
import 'package:olympic/app/utils/extensions.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_constants.dart';
import '../../widgets/doc_category_widget.dart';

class DocDepartmentsScreen extends StatelessWidget {
  const DocDepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const commonTextWidget(
          text: 'Find doctores',
          color: AppConstants.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () {
            Routes.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppConstants.white,
            size: 20,
          ),
        ),
      ),
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const commonTextWidget(
                text: 'Find doctores',
                color: AppConstants.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) => const DoctorCategoryWidget(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
