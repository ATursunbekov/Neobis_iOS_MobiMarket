//
//  RegistrationView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 15/12/23.
//

import UIKit

class RegistrationView: UIView {

    lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.text = "Регистрация"
        text.font = UIFont(name: "GothamPro-Bold", size: 18)
        return text
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.backgroundColor = UIColor(hex: "#C0C0C0")
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 28)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "market"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var usernameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.setupPlaceholder(placeholder: "Имя пользователя")
        return textField
    }()
    
    lazy var mailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.setupPlaceholder(placeholder: "Почта")
        return textField
    }()
    
    lazy var nextButton: UIButton = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(logoImage)
        addSubview(usernameTextField)
        addSubview(mailTextField)
        addSubview(nextButton)
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(112)
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(113)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(48)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
        
        mailTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(mailTextField.snp.bottom).offset(46)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
