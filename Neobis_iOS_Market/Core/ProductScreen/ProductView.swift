//
//  ProductView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 29/12/23.
//

import UIKit

class ProductView: UIView {
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.backgroundColor = UIColor(hex: "#C0C0C0", alpha: 0.2)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 16)
        button.frame = CGRect(x: 0, y: 0, width: 81, height: 27)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.backgroundColor = UIColor(hex: "#C0C0C0", alpha: 0.2)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 16)
        button.frame = CGRect(x: 0, y: 0, width: 77, height: 27)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var buttonImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "image-add"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var buttonText: UILabel = {
        let text = UILabel()
        text.text = "Добавить фото"
        text.numberOfLines = 0
        text.font = UIFont(name: "GothamPro-Medium", size: 14)
        text.textAlignment = .center
        text.textColor = UIColor(hex: "#5458EA")
        return text
    }()
    
    lazy var titleField: ExpandableTextView = {
        let textField = ExpandableTextView()
        textField.setupPlaceholder(placeholder: "Цена")
        return textField
    }()
    
    lazy var nameField: ExpandableTextView = {
        let textField = ExpandableTextView()
        textField.setupPlaceholder(placeholder: "Название")
        return textField
    }()
    
    lazy var shortDescription: ExpandableTextView = {
        let textField = ExpandableTextView()
        textField.setupPlaceholder(placeholder: "Краткое описание")
        return textField
    }()
    
    lazy var longDescription: ExpandableTextView = {
        let textField = ExpandableTextView()
        textField.setupPlaceholder(placeholder: "Детальное описание")
        return textField
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collection.alwaysBounceHorizontal = true
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#F7F6F9")
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(addButton)
        addButton.addSubview(buttonImage)
        addButton.addSubview(buttonText)
        addSubview(titleField)
        addSubview(nameField)
        addSubview(shortDescription)
        addSubview(longDescription)
        addSubview(collectionView)
        
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(112)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(96)
            make.width.equalTo(76)
        }
        
        buttonImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.height.equalTo(21)
            make.width.equalTo(21)
        }
        
        buttonText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(buttonImage.snp.bottom).offset(6)
        }
        
        titleField.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(40)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(40)
        }
        
        shortDescription.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(40)
        }
        
        longDescription.snp.makeConstraints { make in
            make.top.equalTo(shortDescription.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(addButton.snp.trailing).offset(6)
            make.centerY.equalTo(addButton.snp.centerY)
            make.trailing.equalToSuperview()
            make.height.equalTo(96)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
