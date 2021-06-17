part of 'narratives_details_bloc.dart';

abstract class NarrativesDetailsEvent extends Equatable {
  const NarrativesDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetNarrativesDetails extends NarrativesDetailsEvent {
  String narratives_id;
  GetNarrativesDetails({this.narratives_id});
  @override
  // TODO: implement props
  List<Object> get props => [this.narratives_id];
}
