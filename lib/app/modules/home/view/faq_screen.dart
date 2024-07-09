import 'package:flutter/material.dart';
import 'package:olympic/app/modules/home/model/faq_model.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../view model/home_provider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  HomeProvider? homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = context.read<HomeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.black,
        appBar: AppBar(
          backgroundColor: AppConstants.black,
          title: const commonTextWidget(
            color: AppConstants.white,
            text: "FAQ'S",
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const commonTextWidget(
                color: AppConstants.appPrimaryColor,
                text: "Frequently asked\n questions",
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              SizeBoxH(Responsive.height * 2),
              const commonTextWidget(
                color: AppConstants.subTextGrey,
                text: "Everything you need to know about Us",
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizeBoxH(Responsive.height * 2),
              Selector<HomeProvider, List<FAQ>>(
                selector: (context, faqProvider) => faqProvider.faqs,
                builder: (context, faqs, child) {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizeBoxH(Responsive.height * 2),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: faqs.length,
                    itemBuilder: (context, index) {
                      final faq = faqs[index];
                      return Card(
                        color: AppConstants.transparent,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            title: commonTextWidget(
                              text: faq.question,
                              color: AppConstants.white,
                              fontSize: 14,
                              align: TextAlign.start,
                            ),
                            onExpansionChanged: (bool expanded) {
                              context
                                  .read<HomeProvider>()
                                  .toggleExpansion(index);
                            },
                            backgroundColor: AppConstants.transparent,
                            trailing: Image.asset(
                              AppImages.addIconRound,
                              height: 30,
                            ),
                            initiallyExpanded: faq.isExpanded,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: commonTextWidget(
                                  text: faq.answer,
                                  color: AppConstants.white,
                                  fontSize: 14,
                                  align: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizeBoxH(Responsive.height * 2),
              const commonTextWidget(
                color: AppConstants.appPrimaryColor,
                text: "Let’s Be Social",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              SizeBoxH(Responsive.height * 2),
              const commonTextWidget(
                color: AppConstants.subTextGrey,
                text: "Contact through!",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              SizeBoxH(Responsive.height * 2),
              SizedBox(
                width: Responsive.width * 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonInkwell(
                      onTap: () => homeProvider
                          ?.launchUrl("https://www.facebook.com/olympiccombat"),
                      child: Image.asset(
                        AppImages.yellowFb,
                        height: 55,
                      ),
                    ),
                    SizeBoxV(Responsive.width * 5),
                    CommonInkwell(
                      onTap: () => homeProvider?.launchUrl(
                          "https://www.instagram.com/olympiccombat/"),
                      child: Image.asset(
                        AppImages.whiteInsta,
                        height: 55,
                      ),
                    ),
                    SizeBoxV(Responsive.width * 5),
                    CommonInkwell(
                      onTap: () => homeProvider
                          ?.launchUrl("https://www.youtube.com/@OlympicCombat"),
                      child: Image.asset(
                        AppImages.yellowYoutube,
                        height: 55,
                      ),
                    ),
                  ],
                ),
              ),
              SizeBoxH(Responsive.height * 2),
            ],
          ),
        ));
  }
}
