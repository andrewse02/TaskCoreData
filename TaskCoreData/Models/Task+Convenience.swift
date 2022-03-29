//
//  Task+Convenience.swift
//  TaskCoreData
//
//  Created by Andrew Elliott on 3/29/22.
//

import CoreData

extension Task {
    convenience init(name: String, notes: String?, dueDate: Date?, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
}
