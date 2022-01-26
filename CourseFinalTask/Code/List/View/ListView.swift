//
//  ListView.swift
//  CourseFinalTask
//
//  Created by Nikita on 21.12.2021.
//

import UIKit

class ListView: UIView {
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: UITableView.Style.plain)
        table.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


