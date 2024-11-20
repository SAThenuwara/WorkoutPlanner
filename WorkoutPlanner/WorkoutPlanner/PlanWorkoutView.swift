import SwiftUI

struct PlanWorkoutView: View {
    @State private var exerciseName: String = ""
    @State private var sets: Int = 1
    @State private var reps: Int = 1
    @State private var weight: Int = 0
    @State private var workoutList: [String] = []
    
    // State for saving workout
    @State private var showSaveAlert: Bool = false
    @State private var workoutName: String = ""
    @State private var navigateToSavedWorkout: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Title
                Text("Plan Your Workout")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)

                // Input for Exercise Name
                TextField("Exercise Name", text: $exerciseName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                // Sets Input
                HStack {
                    Text("Sets:")
                    Spacer()
                    Stepper(value: $sets, in: 1...10) {
                        Text("\(sets)")
                    }
                }
                .padding(.horizontal)

                // Reps Input
                HStack {
                    Text("Reps:")
                    Spacer()
                    Stepper(value: $reps, in: 1...20) {
                        Text("\(reps)")
                    }
                }
                .padding(.horizontal)

                // Weight Input
                HStack {
                    Text("Weight (kg):")
                    Spacer()
                    Stepper(value: $weight, in: 0...200, step: 5) {
                        Text("\(weight) kg")
                    }
                }
                .padding(.horizontal)

                // Add Exercise Button
                Button(action: addExercise) {
                    Text("Add Exercise")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Workout List with Reorder
                List {
                    ForEach(workoutList.indices, id: \.self) { index in
                        HStack {
                            Text(workoutList[index])
                                .lineLimit(1)
                                .truncationMode(.tail)

                            Spacer()

                            // X Button for Deletion
                            Button(action: {
                                deleteExercise(at: index)
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onMove(perform: moveExercise)
                }
                .listStyle(PlainListStyle())
                .toolbar {
                    EditButton()
                }

                // Save Workout Button
                Button(action: {
                    showSaveAlert = true
                }) {
                    Text("Save Workout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .alert("Save Workout", isPresented: $showSaveAlert, actions: {
                    TextField("Enter Workout Name", text: $workoutName)
                    Button("Save", action: saveWorkout)
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("Enter a name for this workout.")
                })

                // Navigation Link to Saved Workout Page
                NavigationLink(destination: SavedWorkoutView(workoutName: workoutName, workoutList: workoutList),
                               isActive: $navigateToSavedWorkout) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Plan Workout")
        }
    }

    // Function to add an exercise
    private func addExercise() {
        guard !exerciseName.isEmpty else { return }
        let exercise = "\(exerciseName) - \(sets) sets x \(reps) reps @ \(weight) kg"
        workoutList.append(exercise)
        exerciseName = ""
        sets = 1
        reps = 1
        weight = 0
    }

    // Function to delete an exercise
    private func deleteExercise(at index: Int) {
        workoutList.remove(at: index)
    }

    // Function to reorder exercises
    private func moveExercise(from source: IndexSet, to destination: Int) {
        workoutList.move(fromOffsets: source, toOffset: destination)
    }

    // Function to save the workout
    private func saveWorkout() {
        guard !workoutName.isEmpty else { return }
        navigateToSavedWorkout = true
    }
}

struct SavedWorkoutView: View {
    let workoutName: String
    let workoutList: [String]

    var body: some View {
        VStack(spacing: 20) {
            Text(workoutName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            List(workoutList, id: \.self) { exercise in
                Text(exercise)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Saved Workout")
    }
}

struct PlanWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        PlanWorkoutView()
    }
}
