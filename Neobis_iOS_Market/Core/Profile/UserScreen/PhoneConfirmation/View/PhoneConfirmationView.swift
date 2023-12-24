//
//  PhoneConfirmationView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 23/12/23.
//

import UIKit

class PhoneConfirmationView: UIView {
    
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
        let image = UIImageView(image: UIImage(named: "userLogo"))
        image.contentMode = .scaleAspectFit
        image.layer.shadowColor = UIColor(hex: "#5458EA").cgColor
        image.layer.shadowOffset = CGSize(width: 0, height: 3)
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код из СМС"
        label.textColor = .black
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 0 0 0"
        textField.font = UIFont(name: "GothamPro-Bold", size: 28)
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var validationText: UILabel = {
        let label = UILabel()
        label.text = "Неверный код"
        label.font = UIFont(name: "GothamPro-Medium", size: 17)
        label.textColor = .systemRed
        label.textAlignment = .center
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить код еще раз", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 17)
        button.setTitleColor(UIColor(hex: "#5458EA"), for: .normal)
        button.layer.cornerRadius = 22
        return button
    }()
    
    lazy var infoText: UILabel = {
        let label = UILabel()
        label.text = "Повторный запрос"
        label.textColor = .black
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .gray
        return label
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.tintColor = .gray
        return loader
    }()
    
    lazy var timer: UILabel = {
        let tet = UILabel()
        tet.text = "01:00"
        tet.font = UIFont(name: "GothamPro-Medium", size: 16)
        tet.textColor = .gray
        return tet
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(phoneImage)
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(validationText)
        addSubview(nextButton)
        addSubview(infoText)
        addSubview(loader)
        addSubview(timer)
        
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
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(33)
            make.leading.trailing.equalToSuperview().inset(60)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        
        validationText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nextButton.snp.bottom).offset(16)
        }
        
        infoText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(16)
        }
        
        loader.snp.makeConstraints { make in
            make.top.equalTo(infoText.snp.bottom).offset(5)
            make.centerX.equalToSuperview().offset(-30)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        timer.snp.makeConstraints { make in
            make.leading.equalTo(loader.snp.trailing).offset(6)
            make.centerY.equalTo(loader.snp.centerY)
        }
        
        nextButton.isHidden = true
        validationText.isHidden = true
        loader.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
