import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kthp_moblie/constants/constants.dart';
import 'package:kthp_moblie/constants/size_config.dart';
import 'package:kthp_moblie/provider/buyer_provider.dart';
import 'package:kthp_moblie/provider/home_provider.dart';
import 'package:kthp_moblie/provider/login_provider.dart';
import 'package:kthp_moblie/screens/pages/ListItem.dart';
import 'package:kthp_moblie/screens/pages/cart.dart';
import 'package:kthp_moblie/screens/pages/detail.dart';
import 'package:kthp_moblie/screens/pages/profile.dart';
import 'package:kthp_moblie/service/product.service.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({key});

  @override
  State<MyHome> createState() => _MyAppState();
}

class _MyAppState extends State<MyHome> {
  bool isProduct = false;
  int _currentIndex = 0;
  List<Widget> listPage = [
    HomeScreen(),
    CartPage(),
    ListItem(),
    ProfilePage()
  ];

  void GetListProducts() async{
    await context.read<HomeProvider>().getProducts().then((value) => {
      setState(() {
        isProduct = value;
      })
    });
    final authProvider = Provider.of<LoginProvider>(context, listen: false);
    final buyerProvider = Provider.of<BuyerProvider>(context, listen: false);
    await buyerProvider.getProducts(authProvider.user?.id);
  }

  @override
  void initState()  {
    super.initState();
    GetListProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: listPage[_currentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          height: 64,
          child: CustomNavigationBar(
            isFloating: true,
            borderRadius: const Radius.circular(40),
            selectedColor: kWhite,
            unSelectedColor: kGrey,
            backgroundColor: kBrown,
            strokeColor: Colors.transparent,
            scaleFactor: 0.1,
            iconSize: 40,
            items: [
              CustomNavigationBarItem(
                icon: _currentIndex == 0
                    ? SvgPicture.asset('assets/icons/home_icon_selected.svg')
                    : SvgPicture.asset('assets/icons/home_icon_unselected.svg'),
              ),
              CustomNavigationBarItem(
                icon: _currentIndex == 1
                    ? SvgPicture.asset('assets/icons/cart_icon_selected.svg')
                    : SvgPicture.asset('assets/icons/cart_icon_unselected.svg'),
              ),
              CustomNavigationBarItem(
                icon: _currentIndex == 2
                    ? SvgPicture.asset('assets/icons/favorite_icon_selected.svg')
                    : SvgPicture.asset('assets/icons/favorite_icon_unselected.svg'),
              ),
              CustomNavigationBarItem(
                icon: _currentIndex == 3
                    ? SvgPicture.asset('assets/icons/account_icon_selected.svg')
                    : SvgPicture.asset('assets/icons/account_icon_unselected.svg'),
              ),
            ],
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    "Tất cả",
    "Nữ",
    "Nam",
    "Đồng bộ",
  ];

  List<String> icons = [
    'all_items_icon',
    'dress_icon',
    'hat_icon',
    'watch_icon',
  ];

  List<String> images = [
    'image-01.png',
    'image-02.png',
    'image-03.png',
    'image-04.png',
    'image-05.jpg',
    'image-06.jpg',
    'image-07.jpg',
    'image-08.jpg',
  ];

  int current = 0;

  List<Product> listProducts = [];
  String search = "";

  void GetListProducts() async{
    final authProvider = Provider.of<HomeProvider>(context, listen: false);

    authProvider.getProducts().then((value) => {
      setState(() {
        listProducts = authProvider.listProduct;
      })
    });

  }

  void searchText(String text){
    final authProvider = Provider.of<HomeProvider>(context, listen: false);
    List<Product> newList = [];

    if(text.isEmpty || text==""){
      setState(() {
        listProducts = authProvider.listProduct;
      });
      return;
    }

    print(listProducts);

    authProvider.listProduct.forEach((item) {
      if(item.productName!.toLowerCase().contains(text.toLowerCase())){
        newList.add(item);
      }
    });
    print(newList);

    setState(() {
      search = text;
      listProducts = newList;
    });

  }

  final myTextSearch = TextEditingController();


  @override
  void initState()  {
    super.initState();
    GetListProducts();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello, Welcome 👋',
                      style: kEncodeSansRagular.copyWith(
                        color: kDarkBrown,
                        fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                      ),
                    ),
                    Text(
                      '${context.watch<LoginProvider>().user?.fullName}',
                      style: kEncodeSansBold.copyWith(
                        color: kDarkBrown,
                        fontSize: SizeConfig.blockSizeHorizontal! * 4,
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: kGrey,
                  backgroundImage: AssetImage(
                      'assets/images/image-01.png'),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingHorizontal,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: kEncodeSansRagular.copyWith(
                      color: kDarkGrey,
                      fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                    ),

                    onChanged: (value) {
                      searchText("$value");
                    },
                    controller: myTextSearch,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 13,
                      ),
                      prefixIcon: const IconTheme(
                        data: IconThemeData(
                          color: kDarkGrey,
                        ),
                        child: Icon(Icons.search),
                      ),
                      hintText: 'Sarch clothes...',
                      border: kInputBorder,
                      errorBorder: kInputBorder,
                      disabledBorder: kInputBorder,
                      focusedBorder: kInputBorder,
                      focusedErrorBorder: kInputBorder,
                      enabledBorder: kInputBorder,
                      hintStyle: kEncodeSansRagular.copyWith(
                        color: kDarkGrey,
                        fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 49,
                  width: 49,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    color: kBlack,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/filter_icon.svg',
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? kPaddingHorizontal : 15,
                      right: index == categories.length - 1
                          ? kPaddingHorizontal
                          : 0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: 36,
                    decoration: BoxDecoration(
                      color: current == index ? kBrown : kWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: current == index
                          ? null
                          : Border.all(
                        color: kLightGrey,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(current == index
                            ? 'assets/icons/${icons[index]}_selected.svg'
                            : 'assets/icons/${icons[index]}_unselected.svg'),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          categories[index],
                          style: kEncodeSansMedium.copyWith(
                            color: current == index ? kWhite : kDarkBrown,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          listProducts.length == 0 ? Padding(padding: EdgeInsets.only(top: 20), child: Center(child: Text("Item not thing ..."),),):
          MasonryGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 23,
            itemCount: listProducts.length,
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingHorizontal,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Detail(product: listProducts[index])));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(kBorderRadius),
                            child: Image.network(
                              '${listProducts[index].image}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/icons/favorite_cloth_icon_unselected.svg',
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${listProducts[index].productName}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: kEncodeSansSemibold.copyWith(
                        color: kDarkBrown,
                        fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                      ),
                    ),
                    Text(
                      '${listProducts[index].discription}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kEncodeSansRagular.copyWith(
                        color: kGrey,
                        fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${listProducts[index].price}',
                          style: kEncodeSansSemibold.copyWith(
                            color: kDarkBrown,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: kYellow,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '5.0',
                              style: kEncodeSansRagular.copyWith(
                                color: kDarkBrown,
                                fontSize: SizeConfig.blockSizeHorizontal! * 3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );

            },
          ),
        ],
      ),
    );
  }
}
