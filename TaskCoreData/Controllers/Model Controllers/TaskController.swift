//
//  TaskController.swift
//  TaskCoreData
//
//  Created by Andrew Elliott on 3/29/22.
//

import UIKit
import CoreData

class TaskController {
    
    // MARK: - Properties
    
    static let shared = TaskController()
    var tasks: [Task] = []
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
      let request = NSFetchRequest<Task>(entityName: "Task")
      request.predicate = NSPredicate(value: true)
      return request
    }()
    
    // MARK: - CRUD Funcitons
    
    func createTask(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        
        CoreDataStack.saveContext()
    }
    
    func fetchTasks() {
        tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func updateTask(_ task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        
        CoreDataStack.saveContext()
    }
    
    func deleteTask(at index: Int) {
        guard tasks.indices.contains(index) else { return }
        
        CoreDataStack.context.delete(tasks[index])
        tasks.remove(at: index)
        
        CoreDataStack.saveContext()
    }
    
}
