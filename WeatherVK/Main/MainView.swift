//
//  MainView.swift
//  WeatherVK
//
//  Created by Admin on 20.03.2024.
//

import UIKit

final class MainView: UIView {
    
    //MARK: - UI Elements
    
    private let iv: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "фон1")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let labelCity: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelTemp: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelWind: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelCloudiness: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        return sv
    }()
    
    let labelMax: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelMin: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 20, alpha: 0.2))
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = 70
        tv.layer.cornerRadius = 20
        return tv
    }()
    
    //MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupLayout()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupTableView() {
        
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: labelCloudiness.bottomAnchor, constant: 100).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive =  true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    private func setupLayout() {
        setupImageView()
        setupLabelCity()
        setupLabelTemp()
        setupLabelWind()
        setupLabelCloudiness()
        setupStackView()
    }
    
    private func setupImageView() {
        addSubview(iv)
        
        iv.topAnchor.constraint(equalTo: topAnchor).isActive = true
        iv.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        iv.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        iv.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    private func setupLabelCity() {
        addSubview(labelCity)
        
        labelCity.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelCity.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
    }
    
    private func setupLabelTemp() {
        addSubview(labelTemp)
        
        labelTemp.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelTemp.topAnchor.constraint(equalTo: labelCity.bottomAnchor, constant: 12).isActive = true
    }
    
    private func setupLabelWind() {
        addSubview(labelWind)
        
        labelWind.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelWind.topAnchor.constraint(equalTo: labelTemp.bottomAnchor, constant: 12).isActive = true
    }
    
    private func setupLabelCloudiness() {
        addSubview(labelCloudiness)
        
        labelCloudiness.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelCloudiness.topAnchor.constraint(equalTo: labelWind.bottomAnchor, constant: 12).isActive = true
    }
    
    private func setupStackView() {
        addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: labelCloudiness.bottomAnchor, constant: 12).isActive = true
        
        stackView.addArrangedSubview(labelMin)
        stackView.addArrangedSubview(labelMax)
    }
}

//MARK: - UITableViewDelegate

extension MainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)) // Здесь задайте размеры вашего заголовка
        
        // Создайте UILabel и настройте его
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width, height: 30))
        label.text = "Прогноз на 7 дней"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        headerView.addSubview(label)
        
        headerView.backgroundColor = .systemBlue
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
