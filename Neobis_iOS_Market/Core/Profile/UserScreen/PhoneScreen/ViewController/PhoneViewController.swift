//
//  PhoneViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 23/12/23.
//

import UIKit

class PhoneViewController: UIViewController {

    var viewModel: PhoneViewModelProtocol?
    
    let phoneView = PhoneView()
    
    init(viewModel: PhoneViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: phoneView.backButton)
        setupTargets()
        viewModel?.localPhoneDelegate = self
    }
    
    override func loadView() {
        self.view = phoneView
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func userTyping() {
        if let text = phoneView.textField.text, !text.isEmpty {
            phoneView.nextButton.isEnabled = true
            phoneView.nextButton.updateAppearance()
        } else {
            phoneView.nextButton.isEnabled = false
            phoneView.nextButton.updateAppearance()
        }
        
        if phoneView.validationText.isHidden {
            phoneView.validationText.isHidden = true
        }
    }
    
    @objc func nextPressed() {
        if let text = phoneView.textField.text, text.count >= 9 {
            viewModel?.sendConfirmationCode(number: text)
        } else {
            phoneView.validationText.isHidden = false
        }
    }
    
    func setupTargets() {
        phoneView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        phoneView.textField.addTarget(self, action: #selector(userTyping), for: .editingChanged)
        phoneView.nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
    }
}

extension PhoneViewController: PhoneResponseDelegate {
    func successResponse() {
        DispatchQueue.main.async {
            guard let viewModel = self.viewModel else {return}
            
            self.navigationController?.pushViewController(PhoneConfirmationViewController(viewModel: viewModel), animated: true)
        }
    }
}
