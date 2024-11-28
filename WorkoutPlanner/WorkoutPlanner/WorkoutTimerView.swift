import SwiftUI

struct WorkoutTimerView: View {
    @ObservedObject var timerViewModel: WorkoutTimerViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Workout Timer")
                .font(.title)
                .padding()

            // Workout Timer
            Text("Workout Time Remaining: \(timerViewModel.workoutTimeRemaining) seconds")
                .font(.headline)

            Button(timerViewModel.isWorkoutTimerActive ? "Pause Timer" : "Start Timer") {
                if timerViewModel.isWorkoutTimerActive {
                    timerViewModel.pauseTimer()
                } else {
                    timerViewModel.startWorkoutTimer()
                }
            }
            .padding()
            .background(timerViewModel.isWorkoutTimerActive ? Color.red : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            // Rest Timer
            if timerViewModel.isRestTimerActive {
                Text("Rest Time Remaining: \(timerViewModel.restTimeRemaining) seconds")
                    .font(.headline)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Workout Timer")
    }
}

struct WorkoutTimerView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTimerView(timerViewModel: WorkoutTimerViewModel())
    }
}
