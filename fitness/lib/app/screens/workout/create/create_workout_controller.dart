import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:get/get.dart';
import 'package:formz/formz.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum CreateWorkoutRoute {
  NEW_WORKOUT_MAIN,
  NEW_WORKOUT_TYPE,
  NEW_WORKOUT_EXERCISE,
}

enum NewWorkoutError {
  TOO_LONG,
}

// Validation Field Class
class WorkoutName extends FormzInput<String, NewWorkoutError> {
  const WorkoutName.pure() : super.pure('');
  const WorkoutName.dirty([String value = '']) : super.dirty(value);

  @override
  NewWorkoutError? validator(String value) {
    if (value.length > 20) {
      return NewWorkoutError.TOO_LONG;
    }
    return null;
  }
}

class CreateWorkoutController extends GetxController {
  CreateWorkoutRoute route = CreateWorkoutRoute.NEW_WORKOUT_MAIN;
  WorkoutName name;
  int type;
  FormzStatus status;

  CreateWorkoutController({
    this.type = 1,
    this.name = const WorkoutName.pure(),
    this.status = FormzStatus.pure,
  });

  onNameChanged(String workoutName) {
    name = WorkoutName.dirty(workoutName);
    status = Formz.validate([name]);
    update();
  }

  close() {
    final panelController = SlidingPanelController.to;
    panelController.close();
    update();
  }
}
