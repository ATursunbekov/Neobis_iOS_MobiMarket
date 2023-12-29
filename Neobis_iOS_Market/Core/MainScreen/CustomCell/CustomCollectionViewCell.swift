//
//  CustomCollectionViewCell.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 27/12/23.
//

import UIKit

protocol CustomCollectionViewCellDelegate: AnyObject {
    func navigateToDetailScreen(id: Int, image: UIImage)
}

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    var id = 0
    var delegate: CustomCollectionViewCellDelegate?
    
    lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "BMW M4 Coupe: A Two-Door"
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var cost: UILabel = {
        let label = UILabel()
        label.text = "23 000 $"
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.textColor = UIColor(hex: "#5D5FEF")
        return label
    }()
    
    lazy var button: UIButton = {
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
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(productTapped))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        return tap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCnstraints()
        self.backgroundColor = .clear
        button.addTarget(self, action: #selector(likePressed), for: .touchUpInside)
    }
    
    @objc func productTapped() {
        delegate?.navigateToDetailScreen(id: id, image: image.image ?? UIImage())
    }
    
    @objc func likePressed() {
        MainViewModel.likeProduct(id: id)
        if button.tintColor == .gray {
            likeAmount.text = String((Int(likeAmount.text ?? "0") ?? 0) + 1)
        } else {
            let num = (Int(likeAmount.text ?? "0") ?? 0) - 1
            likeAmount.text = String(num < 0 ? 0 : num)
        }
        button.updateLikeButton()
    }
    
    func setupCnstraints() {
        contentView.addSubview(customView)
        customView.addSubview(image)
        customView.addSubview(title)
        customView.addSubview(cost)
        customView.addSubview(button)
        customView.addSubview(likeAmount)
        
        customView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(6)
            make.top.equalToSuperview().offset(6)
            make.height.equalTo(85)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(6)
        }
        
        cost.snp.makeConstraints { make in
            make.bottom.equalTo(button.snp.top).offset(-9)
            make.leading.trailing.equalToSuperview().inset(6)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(17)
            make.width.equalTo(20)
            make.leading.equalToSuperview().offset(8)
        }
        
        likeAmount.snp.makeConstraints { make in
            make.centerY.equalTo(button.snp.centerY)
            make.leading.equalTo(button.snp.trailing).offset(5)
        }
        customView.addGestureRecognizer(tapGesture)
    }
    
    func configureData(data: MainModel) {
        var url = data.image.imageUrl
        url = "https" + url.dropFirst(4)
        if let imageUrl = URL(string: url) {
            self.image.imageFrom(url: imageUrl)
        }
        
        self.id = data.id
        self.title.text = data.name
        self.cost.text = String(Int(data.price)) + " $"
        self.likeAmount.text = String(data.likes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
