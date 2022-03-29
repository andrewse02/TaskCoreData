//
//  TaskDetailViewController.swift
//  TaskCoreData
//
//  Created by Andrew Elliott on 3/29/22.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var task: Task?
    var date: Date?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let nameText = nameTextField.text,
              !nameText.isEmpty else { return }
        
        if let task = task {
            TaskController.shared.updateTask(task, name: nameText, notes: notesTextView.text, dueDate: dueDatePicker.date)
        } else {
            TaskController.shared.createTask(name: nameText, notes: notesTextView.text, dueDate: dueDatePicker.date)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDateChanged(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    // MARK: - Helper Functions
    
    func updateViews() {
        dueDatePicker.contentHorizontalAlignment = .center
        dueDatePicker.contentVerticalAlignment = .center
        
        guard let task = task else { return }
        
        nameTextField.text = task.name
        notesTextView.text = task.notes ?? ""
        dueDatePicker.date = task.dueDate ?? Date()
    }
}
