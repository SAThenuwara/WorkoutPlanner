//
//  WorkoutPlannerApp.swift
//  WorkoutPlanner
//
//  Created by IM MAC-05 on 2024-11-20.
//

import SwiftUI

@main
struct WorkoutPlannerApp: App {
    @StateObject private var viewModel = WorkoutViewModel()
    var body: some Scene {
        WindowGroup {
            PlanWorkoutView()
                            .environmentObject(viewModel)
        }
    }
}
