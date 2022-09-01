part of 'timeseries_bloc.dart';

abstract class TimeseriesEvent extends Equatable {
  const TimeseriesEvent();

  @override
  List<Object> get props => [];
}

class LoadTimeSeries extends TimeseriesEvent {
  final TimeSeriesRequestModel model;

  const LoadTimeSeries({required this.model});

  @override
  List<Object> get props => [model];
}
