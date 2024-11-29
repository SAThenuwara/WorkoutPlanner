//
//  JoggingView.swift
//  WorkoutPlanner
//
//  Created by IM Student on 2024-11-29.
//

import SwiftUI
import MapKit
import CoreLocation

struct JoggingView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .onAppear {
                    locationManager.requestPermission()
                }
            VStack {
                Spacer()
                Text("Jogging Route")
                    .font(.headline)
                    .padding()
            }
        }
        .navigationTitle("Jogging")
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}


#Preview {
    JoggingView()
}
