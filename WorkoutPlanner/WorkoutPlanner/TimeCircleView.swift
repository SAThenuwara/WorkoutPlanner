import SwiftUI

struct TimerCircle: View {
    let timeRemaining: Int      // Remaining time in seconds
    let totalTime: Int          // Total time for the timer in seconds
    let label: String           // Label for the timer (e.g., "Workout" or "Rest")

    var body: some View {
        ZStack {
            // Background circle (gray)
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)

            // Foreground circle showing progress
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(progressColor, lineWidth: 10)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)

            // Timer Label and Remaining Time
            VStack {
                Text(label)
                    .font(.headline)
                    .foregroundColor(progressColor)
                Text("\(timeRemaining) sec")
                    .font(.title)
                    .bold()
            }
        }
        .padding(20)
        .frame(width: 150, height: 150)
    }

    // Progress as a percentage of the total time
    private var progress: CGFloat {
        CGFloat(timeRemaining) / CGFloat(totalTime)
    }

    // Dynamic color based on progress (green for more time, red for less time)
    private var progressColor: Color {
        if progress > 0.5 {
            return .green
        } else if progress > 0.2 {
            return .orange
        } else {
            return .red
        }
    }
}
