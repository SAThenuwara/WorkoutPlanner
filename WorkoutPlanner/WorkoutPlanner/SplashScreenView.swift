import SwiftUI

struct SplashScreenView: View {
    @State private var showText = false
    @State private var showIcons = false
    @State private var showCircle = false
    @State private var navigateToHome = false  // State variable to trigger navigation
    
    var body: some View {
        NavigationView {
            ZStack {
                // Set the background color to green
                Color.green
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer() // Pushes content to the center vertically
                    
                    // Word "ENDURA" with a pop-up animation
                    Text("ENDURA")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .scaleEffect(showText ? 1 : 0.5) // Scale effect for pop-up animation
                        .opacity(showText ? 1 : 0) // Fade in the text
                        .animation(.easeIn(duration: 1.0), value: showText)
                        .onAppear {
                            showText = true
                        }
                    
                    if showIcons {
                        // Dumbbell and Running man icons with animation
                        HStack(spacing: 30) {
                            Image(systemName: "dumbbell.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .scaleEffect(showIcons ? 1 : 0.5)
                                .opacity(showIcons ? 1 : 0)
                                .animation(.easeIn(duration: 1.0).delay(1.5), value: showIcons)

                            Image(systemName: "figure.run")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .scaleEffect(showIcons ? 1 : 0.5)
                                .opacity(showIcons ? 1 : 0)
                                .animation(.easeIn(duration: 1.0).delay(1.5), value: showIcons)
                        }
                        .onAppear {
                            showIcons = true
                        }
                    }
                    
                    Spacer() // Pushes content to the center vertically
                }
                .onAppear {
                    // Trigger animation for the circle after the icons
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        showCircle = true
                    }
                }
                
                if showCircle {
                    // Circle encircling the word "ENDURA"
                    Circle()
                        .strokeBorder(Color.white, lineWidth: 4)
                        .frame(width: 300, height: 300)
                        .scaleEffect(showCircle ? 1 : 0.1) // Scale effect for circle
                        .opacity(showCircle ? 1 : 0) // Fade in the circle
                        .animation(.easeIn(duration: 1.0), value: showCircle)
                }
            }
            .onTapGesture {
                // Trigger the navigation by setting the state
                navigateToHome = true
            }
            
            // NavigationLink for transitioning to HomePageView
            NavigationLink(destination: HomePageView(), isActive: $navigateToHome) {
                EmptyView()
            }
            .opacity(0) // Hide the NavigationLink, so it doesn't show up on screen
        }
        .navigationBarHidden(true) // Hide the navigation bar on splash screen
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
            .previewDevice("iPhone 13") // Preview on a specific iPhone model
    }
}
