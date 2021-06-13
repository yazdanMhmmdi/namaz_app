part of 'ahkam_details_bloc.dart';

abstract class AhkamDetailsEvent extends Equatable {
  const AhkamDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetAhkamDetails extends AhkamDetailsEvent {
  String ahkam_id;
  GetAhkamDetails({@required this.ahkam_id});

  @override
  // TODO: implement props
  List<Object> get props => [this.ahkam_id];
}
