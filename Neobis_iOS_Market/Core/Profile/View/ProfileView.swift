//
//  ProfileView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 22/12/23.
//

import Foundation
import UIKit

class ProfileView: UIView {
    
    lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.text = "Профиль"
        text.font = UIFont(name: "GothamPro-Medium", size: 18)
        return text
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изм.", for: .normal)
        button.backgroundColor = UIColor(hex: "#C0C0C0", alpha: 0.2)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 16)
        button.frame = CGRect(x: 0, y: 0, width: 56, height: 27)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var userImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "profile"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "Alikhan"
        label.textColor = .black
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        return label
    }()
    
    lazy var sectionView1: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var sectionView2: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var favoriteLink: CustomButton = {
        let button = CustomButton()
        button.setupProprties(image: "favorite", label: "Понравившиеся")
        return button
    }()
    lazy var userProductLink: CustomButton = {
        let button = CustomButton()
        button.setupProprties(image: "shop", label: "Мои товары")
        return button
    }()
    lazy var leaveButton: CustomButton = {
        let button = CustomButton()
        button.setupProprties(image: "leave", label: "Выйти")
        return button
    }()
    
    lazy var dividerView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#F7F6F9")
        return view
    }()
    
    lazy var finishRegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закончить регистрацию", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#5458EA")
        button.layer.cornerRadius = 22
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#F7F6F9")
        
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(userImage)
        addSubview(userName)
        addSubview(sectionView1)
        sectionView1.addSubview(favoriteLink)
        sectionView1.addSubview(userProductLink)
        sectionView1.addSubview(dividerView)
        addSubview(sectionView2)
        sectionView2.addSubview(leaveButton)
        addSubview(finishRegisterButton)
        
        
        userImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(140)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        userName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImage.snp.bottom).offset(15)
        }
        
        //section Implementation
        sectionView1.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(userName.snp.bottom).offset(24)
            make.height.equalTo(121)
        }
        
        dividerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(55)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }
        
        favoriteLink.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(38)
        }
        
        userProductLink.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(38)
        }
        
        sectionView2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(sectionView1.snp.bottom).offset(16)
            make.height.equalTo(70)
        }
        
        leaveButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(38)
        }
        
        finishRegisterButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(sectionView2.snp.bottom).offset(188)
            make.height.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
