//
//  CustomFilteringDataView.swift
//  SimpleToDo
//
//  Created by mark on 2023-06-14.
//

import SwiftUI
import CoreData

struct CustomFilteringDataView<Content: View>: View {
    var content: ([Task], [Task]) -> Content
    @FetchRequest private var result: FetchedResults<Task>
    @Binding private var filterdate: Date
    init(filterDate: Binding<Date>, @ViewBuilder content: @escaping ([Task], [Task]) -> Content) {
        let calendar = Calendar.current
        // Given Filter Start of Day
        let startOfDay = calendar.startOfDay(for: filterDate.wrappedValue)
        // Given Filter End of Day
        let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!
        
        // *You can also use argumentArray and simply pass the values instead of converting them in NSDate
        let predicate = NSPredicate(format: "date >= %@ AND date <= %@", (startOfDay as NSDate), (endOfDay as NSDate))
        
        _result = FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)], predicate: predicate, animation: .easeIn(duration: 0.25))
        
        self.content = content
        self._filterdate = filterDate
    }
    
    var body: some View {
        content(separateTasks().0, separateTasks().1)
            .onChange(of: filterdate) { newValue in
                /// Clearing Old Predicate
                result.nsPredicate = nil
                
                let calendar = Calendar.current
                let startOfDay = calendar.startOfDay(for: newValue)
                let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!
                let predicate = NSPredicate(format: "date >= %@ AND date <= %@", argumentArray: [startOfDay, endOfDay])
                
                /// Assigning New Predicate
                result.nsPredicate = predicate
            }
    }
    
    func separateTasks() -> ([Task], [Task])
    {
        let pendingTasks = result.filter{ !$0.isCompleted }
        let completedTasks = result.filter{ $0.isCompleted }
        
        return (pendingTasks, completedTasks)
    }
}

struct CustomFilteringDataView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
