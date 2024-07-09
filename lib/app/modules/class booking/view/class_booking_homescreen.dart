import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/modules/class%20booking/view%20model/classbooking_provider.dart';
import 'package:olympic/app/modules/class%20booking/view/class_detaails_screen.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/enums.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../widget/calender_widget.dart';

class ClassBookingHomeScreen extends StatefulWidget {
  const ClassBookingHomeScreen({super.key});

  @override
  State<ClassBookingHomeScreen> createState() => _ClassBookingHomeScreenState();
}

class _ClassBookingHomeScreenState extends State<ClassBookingHomeScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClassBookingProvider>().selecteDateStringFn(DateTime.now());
      context
          .read<ClassBookingProvider>()
          .getAllClassesFn(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.drawerBgColor,
        title: const commonTextWidget(
          color: AppConstants.white,
          text: "Class Booking",
          fontSize: 18,
          // fontWeight: FontWeight.w600,
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
      body: Column(
        children: [
          const CalenderWidget(),
          SizeBoxH(Responsive.height * 2),
          Expanded(
            child: Consumer<ClassBookingProvider>(
              builder: (context, valueController, child) => valueController
                          .getAllClassesStatus ==
                      GetAllClassesStatus.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppConstants.appPrimaryColor,
                      ),
                    )
                  : valueController.classesModelList.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var data = valueController.classesModelList[index];

                            return ListView.separated(
                              itemCount: data.slotes?.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  SizeBoxH(Responsive.height * 2),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index2) {
                                var slot = data.slotes?[index2];
                                return CommonInkwell(
                                  onTap: () {
                                    Routes.push(
                                        screen: ClassDetailsScreen(
                                      slote: slot,
                                      classesWithSlote: data,
                                    ));
                                  },
                                  child: Container(
                                    height: Responsive.height * 15,
                                    width: Responsive.width * 100,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppConstants.drawerBgColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        children: [
                                          commonNetworkImage(
                                            height: Responsive.height * 13,
                                            width: Responsive.width * 26,
                                            url: data.classData?.image?.url ??
                                                "http://via.placeholder.com/200x150",
                                          ),
                                          SizeBoxV(Responsive.width * 4),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                commonTextWidget(
                                                  color: AppConstants.white,
                                                  text:
                                                      "${data.classData?.ageCategory?.fromAge ?? ""}-${data.classData?.ageCategory?.toAge ?? ""}",
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                commonTextWidget(
                                                  color: AppConstants.white,
                                                  text:
                                                      "${valueController.convertUtcToLocalTime(slot?.time?.startTime ?? "")} - ${valueController.convertUtcToLocalTime(slot?.time?.endTime ?? "")}",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                commonTextWidget(
                                                  maxLines: 1,
                                                  color: AppConstants.white,
                                                  text: data.classData
                                                          ?.classType ??
                                                      "",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                commonTextWidget(
                                                  maxLines: 1,
                                                  color: AppConstants
                                                      .appPrimaryColor,
                                                  text:
                                                      "${(data.classData?.availableSloteCount ?? 0) - (slot?.availableSlote ?? 0)}/${data.classData?.availableSloteCount ?? ""} available slot",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizeBoxH(Responsive.height * 2);
                          },
                          itemCount: valueController.classesModelList.length,
                        )
                      : SizedBox(
                          height: Responsive.height * 50,
                          width: Responsive.width * 100,
                          child: Center(
                              child: Image.asset(
                            AppImages.noData,
                            height: Responsive.height * 20,
                          )),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
