import Foundation
import SwiftUI

/// Model representing an exercise
struct Exercise: Identifiable {
    let id = UUID() // Unique identifier for each exercise
    let name: String // Name of the exercise
    let sets: Int // Number of sets
    let reps: Int // Number of reps
    let weight: Int // Weight in kilograms
}

/// Model representing a workout which consists of a list of exercises
struct Workout: Identifiable {
    let id = UUID() // Unique identifier for each workout
    let name: String // Name of the workout
    let exercises: [Exercise] // List of exercises in the workout
    let day: String // Day of the week the workout is planned for
}

/// ViewModel to manage workout data across views
class WorkoutViewModel: ObservableObject {
    @Published var savedWorkouts: [Workout] = [] // List of saved workouts

    /// Add a new workout to the list
    func addWorkout(name: String, exercises: [Exercise], day: String) {
        let newWorkout = Workout(name: name, exercises: exercises, day: day)
        savedWorkouts.append(newWorkout) // Add the new workout to the list
    }

    /// Optional: Remove a workout by id (if needed)
    func removeWorkout(by id: UUID) {
        savedWorkouts.removeAll { $0.id == id }
    }
}
