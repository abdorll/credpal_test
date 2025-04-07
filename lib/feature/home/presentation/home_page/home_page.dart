import 'package:credpaltest/core/theme/app_theme.dart';
import 'package:credpaltest/core/theme/colors.dart';
import 'package:credpaltest/core/util/app_constansts.dart';
import 'package:credpaltest/core/util/extensions.dart';
import 'package:credpaltest/core/widgets/app_button.dart';
import 'package:credpaltest/core/widgets/app_icon.dart';
import 'package:credpaltest/core/widgets/app_text.dart';
import 'package:credpaltest/core/widgets/app_text_field.dart';
import 'package:credpaltest/core/widgets/spacing.dart';
import 'package:credpaltest/feature/home/data/models/featured_marchants.dart';
import 'package:credpaltest/feature/home/data/models/products_models.dart';
import 'package:credpaltest/feature/home/presentation/home_page/home_page_controller.dart';
import 'package:credpaltest/feature/home/presentation/home_page/page_drawer.dart';
import 'package:credpaltest/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String homePage = "/homePage";
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    searchFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue productResponse = ref.watch(fetchProductsControllerProvider);
    AsyncValue marchantResponse = ref.watch(fetchMarchantsControllerProvider);
    ref.handleToast(
      context: context,
      provider: fetchProductsControllerProvider,
    );
    ref.handleToast(
      context: context,
      provider: fetchMarchantsControllerProvider,
    );
    List<ProductsModel> productData = [];
    if (productResponse is AsyncData) {
      productData = ref.watch(fetchProductsControllerProvider).value;
    }
    List<FeaturedMarchantsModel> marchantsData = [];
    if (marchantResponse is AsyncData) {
      marchantsData = ref.watch(fetchMarchantsControllerProvider).value;
    }
    return Scaffold(
      // appBar: AppBar(
      //   leading: Builder(
      //     builder: (context) {
      //       return InkWell(
      //         child: AppIcon(
      //           Icons.menu,
      //           color: AppColors.primaryColor,
      //           size: 30.sp,
      //         ),
      //         onTap: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //       );
      //     },
      //   ),
      //   title: AppText('Home', 18.sp, 7),
      //   centerTitle: true,
      //   backgroundColor: AppTheme.themeColor(context).scaffoldBackgroundColor,
      // ),
      drawer: DrawerWidget(),
      body: switch (ref.watch(fetchProductsControllerProvider) is AsyncData &&
          ref.watch(fetchMarchantsControllerProvider) is AsyncData) {
        true => Column(
          children: [
            headerSection(
              context,
            ), // entire blue container of "paylater text" and other items are in
            Expanded(
              child: scrollingBody(
                productResponse,
                productData,
                marchantsData,
              ), //scrolling searchfield with other arranged items
            ),
          ],
        ),
        _ => Center(
          child: switch (ref.watch(fetchProductsControllerProvider)
                  is AsyncLoading ||
              ref.watch(fetchMarchantsControllerProvider) is AsyncLoading) {
            true => CircularProgressIndicator(),
            _ => AppText('Something went wrong, try again', 20.sp, 5),
          },
        ),
      },
    );
  }

  final paylater = AppText(
    "Pay later everywhere",
    28.sp,
    9,
    align: TextAlign.left,
  );

  late TextEditingController searchFieldController;

  Container headerSection(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: 15.sp,
      vertical: 40.sp,
    ).add(EdgeInsets.only(top: 10.sp)),
    width: double.infinity,
    decoration: BoxDecoration(color: AppColors.primaryColorLite(context)),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  return InkWell(
                    child: AppIcon(
                      Icons.menu,
                      color: AppColors.primaryColor,
                      size: 30.sp,
                    ),
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: paylater.text,
                      style: paylater.textStyle(context),
                    ),
                    WidgetSpan(child: XMargin(10.sp)),
                    WidgetSpan(
                      child: Image.asset(
                        Assets.images.exclamation.path,
                        height: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                'Shopping limit: ${AppConsts.CURRENCY}0',
                12.sp,
                5,
                color:
                    AppTheme.isDarkTheme(context)
                        ? AppColors.grey1
                        : AppColors.darkBlue,
              ),
              YMargin(10.sp),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: 45.sp,
                    width: constraints.maxWidth * 0.85.sp,
                    child: AppButton(
                      text: 'Active Credit',
                      radius: 4.r,
                      buttonType: ButtonType.enabled,
                      onPressed: () {},
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );

  SingleChildScrollView scrollingBody(
    AsyncValue<dynamic> productResponse,
    List<ProductsModel> productsData,
    List<FeaturedMarchantsModel> marchantsData,
  ) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        searchField(),
        productsListing(productsData),
        featuredMarchants(marchantsData),
      ],
    ),
  );

  //card listing available products
  Container productsListing(List<ProductsModel> productsData) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.sp).add(EdgeInsets.only(left: 5.sp)),
      decoration: BoxDecoration(color: AppColors.primaryColorLite2(context)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: [
            SizedBox(
              width: 1.825.sw,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 9.sp,
                runSpacing: 9.sp,
                children: List.generate(productsData.length, (index) {
                  ProductsModel product = productsData[index];
                  return SizedBox(
                    width: 161.sp + 16.sp,
                    height: 174.sp + 20.sp,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Card(
                          color: AppTheme.colorScheme(context).onPrimary,
                          surfaceTintColor:
                              AppTheme.colorScheme(context).onPrimary,
                          child: Padding(
                            padding: EdgeInsets.all(
                              10.sp,
                            ).copyWith(top: 2.sp, bottom: 13.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth * 0.85,
                                      height: constraints.maxHeight * 0.6,
                                      child: Center(
                                        child: Image.network(product.mainImage),
                                      ),
                                    ),
                                    Card(
                                      shape: CircleBorder(),
                                      elevation: 0.5,
                                      shadowColor:
                                          AppTheme.isDarkTheme(context)
                                              ? AppColors.grey2
                                              : AppColors.grey1,
                                      child: CircleAvatar(
                                        radius: 25.sp,

                                        backgroundColor:
                                            AppTheme.colorScheme(
                                              context,
                                            ).onPrimary,
                                        child: Padding(
                                          padding: EdgeInsets.all(10.sp),
                                          child: Image.network(
                                            product.tagImage,
                                            // height: 50.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: AppText(
                                        product.name,
                                        14.sp,
                                        8,
                                        align: TextAlign.left,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      product.originalPrice,
                                      14.sp,
                                      8,
                                      color: AppColors.primaryColor,
                                    ),
                                    Expanded(
                                      child: AppText(
                                        product.discountedPrice,
                                        14.sp,
                                        8,
                                        color:
                                            AppTheme.isDarkTheme(context)
                                                ? AppColors.grey2
                                                : AppColors.grey1,
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2,
                                        align: TextAlign.right,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.sp),
              child: IconButton(
                onPressed: () {},
                icon: Container(
                  padding: EdgeInsets.all(20.sp),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColorLite(context),
                    borderRadius: BorderRadius.circular(400.r),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: Center(
                    child: AppIcon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 18.sp),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: AppTextField(
              controller: searchFieldController,
              hintText: 'Search for products or stores',
              prefixIcon: Image.asset(Assets.images.search.path, height: 20.sp),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox.square(
              dimension: 50.sp,
              child: IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Container(
                  margin: EdgeInsets.only(left: 15.sp),
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColors.primaryColorLite2(context),
                  ),
                  child: Image.asset(
                    Assets.images.scan.path,
                    height: 50.sp,
                    color: AppTheme.colorScheme(context).primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget featuredMarchants(List<FeaturedMarchantsModel> marchantsData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 30.sp),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText('Featured Merchants', 16.sp, 9),
              TextButton(
                onPressed: () {},
                child: AppText(
                  'View all',
                  12.sp,
                  5,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 0.35.sh,
            child: GridView.builder(
              padding: EdgeInsets.all(0).add(EdgeInsets.only(bottom: 20.sp)),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 105.sp,
                mainAxisSpacing: 0,
                crossAxisSpacing: 22,
                childAspectRatio: 0.8,
              ),
              itemCount: marchantsData.length,
              itemBuilder: (context, index) {
                FeaturedMarchantsModel marchant = marchantsData[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CircleAvatar(
                          radius: 30.sp,
                          backgroundImage: NetworkImage(marchant.imageUrl),
                        ),
                        marchant.isOnline == true
                            ? Positioned(
                              child: CircleAvatar(
                                radius: 8.sp,
                                backgroundColor:
                                    AppTheme.colorScheme(context).onPrimary,
                                child: CircleAvatar(
                                  radius: 5.sp,
                                  backgroundColor: AppColors.green,
                                ),
                              ),
                            )
                            : SizedBox.shrink(),
                      ],
                    ),
                    YMargin(5.sp),
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            marchant.name,
                            12.sp,
                            7,
                            align: TextAlign.center,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
