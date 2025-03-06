import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:sprint4_fix/features/home/domain/repository/get_accelerometer_data.dart';
import 'package:sprint4_fix/features/home/domain/usecase/get_gyroscope_data.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/navbar_bloc/navbar_bloc_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/navbar_bloc/navbar_bloc_state.dart';

class NavbarBlocBloc extends Bloc<NavbarBlocEvent, NavbarBlocState> {
  final GetGyroscopeData getGyroscopeData;
  final GetAccelerometerData getAccelerometerData;
  StreamSubscription? _gyroSubscription;
  StreamSubscription? _accelSubscription;

  NavbarBlocBloc(this.getGyroscopeData, this.getAccelerometerData)
      : super(const NavbarInitial(0)) {
    // Handle manual page change
    on<ChangePageEvent>((event, emit) {
      emit(NavbarPageChanged(event.pageIndex));
    });

    // Handle gyroscope tilt
    on<GyroscopeTiltEvent>((event, emit) {
      print('Tilt: ${event.xTilt}');
      int newPage = state.selectedIndex;
      if (event.xTilt > 1.0 && newPage > 0) {
        newPage--;
      } else if (event.xTilt < -1.0 && newPage < 3) {
        newPage++;
      }
      print('New page from gyro: $newPage');
      emit(NavbarPageChanged(newPage));
    });

    // Handle accelerometer shake for logout
    on<AccelerometerShakeEvent>((event, emit) {
      print('Shake detected: ${event.magnitude}');
      if (event.magnitude > 15) {
        // Lowered threshold from 20 to 15 for sensitivity
        print('Logging out...');
        emit(const NavbarLogout());
      }
    });

    // Listen to gyroscope
    _gyroSubscription = getGyroscopeData().listen((event) {
      print('Gyro: x=${event.x}');
      add(GyroscopeTiltEvent(event.x));
    }, onError: (error) {
      print('Gyro error: $error');
    });

    // Listen to accelerometer
    _accelSubscription = getAccelerometerData().listen((event) {
      final magnitude =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      print('Accel: magnitude=$magnitude');
      add(AccelerometerShakeEvent(magnitude));
    }, onError: (error) {
      print('Accel error: $error');
    });
  }

  @override
  Future<void> close() {
    _gyroSubscription?.cancel();
    _accelSubscription?.cancel();
    return super.close();
  }
}
