//
//  ProfileViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 22/12/23.
//
import UIKit

class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    var viewModel: ProfileViewModelProtocol?
    
    init(viewModel: ProfileViewModelProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = profileView.titleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileView.changeButton)
        setupTargets()
        viewModel?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.getUserData()
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func changeProfilePressed() {
        let secondViewController = UserViewController(viewModel: UserViewModel(userData: viewModel?.profileModel), userImage: profileView.userImage.image)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func navigateToFavoriteScreen() {
        let secondViewController = FavoriteViewController(viewModel: MainViewModel())
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func navigateToPersonalProductScreen() {
        let secondViewController = MyProductViewController(viewModel: MyProductViewModel())
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func leavePressed() {
        let customAlertController = CustomLeaveAlert()
        customAlertController.modalPresentationStyle = .overFullScreen
        present(customAlertController, animated: false)
    }
    
    func setupTargets() {
        profileView.leaveButton.addTarget(self, action: #selector(leavePressed), for: .touchUpInside)
        profileView.changeButton.addTarget(self, action: #selector(changeProfilePressed), for: .touchUpInside)
        profileView.favoriteLink.addTarget(self, action: #selector(navigateToFavoriteScreen), for: .touchUpInside)
        profileView.userProductLink.addTarget(self, action: #selector(navigateToPersonalProductScreen), for: .touchUpInside)
    }
    
    override func loadView() {
        self.view = profileView
    }
}

extension ProfileViewController: ProfileDelegate {
    func successfulResponse(res: ProfileModel) {
        if let name = res.userInfo?.name {
            DispatchQueue.main.async {
                self.profileView.userName.text = name
            }
        }
        guard var url = res.profilePhoto?.imageUrl else {return}
        url = "https" + url.dropFirst(4)
        if let imageUrl = URL(string: url) {
                profileView.userImage.imageFrom(url: imageUrl)
        }
    }
}
