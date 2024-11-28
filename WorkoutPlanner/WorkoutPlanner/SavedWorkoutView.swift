import SwiftUI

struct SavedWorkoutView: View {
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        NavigationView {
            List {
                if viewModel.savedWorkouts.isEmpty {
                    Text("No saved workouts").foregroundColor(.gray)
                } else {
                    ForEach(viewModel.savedWorkouts) { workout in
                        Section(header: Text(workout.name)) {
                            Text("Day: \(workout.day)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            ForEach(workout.exercises) { exercise in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(exercise.name)
                                        Text("\(exercise.sets) sets x \(exercise.reps) reps (\(exercise.weight) kg)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteWorkout)
                }
            }
            .navigationTitle("Saved Workouts")
            .toolbar {
                EditButton()
            }
        }
    }

    /// Deletes a workout from the saved list
    private func deleteWorkout(at offsets: IndexSet) {
        viewModel.savedWorkouts.remove(atOffsets: offsets)
    }
}
