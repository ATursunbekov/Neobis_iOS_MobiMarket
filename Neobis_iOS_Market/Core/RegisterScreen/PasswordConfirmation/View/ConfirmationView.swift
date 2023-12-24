//
//  PasswordView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 16/12/23.
//

import Foundation
import UIKit

class ConfirmationView: UIView {
    
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
    
    lazy var showButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hidden"), for: .normal)
        button.backgroundColor = UIColor(hex: "#C0C0C0")
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 28)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "locker"))
        image.contentMode = .scaleAspectFit
        image.layer.shadowColor = UIColor(hex: "#5458EA").cgColor
        image.layer.shadowOffset.height = 7
        return image
    }()
    
    lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "Повторите пароль"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.text = """
        Минимальная длина — 8 символов.
        Для надежности пароль должен
        содержать буквы и цифры.
        """
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "#C0C0C0")
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.tintColor = UIColor(hex: "#5458EA")
        textField.isSecureTextEntry = true
        textField.font = UIFont(name: "GothamPro-Bold", size: 24)
        return textField
    }()
    
    lazy var underlineView1 = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#5458EA")
        return view
    }()
    
    lazy var confirmationTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.tintColor = UIColor(hex: "#5458EA")
        textField.isSecureTextEntry = true
        textField.font = UIFont(name: "GothamPro-Bold", size: 24)
        return textField
    }()
    
    lazy var underlineView2 = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#5458EA")
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.backgroundColor = UIColor(hex: "#C1C1C1")
        button.isEnabled = false
        button.updateAppearance()
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var validationText = {
        let label = UILabel()
        label.text = "Пароли не совпадают"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.textColor = UIColor(hex: "#F34545")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(logoImage)
        addSubview(descriptionTitle)
        addSubview(descriptionText)
        addSubview(passwordTextField)
        addSubview(nextButton)
        addSubview(underlineView1)
        addSubview(confirmationTextField)
        addSubview(underlineView2)
        addSubview(validationText)
        
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        descriptionTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(logoImage.snp.bottom).offset(28)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(descriptionTitle.snp.bottom).offset(8)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(descriptionText.snp.bottom).offset(28)
        }
        
        underlineView1.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.height.equalTo(1)
        }
        
        confirmationTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(underlineView1.snp.bottom).offset(8)
        }
        
        underlineView2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(confirmationTextField.snp.bottom).offset(8)
            make.height.equalTo(1)
        }
        
        validationText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(underlineView2.snp.bottom).offset(8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(underlineView2.snp.bottom).offset(50)
            make.height.equalTo(55)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        validationText.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
