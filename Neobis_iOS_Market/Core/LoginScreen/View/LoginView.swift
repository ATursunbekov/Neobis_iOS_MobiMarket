//
//  LoginView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 12/12/23.

import UIKit
import SnapKit

class LoginView: UIView {
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "market"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var customTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.setupPlaceholder(placeholder: "Имя пользователя")
        return textField
    }()
    
    lazy var passwordTextField: CustomSecureTextField = {
        let textField = CustomSecureTextField()
        textField.setupPlaceholder(placeholder: "Пароль")
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.backgroundColor = UIColor(hex: "#C1C1C1")
        button.isEnabled = false
        button.updateAppearance()
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 14)
        button.setTitleColor(UIColor(hex: "#5458EA"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraint()
    }
    
    private func setupConstraint() {
        addSubview(logoImage)
        addSubview(customTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(registerButton)
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(113)
            make.width.equalTo(130)
        }
        
        customTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImage.snp.bottom).offset(120)
            make.height.equalTo(55)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(customTextField.snp.bottom).offset(32)
            make.height.equalTo(55)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(82)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(183)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
