//
//  OrderStatus.swift
//  OrderStatus
//
//  Created by mark on 2025-04-27.
//

import WidgetKit
import SwiftUI

@main
struct OrderStatus: Widget {
    var body: some WidgetConfiguration {
       
        ActivityConfiguration(for: OrderAttributes.self) { context in
            // MARK: Live Activity View
            
            // NOTE: Live Activity Max Height = 220 pixels
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color("Green").gradient)
                
                // MAKR: Order Status UI
                VStack {
                    HStack {
                        // The image need to be smaller than 145 * 145
                        // https://stackoverflow.com/questions/74006055/images-not-rendering-in-new-ios-16-widgets
                        // Resizing image: https://imageresizer.com/
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        Text("In store pickup")
                            .foregroundStyle(.white.opacity(0.6))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: -2) {
                            ForEach(["Burger", "Shake"], id: \.self) { image in
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .background {
                                        Circle()
                                            .fill(Color("Green"))
                                            .padding(-2)
                                    }
                                    .background {
                                        Circle()
                                            .stroke(.white, lineWidth: 1.5)
                                            .padding(-2)
                                    }
                                
                            }
                        }
                    }
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(message(status: context.state.status))
                                .font(.title3)
                                .foregroundStyle(.white)
                            
                            Text(subMessage(status: context.state.status))
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        }
                        .offset(y: 13)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(alignment: .bottom, spacing: 0) {
                            ForEach(Status.allCases, id: \.self) { type in
                                Image(systemName: type.rawValue)
                                    .font(context.state.status == type ? .title2 : .body)
                                    .foregroundStyle(context.state.status == type ? Color("Green") : .white.opacity(0.7))
                                    .frame(width: context.state.status == type ? 45 : 32, height: context.state.status == type ? 45 : 32)
                                    .background {
                                        Circle()
                                            .fill(context.state.status == type ? .white : .green.opacity(0.5))
                                    }
                                    // MARK: Bottom Arrow To Look Like Bubble
                                    .background(alignment: .bottom, content: {
                                        BottomArrow(status: context.state.status, type: type)
                                    })
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .overlay(alignment: .bottom, content: {
                            // Image Size = 45 + Trailing Padding = 10
                            // 55/2 = 27.5
                            Rectangle()
                                .fill(.white.opacity(0.6))
                                .frame(height: 2)
                                .offset(y: 12)
                                .padding(.horizontal, 27.5)
                        })
                        .padding(.leading, 15)
                        .padding(.trailing, -10)
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
                }
                .padding(15)
            }
        } dynamicIsland: { context in
            // MARK: Implementing Dynamic Island
            // MARK: Since Live Activites and Dynamic Island Shares Same Data
            DynamicIsland {
                // MARK: Expanded When Long Press
                // MARK: Expanded Region can be classified into Four Types
                // Leading, Trailing, Center, Bottom
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        Text("Store Pickup")
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack(spacing: -2) {
                        ForEach(["Burger", "Shake"], id: \.self) { image in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .background {
                                    Circle()
                                        .fill(Color("Green"))
                                        .padding(-2)
                                }
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 1.5)
                                        .padding(-2)
                                }
                            
                        }
                    }
                    .padding(.top, 2)
                    .padding(.trailing, 4)
                }
                DynamicIslandExpandedRegion(.center) {
                    // This App Don't Require Any Content on Center
                    // But You Can use it in your App
                }
                DynamicIslandExpandedRegion(.bottom) {
                    DynamicIslandStatusView(context: context)
//                    Button("Center") {
//                        print("center")
//                    }
                }
            } compactLeading: {
                // MARK: For Video Example We're showing App Logo
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                    .padding(4)
                    .offset(x: -4)
            } compactTrailing: {
                Image(systemName: context.state.status.rawValue)
                    .font(.title3)
            } minimal: {
                // MARK: Minimal Will be only visible when Multiple Activites are there
                Image(systemName: context.state.status.rawValue)
                    .font(.title3)
            }
        }
    }
    
    @ViewBuilder
    func DynamicIslandStatusView(context: ActivityViewContext<OrderAttributes>) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(message(status: context.state.status))
                    .font(.callout)
                    .foregroundStyle(.white)
                
                Text(subMessage(status: context.state.status))
                    .font(.system(size: 10))
                    .foregroundStyle(.gray)
            }
            .offset(x: 5, y: 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(Status.allCases, id: \.self) { type in
                    Image(systemName: type.rawValue)
                        .font(context.state.status == type ? .title3 : .caption2)
                        .foregroundStyle(context.state.status == type ? Color("Green") : .white.opacity(0.7))
                        .frame(width: context.state.status == type ? 35 : 26, height: context.state.status == type ? 35 : 26)
                        .background {
                            Circle()
                                .fill(context.state.status == type ? .white : .green.opacity(0.5))
                        }
                        // MARK: Bottom Arrow To Look Like Bubble
                        .background(alignment: .bottom, content: {
                            BottomArrow(status: context.state.status, type: type)
                        })
                        .frame(maxWidth: .infinity)
                }
            }
            .overlay(alignment: .bottom, content: {
                // Image Size = 45 + Trailing Padding = 10
                // 55/2 = 27.5
                Rectangle()
                    .fill(.white.opacity(0.6))
                    .frame(height: 2)
                    .offset(y: 12)
                    .padding(.horizontal, 27.5)
            })
            .offset(x: 15, y: -10)
        }
        .offset(y: -5)
    }
    
    //MARK： Spliting Code
    @ViewBuilder
    func BottomArrow(status: Status, type: Status) -> some View {
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: 15))
            .scaleEffect(x: 1.3)
            .offset(y: 6)
            .opacity(status == type ? 1 : 0)
            .foregroundStyle(.white)
            .overlay(alignment: .bottom) {
                Circle()
                    .fill(.white)
                    .frame(width: 5, height: 5)
                    .offset(y: 13)
            }
    }
    
    // MARK: Main Title
    func message(status: Status) -> String {
        switch status {
        case .received:
            return "Order received"
        case .progress:
            return "Order in progress"
        case .ready:
            return "Order ready"
        }
    }
    
    // MARK: Sub Title
    func subMessage(status: Status) -> String {
        switch status {
        case .received:
            return "We just received your order."
        case .progress:
            return "We are handcrafting your order."
        case .ready:
            return "We creafted your order."
        }
    }
}
