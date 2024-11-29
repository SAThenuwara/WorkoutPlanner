import SwiftUI

struct HomePageView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    @StateObject private var timerViewModel = WorkoutTimerViewModel()
    
    // Animation states
    @State private var showTitle = false
    @State private var showSlogan = false
    @State private var showButtons = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Green background color
                Color.green
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Spacer to push content to the center vertically
                    Spacer()
                    
                    // Title: "Endura"
                    Text("ENDURA")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .scaleEffect(showTitle ? 1 : 0.5) // Scale effect for pop-up animation
                        .opacity(showTitle ? 1 : 0) // Fade in the text
                        .animation(.easeIn(duration: 1.0), value: showTitle)
                        .onAppear {
                            showTitle = true
                        }
                    
                    // Slogan: "Plan. Train. Achieve."
                    Text("Plan. Train. Achieve.")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(showSlogan ? 1 : 0) // Fade in with animation
                        .animation(.easeIn(duration: 1.2).delay(0.5), value: showSlogan)
                        .onAppear {
                            showSlogan = true
                        }

                    Spacer()

                    // Buttons container
                    VStack(spacing: 20) {
                        if showButtons {
                            // Button to Plan New Workout
                            NavigationLink(destination: PlanWorkoutView().environmentObject(viewModel)) {
                                Text("Plan New Workout")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .scaleEffect(showButtons ? 1 : 0.5)
                                    .opacity(showButtons ? 1 : 0)
                                    .animation(.easeIn(duration: 0.8).delay(1.5), value: showButtons) // Delay added here
                            }
                            .padding(.horizontal, 20)

                            // Button to go to Workout Timer with a different color
                            NavigationLink(destination: WorkoutTimerView(timerViewModel: timerViewModel)) {
                                Text("Start Workout Timer")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.purple) // Changed color to purple
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .scaleEffect(showButtons ? 1 : 0.5)
                                    .opacity(showButtons ? 1 : 0)
                                    .animation(.easeIn(duration: 0.8).delay(1.7), value: showButtons) // Delay added here
                            }
                            .padding(.horizontal, 20)

                            // Button to start Jogging
                            NavigationLink(destination: JoggingView()) {
                                Text("Start Jogging")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .scaleEffect(showButtons ? 1 : 0.5)
                                    .opacity(showButtons ? 1 : 0)
                                    .animation(.easeIn(duration: 0.8).delay(1.9), value: showButtons) // Delay added here
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    // Trigger the appearance of the buttons after the title and slogan animations
                    withAnimation {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            showButtons = true
                        }
                    }
                }
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
