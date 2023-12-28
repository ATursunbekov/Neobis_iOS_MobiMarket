//
//  UserViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 22/12/23.
//

import UIKit

protocol PhoneDelegate: AnyObject {
    func didEnterPhoneNumber(_ phoneNumber: String)
}

class UserViewController: UIViewController {
    
    var viewModel: UserViewModelProtocol?
    var userImage: UIImage?
    
    init(viewModel: UserViewModelProtocol? = nil, userImage: UIImage? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.userImage = userImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userView = UserView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userView.backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userView.saveButton)
        
        setupTargets()
        userView.tableView.delegate = self
        userView.tableView.dataSource = self 
        userView.userImage.image = userImage
        viewModel?.delegate = self
        tabBarController?.tabBar.isHidden = true
    }
    
    override func loadView() {
        self.view = userView
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func savePressed() {
//        var userData: [String] = []
//
//        for section in 0..<userView.tableView.numberOfSections {
//            for row in 0..<userView.tableView.numberOfRows(inSection: section) {
//                let indexPath = IndexPath(row: row, section: section)
//                if let cell = userView.tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
//                    if let text = cell.getText() {
//                        userData.append(text)
//                    }
//                }
//            }
//        }
//        print(userData)
//        
//        viewModel?.uploadUserData(userData: userData)
        
        if let imageData = userView.userImage.image?.jpegData(compressionQuality: 0.1) {
            viewModel?.uploadImage(image: imageData)
        }
    }
    
    @objc func phonePressed() {
        guard let username = viewModel?.userData?.username else {return}
        navigationController?.pushViewController(PhoneViewController(viewModel: PhoneViewModel(delegate: self, username: username)), animated: true)
    }
    
    @objc func changePhotoPressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    func setupTargets() {
        userView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        userView.saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        userView.changePhoto.addTarget(self, action: #selector(changePhotoPressed), for: .touchUpInside)
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1 {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        if indexPath.section == 1 && indexPath.row == 0 {
            cell.setupView(placeholder: viewModel!.placeholders[indexPath.row], textFieldText: viewModel?.userInfo[indexPath.row] ?? "", phoneCheck: true, number: viewModel?.phoneNumber ?? "0(000) 000 000")
            cell.phoneButton.addTarget(self, action: #selector(phonePressed), for: .touchUpInside)
        } else {
            let temp = indexPath.section == 1 ? 4 : indexPath.row
            cell.setupView(placeholder: viewModel!.placeholders[temp], textFieldText: viewModel?.userInfo[temp] ?? "")
        }
        return cell
    }
}

extension UserViewController: PhoneDelegate {
    func didEnterPhoneNumber(_ phoneNumber: String) {
        self.viewModel?.phoneNumber = phoneNumber
        if let cell = userView.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? CustomTableViewCell {
            cell.buttonText2.text = phoneNumber
        } 
    }
}

extension UserViewController: UserDelegate {
    func successfullResponse() {
        DispatchQueue.main.async {
            self.hidesBottomBarWhenPushed = false
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension UserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        userView.userImage.image = info[.originalImage] as? UIImage
        dismiss(animated: true)
    }
}
