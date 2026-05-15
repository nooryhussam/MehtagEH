import 'package:mahtage_eh/features/Requester/data/model/id_model.dart';

abstract class IdState {}

class IdInitial extends IdState {}

class IdLoading extends IdState {}

class IdSuccess extends IdState {
  final IdResponse data;
  IdSuccess(this.data);
}

class IdError extends IdState {
  final String message;
  IdError(this.message);
}
