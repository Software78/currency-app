import 'package:bloc/bloc.dart';
import 'package:currency_app/models/response_model.dart';
import 'package:currency_app/services/repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/request_model.dart';

part 'timeseries_event.dart';
part 'timeseries_state.dart';

class TimeseriesBloc extends Bloc<TimeseriesEvent, TimeseriesState> {
  TimeseriesBloc() : super(TimeseriesLoading()) {
    on<LoadTimeSeries>((event, emit) => _loadTimeSeries(event, emit));
  }

  _loadTimeSeries(LoadTimeSeries event, emit) async {
    emit(TimeseriesLoading());
    TimeSeriesResponse response =
        await Repository.instance.loadTimeSeriesData(event.model.currency);
    response.status
        ? emit(TimeSeriesLoaded(data: response.data!))
        : emit(TimeSeriesError(message: response.message!));
  }
}
