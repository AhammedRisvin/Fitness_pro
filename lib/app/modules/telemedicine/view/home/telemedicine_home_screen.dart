import 'package:flutter/material.dart';
import 'package:olympic/app/modules/telemedicine/view/home/doc_department_screen.dart';
import 'package:olympic/app/utils/extensions.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../widgets/doc_category_widget.dart';
import '../../widgets/doctor_widget.dart';
import '../doctor/doctors_list_by_department.dart';

class TelemedicineHomeScreen extends StatelessWidget {
  const TelemedicineHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.black,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: AppConstants.black,
                title: const commonTextWidget(
                  text: '',
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
                // expandedHeight: 160,
                floating: true,
                snap: true,
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(
                      150,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const commonTextWidget(
                                text: 'Health hub',
                                color: AppConstants.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              CommonInkwell(
                                onTap: () => Routes.push(
                                    screen: const DocDepartmentsScreen()),
                                child: const commonTextWidget(
                                  text: 'View All',
                                  color: AppConstants.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 10),
                            height: Responsive.height * 12,
                            width: Responsive.width * 95,
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return const DoctorCategoryWidget();
                                },
                                separatorBuilder: (context, index) =>
                                    const SizeBoxV(10),
                                itemCount: 10),
                          ),
                        ],
                      ),
                    )),
                pinned: true,
              )
            ];
          },
          body: Container(
            height: Responsive.height * 100,
            width: Responsive.width * 100,
            margin: const EdgeInsets.all(16),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.separated(
                itemBuilder: (context, index) => CommonInkwell(
                    onTap: () => Routes.push(
                        screen: const DoctorListByDepartmentScreen()),
                    child: const DoctorWidget()),
                itemCount: 4,
                separatorBuilder: (context, index) => const SizeBoxH(10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          ),
        ));
  }
}
