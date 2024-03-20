//
//  MainViewController.swift
//  WeatherVK
//
//  Created by Admin on 20.03.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

