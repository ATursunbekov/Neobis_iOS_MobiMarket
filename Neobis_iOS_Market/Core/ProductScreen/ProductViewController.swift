//
//  ProductViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 29/12/23.
//

import UIKit

class ProductViewController: UIViewController {

    let productView = ProductView()
    var viewModel: ProductViewModelProtocol?
    
    var image: UIImage?
    var cost: Int?
    var name: String?
    var shortDescription: String?
    var longDescription: String?
    var id: Int?
    
    init(viewModel: ProductViewModelProtocol? = nil, image: UIImage? = nil, cost: Int? = nil, name: String? = nil, shortDescription: String? = nil, longDescription: String? = nil, id: Int? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.image = image
        self.cost = cost
        self.name = name
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.id = id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: productView.backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: productView.saveButton)
        setuTargets()
        productView.collectionView.delegate = self
        productView.collectionView.dataSource = self
        viewModel?.delegate = self
        
        if let image = image, let cost = cost, let name = name, let shortDescription = shortDescription, let longDescription = longDescription {
            viewModel?.images.append(image)
            productView.titleField.setText(text: String(cost))
            productView.nameField.setText(text: name)
            productView.shortDescription.setText(text: shortDescription)
            productView.longDescription.setText(text: longDescription)
        }
    }
    
    override func loadView() {
        self.view = productView
    }
    
    @objc func cancelPressed() {
        dismiss(animated: true)
    }
    
    @objc func savePressed() {
        if let cost = cost, let name = name, let shortDescription = shortDescription, let longDescription = longDescription, let id = id {
            let product = ProductModel(name: name, shortDescription: shortDescription, fullDescription: longDescription, price: cost)
            viewModel?.updateProductData(body: product, id: id)
        } else {
            let parameters = ["name" : productView.nameField.getText(), "shortDescription" : productView.shortDescription.getText(), "fullDescription" : productView.longDescription.getText(), "price" : productView.titleField.getText()]
            viewModel?.uploadImagesAndJson(additionalParameters: parameters)
        }
    }

    @objc func addPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    func setuTargets() {
        productView.backButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        productView.saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        productView.addButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
    }
}

extension ProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            viewModel?.images.append(image)
            productView.collectionView.reloadData()
        }
        dismiss(animated: true)
    }
}

extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.images.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        if let image = viewModel?.images[indexPath.row] {
            cell.configureData(image: image)
        }
        return cell
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76, height: 96)
    }
}

extension ProductViewController: ProductDelegate {
    func success() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
