import SwiftUI

struct HomePageView: View {
    @State private var workoutSummary: String = "3 Workouts Completed"
    
    // Create an instance of WorkoutViewModel and WorkoutTimerViewModel
    @StateObject private var viewModel = WorkoutViewModel()
    @StateObject private var timerViewModel = WorkoutTimerViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Greeting
                Text("Welcome to Workout Planner!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                // Weekly Workout Summary
                VStack {
                    Text("This Week's Summary")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text(workoutSummary)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

                // Button to Plan New Workout
                NavigationLink(destination: PlanWorkoutView()
                                .environmentObject(viewModel)) {
                    Text("Plan New Workout")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)

                // Button to go to Workout Timer
                NavigationLink(destination: WorkoutTimerView(timerViewModel: timerViewModel)) {
                    Text("Start Workout Timer")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
