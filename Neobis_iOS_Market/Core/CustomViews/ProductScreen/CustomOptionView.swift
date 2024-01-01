//
//  CustomOptionView.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 31/12/23.

import UIKit

class CustomOptionView: UIViewController {
    
    var id: Int?
    var productImage: UIImage?
    var delegate: OptionDelegate?
    
    init(id: Int? = nil, productImage: UIImage? = nil, delegate: OptionDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.id = id
        self.productImage = productImage
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
    
    lazy var tabView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(hex: "#D9D9D9")
        return view
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var changeImage = {
        let image = UIImageView(image: UIImage(named: "pen"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var deleteImage = {
        let image = UIImageView(image: UIImage(named: "trash"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var labelChange = {
        let label = UILabel()
        label.text = "Изменить"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var labelDelete = {
        let label = UILabel()
        label.text = "Удалить"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backPressed))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        return tap
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTargets()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#131313", alpha: 0.4)
        
        view.addSubview(customView)
        customView.addSubview(tabView)
        customView.addSubview(changeButton)
        changeButton.addSubview(changeImage)
        changeButton.addSubview(labelChange)
        customView.addSubview(deleteButton)
        deleteButton.addSubview(deleteImage)
        deleteButton.addSubview(labelDelete)
        
        customView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(145)
        }
        
        tabView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(7.5)
            make.height.equalTo(5)
            make.width.equalTo(34)
        }
        
        changeButton.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(38)
        }
        
        changeImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        labelChange.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(changeImage.snp.trailing).offset(10)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(changeButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(38)
        }
        
        deleteImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        labelDelete.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(deleteImage.snp.trailing).offset(10)
        }
        
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupTargets() {
        deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        changeButton.addTarget(self, action: #selector(changePressed), for: .touchUpInside)
    }
    
    @objc func changePressed() {
        if let id = id, let image = productImage {
            dismiss(animated: false)
            delegate?.changePressed(id: id, image: image)
        }
    }
    
    @objc func deletePressed() {
        if let id = id {
            dismiss(animated: false)
            delegate?.deletePressed(id: id)
        }
    }
    
    @objc func backPressed() {
        dismiss(animated: false)
    }
}
