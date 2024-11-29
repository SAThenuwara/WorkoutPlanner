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
        startTimer(durationKeyPath: \.workoutTimeRemaining) {
            self.isWorkoutTimerActive = false
            self.startRestTimer() // Automatically start rest timer after workout
        }
    }

    // Start the rest timer
    func startRestTimer() {
        isRestTimerActive = true
        startTimer(durationKeyPath: \.restTimeRemaining) {
            self.isRestTimerActive = false
        }
    }

    // Start a generic timer for a given duration
    private func startTimer(durationKeyPath: ReferenceWritableKeyPath<WorkoutTimerViewModel, Int>, completion: @escaping () -> Void) {
        timer?.cancel() // Cancel any previous timer
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self[keyPath: durationKeyPath] > 0 {
                    self[keyPath: durationKeyPath] -= 1
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
