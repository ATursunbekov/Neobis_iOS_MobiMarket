//
//  Phoneview.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 23/12/23.
//

import UIKit

class PhoneView: UIView {
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.backgroundColor = UIColor(hex: "#C0C0C0")
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 28)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var phoneImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "phone"))
        image.contentMode = .scaleAspectFit
        image.layer.shadowColor = UIColor(hex: "#5458EA").cgColor
        image.layer.shadowOffset = CGSize(width: 0, height: 3)
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите номер телефона"
        label.textColor = .black
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
Мы отправим вам СМС с кодом
подтверждения
"""
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0(000) 000 000"
        textField.font = UIFont(name: "GothamPro-Bold", size: 28)
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var validationText: UILabel = {
        let label = UILabel()
        label.text = "Данный номер уже зарегистрирован"
        label.font = UIFont(name: "GothamPro-Medium", size: 17)
        label.textColor = .systemRed
        label.textAlignment = .center
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.backgroundColor = UIColor(hex: "#C1C1C1")
        button.isEnabled = false
        button.updateAppearance()
        button.layer.cornerRadius = 22
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(phoneImage)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(textField)
        addSubview(validationText)
        addSubview(nextButton)
        
        phoneImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(140)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneImage.snp.bottom).offset(35)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(33)
            make.leading.trailing.equalToSuperview().inset(60)
        }
        
        validationText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(validationText.snp.bottom).offset(55)
            make.height.equalTo(44)
        }
        
        validationText.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
