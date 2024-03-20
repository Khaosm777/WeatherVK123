//
//  TableViewCell.swift
//  WeatherVK
//
//  Created by Admin on 20.03.2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseId = "TableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
}
