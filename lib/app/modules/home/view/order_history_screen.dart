import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olympic/app/helpers/size_box.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/enums.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/app_router.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/shimmers.dart';
import '../../estore/model/get_order_histoy_model.dart';
import '../../estore/view model/estore_provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  EstoreProvider? estoreProvider;
  @override
  void initState() {
    super.initState();
    estoreProvider = context.read<EstoreProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        backgroundColor: AppConstants.black,
        title: const commonTextWidget(
          text: 'Order History',
          color: AppConstants.white,
          fontSize: 18,
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
      body: Consumer<EstoreProvider>(
        builder: (context, value, child) {
          return Container(
              padding: const EdgeInsets.all(15),
              height: Responsive.height * 100,
              width: Responsive.width * 100,
              child: estoreProvider?.getOrderHistoryStatus ==
                      GetOrderHistoryStatus.loading
                  ? const Column(
                      children: [
                        EstoreOrderHistoryContainer(),
                      ],
                    )
                  : estoreProvider?.getOrderHistoryStatus ==
                          GetOrderHistoryStatus.loaded
                      ? value.estoreOrderHistoryList.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  backgroundColor: AppConstants.drawerBgColor,
                                ),
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: AppConstants.appPrimaryColor,
                                  size: 22,
                                ),
                                SizeBoxH(Responsive.height * 2),
                                const commonTextWidget(
                                  color: AppConstants.white,
                                  text: "You haven't placed any orders yet",
                                  fontSize: 20,
                                ),
                              ],
                            )
                          : FutureBuilder(
                              future: estoreProvider?.getEstoreOrderHistory(),
                              builder: (context, snapshot) {
                                return ListView.separated(
                                  itemBuilder: (context, index) {
                                    final data = snapshot.data?.orders?[index];

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        commonTextWidget(
                                            color: AppConstants.white,
                                            text:
                                                "Order ID : ${data?.order?.id?.substring(10).toUpperCase()}"),
                                        SizeBoxH(Responsive.height * 1),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              data?.order?.items?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            final items =
                                                data?.order?.items?[index];

                                            return OrderHistoryContainer(
                                              historyData: items,
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizeBoxH(
                                                Responsive.height * 2);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizeBoxH(Responsive.height * 3);
                                  },
                                  itemCount: snapshot.data?.orders?.length ?? 0,
                                );
                              },
                            )
                      : const SizedBox.shrink());
        },
      ),
    );
  }
}

class OrderHistoryContainer extends StatelessWidget {
  final ItemElement? historyData;

  const OrderHistoryContainer({
    super.key,
    this.historyData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 15,
      width: Responsive.width * 100,
      decoration: BoxDecoration(
        color: AppConstants.drawerBgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          SizeBoxV(Responsive.width * 3),
          commonNetworkImage(
            url: historyData?.item?.images?.isEmpty == true
                ? "https://media.istockphoto.com/id/1392889736/vector/image-picture-warning-vector-illustration.jpg?s=612x612&w=0&k=20&c=d3TURZl8M-OJR0ndi6ItLcPSwBiY1GueoOkRU26__Ns="
                : historyData?.item?.images?[0].toString() ??
                    "https://media.istockphoto.com/id/1392889736/vector/image-picture-warning-vector-illustration.jpg?s=612x612&w=0&k=20&c=d3TURZl8M-OJR0ndi6ItLcPSwBiY1GueoOkRU26__Ns=",
            height: Responsive.height * 11,
            width: Responsive.width * 22,
          ),
          SizeBoxV(Responsive.width * 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizeBoxH(Responsive.height * 1),
                commonTextWidget(
                  color: AppConstants.white,
                  text: historyData?.item?.productName ?? "",
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
                commonTextWidget(
                  color: AppConstants.subTextGrey,
                  text: historyData?.item?.brand ?? "",
                  fontSize: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextWidget(
                      color: AppConstants.subTextGrey,
                      text:
                          "QTY-${historyData?.quantity}  Size-${historyData?.size}",
                      fontSize: 13,
                    ),
                    const commonTextWidget(
                      color: AppConstants.subTextGrey,
                      text: "Ordered Date",
                      fontSize: 13,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextWidget(
                      color: AppConstants.white,
                      text: "${historyData?.price} AED",
                      fontSize: 18,
                      // fontWeight: FontWeight.w600,
                    ),
                    commonTextWidget(
                      color: AppConstants.subTextGrey,
                      text: DateFormat("d-MMM-yy").format(
                          historyData?.item?.createdAt ?? DateTime.now()),
                      fontSize: 13,
                    ),
                  ],
                ),
                SizeBoxH(Responsive.height * .5),
              ],
            ),
          ),
          SizeBoxV(Responsive.width * 3),
        ],
      ),
    );
  }
}
