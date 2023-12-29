//
//  FavoriteView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 29/12/23.

import UIKit
import SnapKit

class FavoriteView: UIView {
    
    lazy var emptyImage = {
        let image = UIImageView(image: UIImage(named: "Artwork"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var emptyText = {
        let label = UILabel()
        label.text = "Ой пусто!"
        label.font = UIFont(name: "GothamPro-Bold", size: 18)
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.text = "Понравившиеся"
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collection.alwaysBounceVertical = true
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#F7F6F9")
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(collectionView)
        addSubview(emptyImage)
        addSubview(emptyText)
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(25)
            make.bottom.equalToSuperview()
        }
        
        emptyText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        emptyImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emptyText.snp.top).offset(-40)
            make.height.equalTo(185)
            make.width.equalTo(168)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
