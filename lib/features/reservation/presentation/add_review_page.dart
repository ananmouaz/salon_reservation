import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:salon_reservation/core/api/core_models/message_response_model.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/core/utils/toast.dart';
import 'package:salon_reservation/core/widget/form/custom_text_field.dart';
import 'package:salon_reservation/features/home/presentation/pages/home_page.dart';
import 'package:salon_reservation/features/home/presentation/pages/main_page.dart';
import 'package:salon_reservation/features/reservation/data/review_request_model.dart';
import 'package:salon_reservation/features/reservation/domain/reservation_repo.dart';

import '../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/navigation.dart';
import '../../../core/widget/custom_button.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key, required this.businessId});

  final int businessId;

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  double _rating = 0.0;
  final _commentController = TextEditingController();

  late CreateModelCubit reviewCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            Height.v12,
            CustomTextField(
              controller: _commentController,
              hintText: 'Add a comment (optional)',
              labelText: 'Comment',
            ),
            Height.v12,
            CreateModel<MessageResponseModel>(
              onCubitCreated: (cubit) {
                reviewCubit = cubit;
              },
              repositoryCallBack: (data) => ReservationRepository.addReview(data),
              onSuccess: (model) async{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(model.message ?? '', style: AppStyles.body,),
                    backgroundColor: AppColors.green,
                  ),
                );
                Navigation.pushReplacement(context, const MainPage());
              },
              child: CustomButton(
                onTap: () {
                  if(_commentController.text != null && _rating != null) {
                    reviewCubit.createModel(
                        ReviewRequestModel(
                            review: _commentController.text,
                            stars: _rating.toInt(),
                            userId: 1,
                            businessId: widget.businessId)
                    );
                  }
                },
                text: 'Submit'.tr(),
                size: ButtonSize.small,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
