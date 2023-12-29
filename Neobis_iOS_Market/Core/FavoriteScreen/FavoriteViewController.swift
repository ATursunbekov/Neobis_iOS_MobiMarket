//
//  FavoriteViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 29/12/23.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let mainView = FavoriteView()
    var viewModel: MainViewModelProtocol?
    
    init(viewModel: MainViewModelProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        mainView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = mainView.titleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.backButton)
        viewModel?.delegate = self
    }
    
    override func loadView() {
        self.view = mainView
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        viewModel?.getFavoriteProducts()
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.mainData?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        if let viewModel = viewModel?.mainData {
            cell.configureData(data: viewModel[indexPath.row])
            cell.delegate = self
            cell.button.tintColor = .systemRed
        }
        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 184)
    }
}

extension FavoriteViewController: CustomCollectionViewCellDelegate {
    func navigateToDetailScreen(id: Int, image: UIImage) {
        let secondViewController = MainDeatailViewController(viewModel: MainDetailViewModel(id: id), productImage: image, isFavorite: true)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension FavoriteViewController: MainDelegate {
    func successResponse() {
        DispatchQueue.main.async {
            self.mainView.collectionView.reloadData()
            guard let data = self.viewModel?.mainData else {return}
            if data.isEmpty {
                self.mainView.collectionView.isHidden = true
            } else {
                self.mainView.emptyText.isHidden = true
                self.mainView.emptyImage.isHidden = true
            }
        }
    }
}
