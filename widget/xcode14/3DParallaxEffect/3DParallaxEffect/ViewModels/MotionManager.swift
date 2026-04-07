//
//  MotionManager.swift
//  3DParallaxEffect
//
//  Created by mark on 2025-04-10.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    // MARK: Motion Manager Properties
    @Published var manager: CMMotionManager = .init()
    @Published var xValue: CGFloat = 0
    @Published var currentSlide: Place = sample_places.first!
    
    func detectMotion() {
        if !manager.isDeviceMotionActive {
            // MARK: For Memory Usage
            // I'm limiting it to 40 FPS
            // You can update as you wish
            // But please consider Memory Usage too
            manager.deviceMotionUpdateInterval = 1 / 40
            manager.startDeviceMotionUpdates(to: .main) { [weak self] motion, err in
                if let attitude = motion?.attitude {
                    // MARK: Obtaining Device Roll Value
                    self?.xValue = attitude.roll
                    print(attitude.roll)
                }
            }
        }
    }
    
    // MARK: Stopping Updates When It's Not Necessary
    func stopMotionUpdates() {
        manager.stopDeviceMotionUpdates()
    }
}
