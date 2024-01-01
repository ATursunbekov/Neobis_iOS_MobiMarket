//
//  MainDetailView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 27/12/23.
//

import UIKit

class MainDetailView: UIView {
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.backgroundColor = UIColor(hex: "#C0C0C0")
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 28)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изм.", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#C0C0C0")
        button.frame = CGRect(x: 0, y: 0, width: 56, height: 28)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var cost: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Bold", size: 24)
        label.textColor = UIColor(hex: "#5D5FEF")
        return label
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "heart"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    lazy var likeAmount: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = UIFont(name: "GothamPro-Medium", size: 12)
        label.textColor = UIColor(hex: "#C1C1C1")
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Bold", size: 18)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var shortDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "#C0C0C0")
        return label
    }()
    
    lazy var longTitle: UILabel = {
        let label = UILabel()
        label.text = "Детальное описание"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var longDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "#C0C0C0")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(image)
        addSubview(cost)
        addSubview(heartButton)
        addSubview(likeAmount)
        addSubview(title)
        addSubview(shortDescription)
        addSubview(longTitle)
        addSubview(longDescription)
        
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
         
        cost.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        heartButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.top.equalTo(cost.snp.bottom).offset(12)
            make.height.equalTo(18)
            make.width.equalTo(20)
        }
        
        likeAmount.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton.snp.centerY)
            make.leading.equalTo(heartButton.snp.trailing).offset(8)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.bottom).offset(17)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        shortDescription.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        longTitle.snp.makeConstraints { make in
            make.top.equalTo(shortDescription.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        longDescription.snp.makeConstraints { make in
            make.top.equalTo(longTitle.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
