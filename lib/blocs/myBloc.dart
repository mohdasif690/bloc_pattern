import 'package:flutter_bloc/flutter_bloc.dart';

class MyCubit extends Cubit<int>{
  MyCubit():super(0);

  void changePage(int value) => emit(state + 1);
}