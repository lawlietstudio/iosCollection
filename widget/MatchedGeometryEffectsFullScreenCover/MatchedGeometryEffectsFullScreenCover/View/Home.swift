//
//  Home.swift
//  MatchedGeometryEffectsFullScreenCover
//
//  Created by mark on 2023-07-11.
//

import SwiftUI

struct Home: View {
    /// View Properties
    @State private var show: Bool = false
    @State private var selectedRow: Row = .init(color: .clear)
    @Namespace private var animation
    //    @State private var test: Bool = false
    @State private var regularSheet: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false)
        {
            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 5), count: 3), spacing: 5) {
                ForEach(rows) {
                    row in
                    if selectedRow.id == row.id {
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 100)
                    }
                    else {
                        Rectangle()
                            .fill(row.color.gradient)
                            .matchedGeometryEffect(id: row.id.uuidString, in: animation)
                            .frame(height: 100)
                            .onTapGesture {
                                /// Adding Animation
                                withAnimation(.interpolatingSpring(stiffness: 0.6, damping: 0.8, initialVelocity: 0.8)) {
                                    selectedRow = row
                                    show.toggle()
                                }
                            }
                    }
                }
            }
            .padding(15)
            .overlay(alignment: .bottom)
            {
                Button("Regular Screen Cover")
                {
                    regularSheet.toggle()
                }
                .offset(y: 25)
            }
        }
//        .fullScreenCover(isPresented: $show) {
//            DetailView(row: $selectedRow, animationID: animation)
//        }
        .fullScreenCover(isPresented: $regularSheet, content: {
            Rectangle()
                .fill(.red.gradient)
                .ignoresSafeArea()
                .overlay {
                    Button("Close") {
                        regularSheet.toggle()
                    }
                    .tint(.white)
                }
        })
        .heroFullScreenCover(show: $show) {
            /// Detail View
            DetailView(row: $selectedRow, animationID: animation)
                /*
                .overlay {
                    /// Demo Showing State Changes are workng in real time
                    Button(test ? "Clicked" : "Click Me") {
                        test.toggle()
                    }
                }
                 */
            /// You can notice that there are tow issues:
            /// 1. It's animating while dismissing.
            /// 2. The show binding is not updated when the view is dismissed.
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/// Custom View Modifier Extension
extension View {
    @ViewBuilder
    func heroFullScreenCover<Content: View>(show: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .modifier(HelperHeroView(show: show, overlay: content()))
    }
}

/// Helper Modifier
fileprivate struct HelperHeroView<Overlay: View>: ViewModifier {
    @Binding var show: Bool
    var overlay: Overlay
    
    /// View Properties
    @State private var hostView: CustomHostingView<Overlay>?
    @State private var parentController: UIViewController?
    
    func body(content: Content) -> some View {
        content
            /// Attatch it as backgroud to fetch the parent Controller
            .background(content: {
                ExtractSwiftUIParentController(content: overlay, hostView: $hostView) { viewController in
                    parentController = viewController
                }
            })
            /// Initilazing Host View
            .onAppear {
                hostView = CustomHostingView(show: $show, rootView: overlay)
            }
            .onChange(of: show) { newValue in
                if newValue {
                    /// Present View
                    if let hostView {
                        /// Changing Presentation Style and Transition Style
                        hostView.modalPresentationStyle = .overCurrentContext
                        hostView.modalTransitionStyle = .crossDissolve
                        hostView.view.backgroundColor = .clear
                        /// We Need a present View controller to present it
                        parentController?.present(hostView, animated: false)
                    }
                    else {
                        /// Dismiss View
                        hostView?.dismiss(animated: false)
                    }
                }
            }
    }
}

fileprivate struct ExtractSwiftUIParentController<Content: View>: UIViewRepresentable {
    /// This will help update SwiftUI's host view in real time with the UIKut view, as well as return the parent view controller of the current SwiftUI View.
    var content: Content
    @Binding var hostView: CustomHostingView<Content>?
    var parentController: (UIViewController?) -> ()
    
    func makeUIView(context: Context) -> some UIView {
        /// Simply Return Empty View
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        /// Update HostView's Root View (So that SwiftUI will be updated when ever any state changes occurs in it's view)
        hostView?.rootView = content
        DispatchQueue.main.async {
            /// Retrieve it's parent view controller
            parentController(uiView.superview?.superview?.parentController)
        }
    }
}

class CustomHostingView<Content: View>: UIHostingController<Content> {
    @Binding var show: Bool
    
    init(show: Binding<Bool>, rootView: Content) {
        self._show = show
        super.init(rootView: rootView)
    }
    
    required dynamic init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implmented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        /// Since we don't need any default animation while dismissing
        super.viewWillDisappear(false)
        /// Setting show Status to false
        show = false
    }
}

public extension UIView {
    var parentController: UIViewController? {
        var responder = self.next
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        
        return nil
    }
}
