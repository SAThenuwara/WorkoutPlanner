import SwiftUI
import Combine

class WorkoutTimerViewModel: ObservableObject {
    @Published var workoutTimeRemaining: Int = 60  // Default workout time in seconds
    @Published var restTimeRemaining: Int = 30     // Default rest time in seconds
    @Published var isWorkoutTimerActive = false    // Is workout timer running
    @Published var isRestTimerActive = false       // Is rest timer running

    private var timer: AnyCancellable?

    // Start the workout timer
    func startWorkoutTimer() {
        isWorkoutTimerActive = true
        startTimer(duration: $workoutTimeRemaining) {
            self.isWorkoutTimerActive = false
            self.startRestTimer() // Automatically start rest timer after workout
        }
    }

    // Start the rest timer
    func startRestTimer() {
        isRestTimerActive = true
        startTimer(duration: $restTimeRemaining) {
            self.isRestTimerActive = false
        }
    }

    // Start a generic timer for a given duration
    private func startTimer(duration: Binding<Int>, completion: @escaping () -> Void) {
        timer?.cancel() // Cancel any previous timer
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if duration.wrappedValue > 0 {
                    duration.wrappedValue -= 1
                } else {
                    self.timer?.cancel()
                    completion()
                }
            }
    }

    // Pause the currently running timer
    func pauseTimer() {
        timer?.cancel()
    }

    // Reset both workout and rest timers
    func resetWorkoutTimer() {
        pauseTimer()
        workoutTimeRemaining = 60
        restTimeRemaining = 30
        isWorkoutTimerActive = false
        isRestTimerActive = false
    }
}
