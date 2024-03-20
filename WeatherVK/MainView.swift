//
//  MainView.swift
//  WeatherVK
//
//  Created by Admin on 20.03.2024.
//

import UIKit

final class MainView: UIView {
    
    //MARK: - UI Elements
    
    private let labelCity: UILabel = {
        let label = UILabel()
        label.text = "Москва"
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelTemp: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.font = .boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelWind: UILabel = {
        let label = UILabel()
        label.text = "Ветренно"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelCloudiness: UILabel = {
        let label = UILabel()
        label.text = "Преимущество облачно"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        return sv
    }()
    
    private let labelMax: UILabel = {
        let label = UILabel()
        label.text = "Макс: 5, "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelMin: UILabel = {
        let label = UILabel()
        label.text = "Мин: 2"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = 90
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
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
        
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 100).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive =  true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func setupLayout() {
        setupLabelCity()
        setupLabelTemp()
        setupLabelWind()
        setupLabelCloudiness()
        setupStackView()
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
        
        stackView.addArrangedSubview(labelMax)
        stackView.addArrangedSubview(labelMin)
    }
}

//MARK: - UITableViewDataSourse

extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.reuseId,
            for: indexPath)
                as? TableViewCell else {
            fatalError("Не получилось сделать таблицу")
        }
        cell.configure()
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)) // Здесь задайте размеры вашего заголовка
        
        // Создайте UILabel и настройте его
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width - 20, height: 50))
        label.text = "Прогноз на 7 дней"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        headerView.addSubview(label)
        
        headerView.backgroundColor = .systemBlue
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
