//
//  ToDoListTableViewCell.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 14/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setLayout() {
        cardView.addShadow()
    }
    
    func display(toDo: ToDo) {
        descriptionLabel.text = toDo.description
        
        if let completed = toDo.completed, completed == true {
            statusLabel.text = "Completed"
            statusLabel.textColor = .green
        } else {
            statusLabel.text = "Not complete"
            statusLabel.textColor = .red
        }
    }
}
