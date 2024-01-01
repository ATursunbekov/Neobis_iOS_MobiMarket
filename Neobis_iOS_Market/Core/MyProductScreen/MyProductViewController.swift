//
//  MyProductViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 31/12/23.

import UIKit

class MyProductViewController: UIViewController {
    
    let productView = MyProductView()
    var viewModel: MyProductViewModelProtocol?
    
    init(viewModel: MyProductViewModelProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = productView.titleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: productView.backButton)
        viewModel?.delegate = self
        productView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    override func loadView() {
        self.view = productView
        productView.collectionView.delegate = self
        productView.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        viewModel?.getUserProduct()
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension MyProductViewController: MyProductDelegate {
    func successResponse() {
        DispatchQueue.main.async {
            self.productView.collectionView.reloadData()
            guard let data = self.viewModel?.mainData else {return}
            if data.isEmpty {
                self.productView.collectionView.isHidden = true
            } else {
                self.productView.emptyText.isHidden = true
                self.productView.emptyImage.isHidden = true
            }
        }
    }
}

extension MyProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.mainData?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyProductCollectionViewCell.identifier, for: indexPath) as! MyProductCollectionViewCell
        if let viewModel = viewModel?.mainData {
            cell.configureData(data: viewModel[indexPath.row])
            cell.delegate = self
            cell.optionDelegate = self
        }
        return cell
    }
    
    
}

extension MyProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 184)
    }
}

extension MyProductViewController: MyProductCellDelegate {
    func navigateToDetailScreen(id: Int, image: UIImage) {
        let secondViewController = MainDeatailViewController(viewModel: MainDetailViewModel(id: id), productImage: image)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func optionPressed(id: Int, image: UIImage) {
        let customAlertController = CustomOptionView(id: id, productImage: image, delegate: self)
        customAlertController.modalPresentationStyle = .overFullScreen
        present(customAlertController, animated: false)
    }
}

extension MyProductViewController: OptionDelegate {
    func changePressed(id: Int, image: UIImage) {
        let secondViewController = MainDeatailViewController(viewModel: MainDetailViewModel(id: id), productImage: image, peronalProduct: true, id: id)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func deletePressed(id: Int) {
        viewModel?.deleteProduct(id: id)
    }
}
