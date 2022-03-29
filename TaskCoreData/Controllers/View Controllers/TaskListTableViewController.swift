//
//  TaskListTableViewController.swift
//  TaskCoreData
//
//  Created by Andrew Elliott on 3/29/22.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TaskController.shared.fetchTasks()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }

        cell.task = TaskController.shared.tasks[indexPath.row]
        cell.delegate = self

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TaskController.shared.deleteTask(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TaskDetailViewController,
              segue.identifier == "toTaskDetail",
              let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let taskToSend = TaskController.shared.tasks[indexPath.row]
        destination.task = taskToSend
    }

}

extension TaskListTableViewController: TaskTableViewCellDelegate {
    func checkedButtonTapped(sender: TaskTableViewCell) {
        guard let task = sender.task else { return }
        
        TaskController.shared.toggleIsComplete(task: task)
        sender.updateViews()
    }
}
