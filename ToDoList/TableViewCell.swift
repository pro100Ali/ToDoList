//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Али  on 17.02.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        label.frame = contentView.bounds
    }
    var label: UILabel = {
        let text = UILabel()
        text.text = "Hello world"
        return text
    }()
    
    
}
