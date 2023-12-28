//
//  UserView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 22/12/23.
//

import UIKit

class UserView: UIView {
    
    
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
    
    lazy var userImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "profile"))
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = false
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        return image
    }()
    
    lazy var changePhoto: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать фотографию", for: .normal)
        button.setTitleColor(UIColor(hex: "#5458EA"), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 16)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = 46
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = .clear
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#F7F6F9")
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(userImage)
        addSubview(changePhoto)
        addSubview(tableView)
        
        userImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(135)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        changePhoto.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImage.snp.bottom).offset(12)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(changePhoto.snp.bottom).offset(24)
            make.height.equalTo(350)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
