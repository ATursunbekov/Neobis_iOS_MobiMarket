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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(logoImage)
        
        logoImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(52)
            make.width.equalTo(196)
            make.height.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
