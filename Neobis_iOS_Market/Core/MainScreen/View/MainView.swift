//
//  MainView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 20/12/23.
//

import Foundation
import UIKit
import SnapKit

class MainView: UIView {
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "mainLogo"))
        image.contentMode = .scaleAspectFit
        return image
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
        addSubview(logoImage)
        addSubview(collectionView)
        
        logoImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(52)
            make.width.equalTo(196)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(logoImage.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
