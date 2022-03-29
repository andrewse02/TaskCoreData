//
//  TaskTableViewCell.swift
//  TaskCoreData
//
//  Created by Andrew Elliott on 3/29/22.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func checkedButtonTapped(sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    

    // MARK: - Properties
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: TaskTableViewCellDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkedButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func checkedButtonTapped(_ sender: Any) {
        guard let delegate = delegate else { return }
        
        delegate.checkedButtonTapped(sender: self)
        updateViews()
    }
    
    // MARK: - Helper Functions
    
    func updateViews() {
        guard let task = task else { return }
        
        nameLabel.text = task.name
        checkedButton.setImage(task.isComplete ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square"), for: .normal)
    }
}
