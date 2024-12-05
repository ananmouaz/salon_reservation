import 'package:geolocator/geolocator.dart';
import 'package:salon_reservation/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/features/category/domain/shop_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/di.dart';
import '../../../../core/utils/shared_perefrences/shared_perefrences_helper.dart';
import '../../../../core/widget/base_page.dart';
import '../../../salon/data/model/salon_model.dart';
import '../../../salon/presentation/widget/salon_card.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key,});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PaginationCubit? salonsCubit;

  static final AppPreferences _appPreferences = instance<AppPreferences>();

  bool isLoading = true;
  //late GetModelCubit salonsCubit;

  // Inside your function or widget
  void _getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      _getCurrentLocation();
    }
    // Handle other cases as per your requirement
  }

  // Inside your function or widget
  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _appPreferences.setLatitude(position.latitude.toString());
    _appPreferences.setLongitude(position.longitude.toString());
    salonsCubit?.getList();
    print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  int? _value = 0;

  List<String> types = ['Hair', 'Makeup', 'Nails', 'Eyelashes', 'Tattoo'];

  String query = '';

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isCentered: false,
      title: 'salons'.tr(),
      isScrollable: false,
      hasMenu: true,
      hasPadding: false,
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal:  10.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                  salonsCubit?.getList();
                },
                decoration: InputDecoration(
                    hintText: 'search...'.tr(),
                    border: InputBorder.none,
                    hintStyle: AppStyles.title
                ),
              ),
            ),
          ),
     /*     TextButton(onPressed: () {


          }, child: Text('test')),*/
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 40,
            child: ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) {
                return Width.v8;
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return ChoiceChip(
                  autofocus: true,
                  selectedColor: AppColors.primary,
                  label: Text(types[index].tr(), style: AppStyles.body,),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        // Move the selected choice to the beginning of the list
                        types.insert(0, types.removeAt(index));
                        _value = 0;
                      } else {
                        _value = null;
                      }
                    });
                    _scrollToBeginning();
                    salonsCubit?.getList();
                  },
                );
              },
              itemCount: types.length,
            ),
          ),
          Height.v12,
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: PaginationList<SalonModel>(
                onCubitCreated: (cubit) {
                  salonsCubit = cubit;
                },
                repositoryCallBack: (data) => SalonRepository.getSalons(data, types[_value ?? 0], _appPreferences.getLatitude(), _appPreferences.getLongitude(), query),
                listBuilder: (model) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return SalonCard(salon: model[index]);
                      },
                      separatorBuilder: (context, _) {
                        return Height.v4;
                      },
                      itemCount: model.length);
                  Text(model[0].name ?? '');
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  // Add this function to scroll back to the beginning
  void _scrollToBeginning() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500), // You can adjust the duration as needed
      curve: Curves.easeInOut,
    );
  }
}



class SalonsList extends StatelessWidget {
  const SalonsList({
    super.key,
    required this.salons,
  });

  final SalonsResponseModel? salons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320.h,
      child: (salons?.list ?? []).isEmpty
          ? const SizedBox.shrink()
          : Container(
        height: 240.h,
        margin: const EdgeInsets.only(left: 15.0),
        child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Width.v16;
            },
            scrollDirection: Axis.horizontal,
            itemCount: salons?.list.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                margin:
                EdgeInsets.only(bottom: Guides.v12),
                child: SalonCard(
                  salon: salons?.list[index] ?? SalonModel(),
                ),
              );
            }),
      ),
    );
  }
}


