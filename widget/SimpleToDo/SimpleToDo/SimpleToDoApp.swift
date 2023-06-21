//
//  SimpleToDoApp.swift
//  SimpleToDo
//
//  Created by mark on 2023-06-14.
//

import SwiftUI

@main
struct SimpleToDoApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.self) private var env: EnvironmentValues
    
    init() {
        let defaults = UserDefaults.standard
        // get today date
        let todayDate = Calendar.current.startOfDay(for: Date())
        print(todayDate)
        // task is created
        if defaults.string(forKey: "\(todayDate)") == nil
        {
            do {
                let task = Task(context: persistenceController.container.viewContext)
                task.id = .init()
                task.date = todayDate
                task.title = "Complete 3 Duolingo session"
                task.isCompleted = false
                
                let task2 = Task(context: persistenceController.container.viewContext)
                task2.id = .init()
                task2.date = todayDate
                task2.title = "Watch one swift design pattern"
                task2.isCompleted = false
                
                let task3 = Task(context: persistenceController.container.viewContext)
                task3.id = .init()
                task3.date = todayDate
                task3.title = "Do 100 push up"
                task3.isCompleted = false
                
                let task4 = Task(context: persistenceController.container.viewContext)
                task4.id = .init()
                task4.date = todayDate
                task4.title = "Play piano for 15 mins"
                task4.isCompleted = false
                try persistenceController.container.viewContext.save()
                
                defaults.set("\(todayDate)", forKey: "\(todayDate)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
