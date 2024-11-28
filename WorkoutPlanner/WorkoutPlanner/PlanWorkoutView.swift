import SwiftUI

struct PlanWorkoutView: View {
    @ObservedObject var viewModel = WorkoutViewModel()
    @State private var workoutName = ""
    @State private var selectedDay = "Monday"
    @State private var exerciseName = ""
    @State private var sets = 1
    @State private var reps = 1
    @State private var weight = 0
    @State private var exercises: [Exercise] = []
    @State private var showSavedWorkouts = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // Section for workout details
                    Section(header: Text("Workout Details")) {
                        TextField("Workout Name", text: $workoutName)
                        Picker("Day", selection: $selectedDay) {
                            ForEach(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], id: \.self) { day in
                                Text(day)
                            }
                        }
                    }

                    // Section for adding exercises
                    Section(header: Text("Add Exercise")) {
                        TextField("Exercise Name", text: $exerciseName)
                        Stepper("Sets: \(sets)", value: $sets, in: 1...10)
                        Stepper("Reps: \(reps)", value: $reps, in: 1...20)
                        Stepper("Weight: \(weight) kg", value: $weight, in: 0...200, step: 5)

                        Button("Add Exercise") {
                            addExercise()
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(exerciseName.isEmpty)
                    }

                    // Section displaying added exercises
                    Section(header: Text("Exercises")) {
                        if exercises.isEmpty {
                            Text("No exercises added").foregroundColor(.gray)
                        } else {
                            ForEach(exercises) { exercise in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(exercise.name).bold()
                                        Text("\(exercise.sets) sets x \(exercise.reps) reps (\(exercise.weight) kg)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .onDelete(perform: deleteExercise)
                        }
                    }
                }

                // Save and View buttons
                HStack {
                    Button("Save Workout") {
                        saveWorkout()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(workoutName.isEmpty || exercises.isEmpty)
                    .padding()

                    Button("View Saved Workouts") {
                        showSavedWorkouts.toggle()
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    .sheet(isPresented: $showSavedWorkouts) {
                        SavedWorkoutView(viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("Plan Workout")
            .navigationBarItems(trailing: EditButton()) // Enable deletion of exercises
        }
    }

    // MARK: - Helper Methods

    private func addExercise() {
        let newExercise = Exercise(name: exerciseName, sets: sets, reps: reps, weight: weight)
        exercises.append(newExercise)
        clearExerciseFields()
    }

    private func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    private func saveWorkout() {
        viewModel.addWorkout(name: workoutName, exercises: exercises, day: selectedDay)
        clearWorkoutFields()
    }

    private func clearExerciseFields() {
        exerciseName = ""
        sets = 1
        reps = 1
        weight = 0
    }

    private func clearWorkoutFields() {
        workoutName = ""
        exercises.removeAll()
    }
}

// MARK: - Preview

struct PlanWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        PlanWorkoutView(viewModel: WorkoutViewModel())
    }
}


























