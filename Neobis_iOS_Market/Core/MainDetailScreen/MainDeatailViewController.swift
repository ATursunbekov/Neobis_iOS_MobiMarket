//
//  MainDeatailViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 27/12/23.
//

import UIKit

class MainDeatailViewController: UIViewController {

    let mainView = MainDetailView()
    var viewModel: MainDetailViewModelProtocol?
    var productImage: UIImage?
    
    init(viewModel: MainDetailViewModelProtocol? = nil, productImage: UIImage? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.productImage = productImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.backButton)
        viewModel?.delegate = self
        tabBarController?.tabBar.isHidden = true
        mainView.image.image = productImage
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func addTargets() {
        mainView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }

    override func loadView() {
        self.view = mainView
    }
}

extension MainDeatailViewController: MainDeatailDelegate {
    func successResponse(response: MainDetailModel) {
        DispatchQueue.main.async {
            self.mainView.cost.text = String(Int(response.price)) + " $"
            self.mainView.likeAmount.text = String(response.likes)
            self.mainView.title.text = response.name
            self.mainView.shortDescription.text = response.shortDescription
            self.mainView.longDescription.text = response.fullDescription
        }
    }
}
