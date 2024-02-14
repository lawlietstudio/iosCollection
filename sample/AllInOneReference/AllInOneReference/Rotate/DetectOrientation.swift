//
//  DetectOrientation.swift
//  AllInOneReference
//
//  Created by mark on 2023-06-16.
//

import SwiftUI

// Method 1: pass by orientation
struct DetectOrientation: ViewModifier {
    
    @Binding var orientation: UIDeviceOrientation
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                orientation = UIDevice.current.orientation
            }
    }
}

extension View {
    func detectOrientation(_ orientation: Binding<UIDeviceOrientation>) -> some View {
        modifier(DetectOrientation(orientation: orientation))
    }
}

// Method 2: pass by action

// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                if (UIDevice.current.orientation.isLandscape || UIDevice.current.orientation.isPortrait)
                {
                    action(UIDevice.current.orientation)
                }
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

enum CustomDeviceOrientation {
    case portrait
    case landscapeLeft
    case landscapeRight
    case portraitUpsideDown
    case faceUp
    case faceDown
    case unknown
    
    // Initialize from UIDeviceOrientation
    init(from deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait:
            self = .portrait
        case .landscapeLeft:
            self = .landscapeLeft
        case .landscapeRight:
            self = .landscapeRight
        case .portraitUpsideDown:
            self = .portraitUpsideDown
        case .faceUp:
            self = .faceUp
        case .faceDown:
            self = .faceDown
        default:
            self = .unknown
        }
    }
    
    var description: String
    {
        switch self
        {
        case .portrait:
            return "portrait"
        case .landscapeLeft:
            return "landscapeLeft"
        case .landscapeRight:
            return "landscapeRight"
        case .portraitUpsideDown:
            return "portraitUpsideDown"
        case .faceUp:
            return "faceUp"
        case .faceDown:
            return "faceDown"
        default:
            return "unknown"
        }
    }
}
