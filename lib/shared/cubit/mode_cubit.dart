import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_saver/shared/cubit/mode_state.dart';
import 'package:invoice_saver/utils/cached_data.dart';

class ModeCubit extends Cubit<ModeStates> {
  ModeCubit() : super(ModeInitialState());

  static ModeCubit getContext(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ModeChangeState());
      });
    } //end else
  } //end changeMode()
} //end class
