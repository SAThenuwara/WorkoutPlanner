import SwiftUI

/// Model representing an exercise (renamed to WorkoutExercise to avoid conflicts)
struct WorkoutExercise: Identifiable {
    let id = UUID() // Unique identifier for each exercise
    var name: String // Name of the exercise (mutable)
    var sets: Int // Number of sets (mutable)
    var reps: Int // Number of reps (mutable)
    var weight: Int // Weight in kilograms (mutable)
}

struct EditExerciseSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State var exercise: WorkoutExercise // Use the renamed WorkoutExercise
    var onSave: (WorkoutExercise) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Details")) {
                    TextField("Exercise Name", text: $exercise.name)
                    Stepper("Sets: \(exercise.sets)", value: $exercise.sets, in: 1...10)
                    Stepper("Reps: \(exercise.reps)", value: $exercise.reps, in: 1...20)
                    Stepper("Weight: \(exercise.weight) kg", value: $exercise.weight, in: 0...200, step: 5)
                }
            }
            .navigationTitle("Edit Exercise")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(exercise)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct EditExerciseSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditExerciseSheet(
            exercise: WorkoutExercise(name: "Squats", sets: 3, reps: 10, weight: 50),
            onSave: { _ in }
        )
    }
}
