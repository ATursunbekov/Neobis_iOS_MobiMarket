//
//  CUstomLeaveAlert.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 1/1/24.
//

import UIKit

class CustomLeaveAlert: UIViewController {
    
    lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        return view
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "door"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы действительно хотите выйти с приложения?"
        label.numberOfLines = 0
        label.font =  UIFont(name: "GothamPro-Medium", size: 18)
        return label
    }()
    
    lazy var leaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#5D5FEF")
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTargets()
    }
    
    func setupConstraints() {
        view.backgroundColor = UIColor(hex: "#131313", alpha: 0.4)
        
        view.addSubview(customView)
        customView.addSubview(image)
        customView.addSubview(titleLabel)
        customView.addSubview(leaveButton)
        customView.addSubview(cancelButton)
        
        customView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(352)
            make.width.equalTo(335)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
            make.height.equalTo(108.5)
            make.width.equalTo(92.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        leaveButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(27.5)
            make.height.equalTo(44)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(leaveButton.snp.bottom).offset(19)
        }
    }
    
    @objc func cancelPressed() {
        self.dismiss(animated: false)
    }
    
    @objc func leavePressed() {
        dismiss(animated: false)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = LoginViewController(viewModel: LoginViewModel())
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    func setupTargets() {
        leaveButton.addTarget(self, action: #selector(leavePressed), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
    }

}
