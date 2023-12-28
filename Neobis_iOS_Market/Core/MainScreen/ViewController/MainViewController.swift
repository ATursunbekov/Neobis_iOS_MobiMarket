//
//  MainViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 20/12/23.
//

import UIKit

class MainViewController: UIViewController {

    let mainView = MainView()
    var viewModel: MainViewModelProtocol?
    
    init(viewModel: MainViewModelProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel?.getUserData()
    }
    
    override func loadView() {
        self.view = mainView
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        }
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 184)
    }
}

extension MainViewController: MainDelegate {
    func successResponse() {
        DispatchQueue.main.async {
            self.mainView.collectionView.reloadData()
        }
    }
}

extension MainViewController: CustomCollectionViewCellDelegate {
    func navigateToDetailScreen(id: Int, image: UIImage) {
        let secondViewController = MainDeatailViewController(viewModel: MainDetailViewModel(id: id), productImage: image)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
