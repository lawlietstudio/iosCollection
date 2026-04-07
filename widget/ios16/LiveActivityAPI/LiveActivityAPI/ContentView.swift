//
//  ContentView.swift
//  LiveActivityAPI
//
//  Created by mark on 2025-04-27.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    // MARK: Updateing Live Activity
    @State var currentID: String = ""
    @State var currentSelection: Status = .received
    var body: some View {
        NavigationStack {
            VStack {
                Picker(selection: $currentSelection) {
                    Text("Received")
                        .tag(Status.received)
                    Text("Progress")
                        .tag(Status.progress)
                    Text("Ready")
                        .tag(Status.ready)
                } label: {
                    
                }
                .pickerStyle(.segmented)
                              
                // MARK: Initializing Activity
                Button("Start Activity") {
                    addLiveActivity()
                }
                .padding(.top)
                
                // MARK: Removing Activity
                Button("Remove Activity") {
                    removeActivity()
                }
                .padding(.top)
            }
            .navigationTitle("Live Activities")
            .padding(15)
            .onChange(of: currentSelection) { oldValue, newValue in
                // Retrieving Current Activity From the List Of Phone Activities
                if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
                    activity.id == currentID
                }) {
                    print("Activity Found")
                    // Since I Need to Show Animation I'm Delaying Action For 2s
                    // For Demo Purpose
                    // In Real Case Scenario Remove the Delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        var updatedState = activity.content.state
                        updatedState.status = currentSelection
                        Task {
//                            await activity.update(using: updatedState)
                            let activityContent = ActivityContent(state: updatedState, staleDate: nil)
                            await activity.update(activityContent)
                        }
                    }
                }
            }
        }
    }
    
    func removeActivity() {
        if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
            activity.id == currentID
        }) {
            // FOR DEMO PURPOSE
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                Task {
                    await activity.end(activity.content, dismissalPolicy: .immediate)
                }
            }
        }
    }
    
    // NOTE: We Need to Add Key In Info.plist File
    func addLiveActivity() {
        let orderAttributes = OrderAttributes(orderNumber: 26383, orderItems: "Burger & Milk Shake")
        // Since It doesn't Requires Any Initial Values
        // If Your Content State Struct Continas Initializers. Then You Must Pass it here
        let initialContentState = OrderAttributes.ContentState()
        
        do {
            let activityContent = ActivityContent(state: initialContentState, staleDate: nil)
            let activity = try Activity<OrderAttributes>.request(attributes: orderAttributes, content: activityContent, pushType: nil)
            
            // MARK: Storeing CurrentID For Updateing Activity
            currentID = activity.id
            print("Activity Added Successfully. id: \(activity.id)")
        } catch {
            print("Activity Add Failed. \(error.localizedDescription)")
        }
    }
}


#Preview {
    ContentView()
}
