//
//  MainViewController.swift
//  WeatherVK
//
//  Created by Admin on 20.03.2024.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    
    //MARK: - UI Elements
    
    var city = ""
    let mainView = MainView()
    let locationManager = LocationManager()
    var forecastsByDay: [String: [Double]] = [:]
    var forecasts: [List] = []
    
    //MARK: - Life cycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
        
        print(city)
        
        
        locationManager.cityUpdateHandler = { city in
            DispatchQueue.main.async {
                self.city = city
                
                NetworkService.shared.getWeather(city: city) { [weak self] values in
                    DispatchQueue.main.async {
                        self?.changeTextUi(values: values)
                        self?.forecasts.append(values.list[0])
                        var day = self?.dateFormatter(str: values.list[0].dtTxt)
                        for elem in values.list {
                            if day != self?.dateFormatter(str: elem.dtTxt) {
                                self?.forecasts.append(elem)
                                day = self?.dateFormatter(str: elem.dtTxt)
                            }
                            self?.forecastsByDay[(self?.dateFormatter(str: elem.dtTxt))!, default: []].append(elem.main.tempMin)
                            self?.forecastsByDay[(self?.dateFormatter(str: elem.dtTxt))!]?.append(elem.main.tempMax)
                        }
                        DispatchQueue.main.async {
                            self?.mainView.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Methods
    
    private func changeTextUi(values: WetherAPI) {
        self.mainView.labelCity.text = values.city.name
        self.mainView.labelTemp.text = "\(String(Int(values.list[0].main.temp - 273.15)))°"
        self.mainView.labelMin.text = "мин.\(String(Int(values.list[0].main.tempMin - 273.15)))°, "
        self.mainView.labelMax.text = "макс.\(String(Int(values.list[0].main.tempMax - 273.15)))°"
        self.mainView.labelWind.text = "Скорость ветра - \(values.list[0].wind.speed) м/с"
        self.mainView.labelCloudiness.text = "Облачность - \(values.list[0].clouds.all)%"
    }
    
    private func dateFormatter(str: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: str) {
            
            let calendar = Calendar.current
            
            let dayOfWeek = calendar.component(.weekday, from: date)
            
            let weekday = calendar.weekdaySymbols[dayOfWeek - 1]
            
            return weekday
        }
        return "Нет данных"
    }
    
    private func translater(str: String) -> String {
        if str == "Monday" {
            return "Понедельник"
        } else if str == "Tuesday" {
            return "Вторник"
        } else if str == "Wednesday" {
            return "Среда"
        } else if str == "Thursday" {
            return "Четверг"
        } else if str == "Friday" {
            return "Пятница"
        } else if str == "Saturday" {
            return "Суббота"
        } else {
            return "Воскресенье"
        }
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastsByDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.reuseId,
            for: indexPath)
                as? TableViewCell else {
            fatalError("Не получилось сделать таблицу")
        }
        
        let item = forecasts[indexPath.item]
        cell.configure(
            labelMin: "\(Int((forecastsByDay[dateFormatter(str: item.dtTxt)]?.min()!)! - 273.15))°  ",
            day: translater(str: dateFormatter(str: item.dtTxt)),
            labelMax: "\(Int((forecastsByDay[dateFormatter(str: item.dtTxt)]?.max()!)! - 273.15))°"
        )
        
        cell.selectionStyle = .none
        
        return cell
    }
}
