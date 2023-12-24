//
//  CustomTableViewCell.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 22/12/23.
//
import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F7F6F9")
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "GothamPro-Medium", size: 16)
        return textField
    }()
    
    lazy var buttonText1: UILabel = {
        let label = UILabel()
        label.text = "Добавить номер"
        label.textColor = UIColor(hex: "#5458EA")
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        return label
    }()
    
    lazy var buttonText2: UILabel = {
        let label = UILabel()
        label.text = "0(000) 000 000"
        label.textColor = UIColor(hex: "#C0C0C0")
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        return label
    }()
    
    lazy var phoneButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.addSubview(textField)
        contentView.addSubview(separatorView)
        contentView.addSubview(phoneButton)
        phoneButton.addSubview(buttonText1)
        phoneButton.addSubview(buttonText2)
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        phoneButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        buttonText1.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        buttonText2.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        phoneButton.isHidden = true
    }
    
    func setupView(placeholder: String, textFieldText: String, phoneCheck: Bool = false, number: String = "") {
        textField.placeholder = placeholder
        textField.text = textFieldText
        
        if phoneCheck {
            textField.isHidden = true
            phoneButton.isHidden = false
            buttonText2.text = number
        }
    }
    
    func getText() -> String? {
            return textField.text
    }
}
