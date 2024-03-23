//
//  TableViewCell.swift
//  WeatherVK
//
//  Created by Admin on 20.03.2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseId = "TableViewCell"
    
    private let labelDay: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Понедельник"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let labelMax: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "16"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let labelMin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        setupLabelDay()
        setupLabelMin()
        setupLabelMax()
    }
    
    private func setupLabelDay() {
        contentView.addSubview(labelDay)
        
        labelDay.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelDay.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
    }
    
    private func setupLabelMin() {
        contentView.addSubview(labelMin)
        
        labelMin.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelMin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70).isActive = true
    }
    
    private func setupLabelMax() {
        contentView.addSubview(labelMax)
        
        labelMax.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelMax.leadingAnchor.constraint(equalTo: labelMin.trailingAnchor, constant: 10).isActive = true
    }
    
    func configure() {
        
    }
}
