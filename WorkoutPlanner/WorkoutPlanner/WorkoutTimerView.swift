import SwiftUI
import Combine

struct WorkoutTimerView: View {
    @ObservedObject var timerViewModel: WorkoutTimerViewModel

    var body: some View {
        VStack(spacing: 40) {
            // Workout Timer
            TimerCircle(
                timeRemaining: timerViewModel.workoutTimeRemaining,
                totalTime: 60,
                label: "Workout"
            )

            // Rest Timer
            TimerCircle(
                timeRemaining: timerViewModel.restTimeRemaining,
                totalTime: 30,
                label: "Rest"
            )

            HStack {
                // Start Workout Button
                Button(action: {
                    timerViewModel.startWorkoutTimer()
                }) {
                    Text("Start Workout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(timerViewModel.isWorkoutTimerActive || timerViewModel.isRestTimerActive)
                
                // Pause Button
                Button(action: {
                    timerViewModel.pauseTimer()
                }) {
                    Text("Pause")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // Reset Button
                Button(action: {
                    timerViewModel.resetWorkoutTimer()
                }) {
                    Text("Reset")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct WorkoutTimerView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTimerView(timerViewModel: WorkoutTimerViewModel()) // Add the model instance
    }
}
