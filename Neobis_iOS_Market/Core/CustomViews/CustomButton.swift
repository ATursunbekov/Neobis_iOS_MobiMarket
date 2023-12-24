//
//  CustomButton.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 22/12/23.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var image: String?
    var text: String?
    
    lazy var yourImage = {
        let image = UIImageView(image: UIImage(named: "shop"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var yourLabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var trailingImage = {
        let image = UIImageView(image: UIImage(named: "trailing"))
        image.contentMode = .scaleAspectFit
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    public func setupProprties(image: String, label: String) {
        yourImage.image = UIImage(named: image)
        yourLabel.text = label
    }
    
    func setupConstraints() {
        addSubview(yourImage)
        addSubview(yourLabel)
        addSubview(trailingImage)
        
        yourImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        yourLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(yourImage.snp.trailing).offset(9)
        }
        
        trailingImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(7)
            make.height.equalTo(14)
            make.width.equalTo(14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
