//
//  Home.swift
//  SimpleToDo
//
//  Created by mark on 2023-06-14.
//

import SwiftUI

struct Home: View {
    /// View Properties
    @Environment(\.self) private var env: EnvironmentValues
    @State private var filterDate: Date = .init()
    @State private var showPendingTasks: Bool = true
    @State private var showCompleteTasks: Bool = true
    var body: some View {
        List {
            DatePicker(selection: $filterDate, displayedComponents: [.date]) {

            }
            .labelsHidden()
            .datePickerStyle(.graphical)
//            .onChange(of: filterDate) { newValue in
//                do {
//                    let task = Task(context: env.managedObjectContext)
//                    task.id = .init()
//                    task.date = filterDate
//                    task.title = "Complete 3 Duolingo session"
//                    task.isCompleted = false
//                    
//                    try env.managedObjectContext.save()
//                    showPendingTasks = true
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
            
            CustomFilteringDataView(filterDate: $filterDate)
            {
                pendingTasks, completedTasks in
                DisclosureGroup(isExpanded: $showPendingTasks) {
                    /// Custom Core Date Filter View, which will display only pending tasks on this day
                    if pendingTasks.isEmpty {
                        Text("No Task's Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .listRowSeparator(.hidden)
                    }
                    else {
                        ForEach(pendingTasks) {
                            TaskRow(task: $0, isPendingTask: true)
                        }
                    }
                } label: {
                    Text("Pending Task's \(pendingTasks.isEmpty ? "" : "(\(pendingTasks.count))")")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                DisclosureGroup(isExpanded: $showCompleteTasks) {
                    /// Custom Core Date Filter View, which will display only completed tasks on this day
                    if completedTasks.isEmpty {
                        Text("No Task's Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .listRowSeparator(.hidden)
                    }
                    else {
                        ForEach (completedTasks) {
                            TaskRow(task: $0, isPendingTask: false)
                        }
                    }
                } label: {
                    Text("Completed Task's \(completedTasks.isEmpty ? "" : "(\(completedTasks.count))")")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    /// Simply Opening Pending Task View
                    /// Then Adding an Empty Task
                    do {
                        let task = Task(context: env.managedObjectContext)
                        task.id = .init()
                        task.date = filterDate
                        task.title = ""
                        task.isCompleted = false
                        
                        try env.managedObjectContext.save()
                        showPendingTasks = true
                    } catch {
                        print(error.localizedDescription)
                    }
                } label: {
                    HStack
                    {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        Text("New Task")
                    }
                    .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        
//        ScrollView {
//            Text("Environment: \(String(describing: env))")
//        }
    }
}

struct TaskRow: View {
    @ObservedObject var task: Task
    var isPendingTask: Bool
    /// View Properties
    @Environment(\.self) private var env
    @FocusState private var showKeyboard: Bool
    var body: some View {
        HStack {
            Button {
                task.isCompleted.toggle()
                save()
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 4) {
                TextField("Task Title", text: .init(get: {
                    return task.title ?? ""
                }, set: { value in
                    task.title = value
                }))
                .focused($showKeyboard)
                .onSubmit {
                    /// When the keyboard is closed, we will verify if the task title is empty. If so, we will remove those empty tasks.
                    removeEmptyTask()
                    save()
                }
                .foregroundColor(isPendingTask ? .primary : .gray)
                .strikethrough(!isPendingTask, pattern: .dash, color: .primary)
                
                /// Custom Date Picker
                Text((task.date ?? .init())
                    .formatted(date: .omitted, time: .shortened))
                    .font(.callout)
                    .foregroundColor(.gray)
                    .overlay {
                        DatePicker(selection: .init(get: {
                            return task.date ?? .init()
                        }, set: { value in
                            task.date = value
                            /// Saving Date when ever it's Updated
                            save()
                        }), displayedComponents: [.hourAndMinute]) {
                            
                        }
                        .labelsHidden()
//                        .offset(x: 100)
                        /// Hiding View by Utilizing BlendMode Modifier
                        .blendMode(.destinationOver)
                    }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            ///The keyboard will appear while the textfield is empty, which means whenever we create a task, the keyboard will automatically appear and the task title will be entered.
            if (task.title ?? "").isEmpty {
                showKeyboard = true
            }
        }
        .onDisappear {
            removeEmptyTask()
            save()
        }
        /// Verifying Content when user leaves the App
        /// Consider that when a user closed or minimises an app without entering the task title and eventually closes the app, the empty task will still be there. In those cases, when the application status is not active, we're dismissing the empty tasks
        .onChange(of: env.scenePhase) { newValue in
            if newValue != .active {
                showKeyboard = false
                DispatchQueue.main.async {
                    /// Checking if it's Empty
                    removeEmptyTask()
                    save()
                }
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    env.managedObjectContext.delete(task)
                    save()
                }
            } label: {
                Image(systemName: "trash.fill")
            }

        }
    }
    
    /// Context Saving Method
    func save() {
        do {
            try env.managedObjectContext.save()
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    /// Removing Empty Task
    func removeEmptyTask() {
        if (task.title ?? "").isEmpty {
            /// Removing Empty Task
            env.managedObjectContext.delete(task)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
