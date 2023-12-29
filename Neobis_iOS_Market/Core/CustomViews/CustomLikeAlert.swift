//
//  CustomLikeAlert.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 29/12/23.
//

import UIKit

protocol CustomLikeAlertDelegate: AnyObject {
    func removeLike()
}

class CustomLikeAlert: UIViewController {
    
    var id: Int?
    var delegate: CustomLikeAlertDelegate?
    
    init(id: Int? = nil, delegate: CustomLikeAlertDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.id = id
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var customView = {
        let view = UIView()
        view.layer.cornerRadius = 32
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "customHeart"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "GothamPro-Medium", size: 18)
        label.text = "Вы действительно хотите удалить из понравившихся"
        label.numberOfLines = 0
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(hex: "#5D5FEF")
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTargets()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#131313", alpha: 0.4)
        
        view.addSubview(customView)
        customView.addSubview(image)
        customView.addSubview(messageLabel)
        customView.addSubview(deleteButton)
        customView.addSubview(cancelButton)
        
        customView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(352)
            make.width.equalTo(316)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42.5)
            make.centerX.equalToSuperview()
            make.height.equalTo(93)
            make.width.equalTo(110)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.height.equalTo(44)
            make.top.equalTo(messageLabel.snp.bottom).offset(24)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(deleteButton.snp.bottom).offset(19)
        }
    }
    
    func setupTargets() {
        cancelButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(removeLike), for: .touchUpInside)
    }
    
    @objc func popBack() {
        dismiss(animated: true)
    }
    
    @objc func removeLike() {
        MainViewModel.likeProduct(id: id ?? 0)
        delegate?.removeLike()
        dismiss(animated: true)
    }
}
