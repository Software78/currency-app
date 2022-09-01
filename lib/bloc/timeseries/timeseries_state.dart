part of 'timeseries_bloc.dart';

abstract class TimeseriesState extends Equatable {
  const TimeseriesState();

  @override
  List<Object> get props => [];
}

class TimeseriesLoading extends TimeseriesState {}

class TimeSeriesLoaded extends TimeseriesState {
  final Map<String, dynamic> data;

  const TimeSeriesLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class TimeSeriesError extends TimeseriesState {
  final String message;

  const TimeSeriesError({required this.message});

  @override
  List<Object> get props => [message];
}
