import 'package:flutter/material.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';

import '../../../../core/app_router.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../widgets/doctor_widget.dart';
import 'doc_filter_screen.dart';
import 'doctor_details_screen.dart';

class DoctorListByDepartmentScreen extends StatelessWidget {
  const DoctorListByDepartmentScreen({super.key});

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
                text: 'General physician',
                color: AppConstants.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              leadingWidth: 15,
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
                    56,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Responsive.width * 76,
                            height: 46,
                            decoration: ShapeDecoration(
                              color: AppConstants.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.67),
                              ),
                            ),
                            child: TextFormField(
                              controller: TextEditingController(),
                              onChanged: (value) {},
                              onFieldSubmitted: (value) {
                                // categoryWiseDoctorsController.doctorsSearchFn(
                                //     categoryId:
                                //         context.args["doctorCategoryId"].toString(),
                                //     enteredKeyword: value);
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search doctors',
                                contentPadding: EdgeInsets.only(top: 8),
                                hintStyle: TextStyle(
                                    color: Color(0xFF898A9E), fontSize: 14),
                                prefixIcon: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(Icons.search)),
                                ),
                              ),
                            ),
                          ),
                          CommonInkwell(
                            onTap: () {
                              Routes.push(screen: const DocFilterScreen());
                            },
                            child: Container(
                                width: Responsive.width * 12,
                                height: 46,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 19, vertical: 10),
                                decoration: ShapeDecoration(
                                  color: AppConstants.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Image.asset(
                                  AppImages.teleFilterIcon,
                                  color: AppConstants.black,
                                  fit: BoxFit.contain,
                                )),
                          )
                        ],
                      ))),
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
                  onTap: () => Routes.push(screen: const DocDetailsScreen()),
                  child: const DoctorWidget()),
              itemCount: 4,
              separatorBuilder: (context, index) => const SizeBoxH(10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ),
      ),
    );
  }
}
