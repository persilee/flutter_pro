import 'package:freezed_annotation/freezed_annotation.dart';

part 'details_params.freezed.dart';

@freezed
abstract class DetailsParams with _$DetailsParams {
  factory DetailsParams({
    @required int postId,
    @required int userId,
  }) = _DetailsParams;
}