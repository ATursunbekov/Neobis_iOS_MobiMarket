//
//  MainViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 20/12/23.
//

import UIKit

class MainViewController: UIViewController {

    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(navigationController?.viewControllers)
    }
    
    override func loadView() {
        self.view = mainView
    }

}
