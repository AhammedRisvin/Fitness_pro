import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class FavAndCartWidgets extends StatelessWidget {
  final bool isCart;
  final bool isCheckOut;
  const FavAndCartWidgets(
      {this.isCheckOut = false, this.isCart = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppConstants.searchColor,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(9),
      child: Row(
        children: [
          SizeBoxV(Responsive.width * 2),
          Container(
            width: Responsive.width * 26,
            height: Responsive.height * 14,
            decoration: BoxDecoration(
                color: const Color(0xff161616),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3333330D),
                    offset: Offset(4, 4),
                    blurRadius: 26,
                    spreadRadius: 0,
                  ),
                ]),
            child: commonNetworkImage(
              url: '',
              height: Responsive.height * 14,
              width: Responsive.width * 26,
            ),
          ),
          SizeBoxV(Responsive.width * 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const commonTextWidget(
                    color: AppConstants.white,
                    text: 'Amlodipine tablets',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  SizeBoxV(Responsive.width * 13),
                  isCart
                      ? CommonInkwell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // AlertDialog widget is used to create the dialog
                                return AlertDialog(
                                  title: const commonTextWidget(
                                    color: AppConstants.black,
                                    text: 'Remove item?',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  content: const commonTextWidget(
                                    color: AppConstants.black,
                                    text:
                                        'Are you sure yow want to remove thisitem?',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    align: TextAlign.start,
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CommonButton(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {},
                                          text: 'Cancel',
                                          width: Responsive.width * 30,
                                          height: Responsive.height * 5,
                                          bgColor: AppConstants.white,
                                          borderColor: AppConstants.black,
                                        ),
                                        CommonButton(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {},
                                          text: 'Cancel',
                                          textColor: AppConstants.white,
                                          width: Responsive.width * 30,
                                          height: Responsive.height * 5,
                                          bgColor: const Color(0xffFF4242),
                                          borderColor: const Color(0xffFF4242),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xffF44336),
                            child: Icon(
                              Icons.delete,
                              color: AppConstants.white,
                            ),
                          ),
                        )
                      : isCheckOut
                          ? const SizedBox.shrink()
                          : const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                ],
              ),
              SizeBoxH(Responsive.height * 2),
              const commonTextWidget(
                color: AppConstants.white,
                text: 'used to treat high blood pressure \n(hypertension).',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                overFlow: TextOverflow.clip,
                align: TextAlign.start,
              ),
              SizeBoxH(Responsive.height * 2),
              Row(
                children: [
                  const commonTextWidget(
                    color: AppConstants.appPrimaryColor,
                    text: 'AED 57.75',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  isCart || isCheckOut
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizeBoxV(Responsive.width * 6),
                            Container(
                              width: Responsive.width * 7,
                              height: Responsive.height * 3.5,
                              decoration: BoxDecoration(
                                  color: AppConstants.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(
                                Icons.remove,
                                color: AppConstants.white,
                              ),
                            ),
                            SizeBoxV(Responsive.width * 3),
                            const commonTextWidget(
                              color: AppConstants.white,
                              text: '1',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            SizeBoxV(Responsive.width * 3),
                            Container(
                              width: Responsive.width * 7,
                              height: Responsive.height * 3.5,
                              decoration: BoxDecoration(
                                  color: AppConstants.appPrimaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(
                                Icons.add,
                                color: AppConstants.black,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
