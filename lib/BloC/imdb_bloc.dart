import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Repository/Api/IMDb/IMDbAPi.dart';
import '../Repository/ModelClass/IMDbModel.dart';


part 'imdb_event.dart';
part 'imdb_state.dart';

class ImdbBloc extends Bloc<ImdbEvent, ImdbState> {
  IMDbApi imDbApi= IMDbApi();
  late ImDbModel imDbModel;
  ImdbBloc() : super(ImdbInitial()) {
    on<FetchImdb>((event, emit) async {

      emit(ImdbBlocLoading());
      try{
        imDbModel = await imDbApi.getIMDb();
        emit(ImdbBlocLoaded());
      }catch(e){
        print(e);
        emit(ImdbBlocError());
      }
    });
  }
}
