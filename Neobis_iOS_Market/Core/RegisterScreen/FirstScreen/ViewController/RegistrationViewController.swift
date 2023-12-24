//
//  RegistrationViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 15/12/23.
//

import UIKit

class RegistrationViewController: UIViewController {

    
    lazy var registerView = RegistrationView()
    var viewModel: RegisterViewModelProtocol?
    
    init(viewModel: RegisterViewModelProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = registerView.titleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: registerView.backButton)
        setupTargets()
    }
    
    override func loadView() {
        self.view = registerView
    }
    
    @objc func popBack() {
        self.dismiss(animated: true)
    }
    
    @objc func nextPressed() {
        
        viewModel?.setusername(input: registerView.usernameTextField.getText())
        viewModel?.setMail(input: registerView.mailTextField.getText())
        
        let vc = UINavigationController(rootViewController: PasswordViewController(viewModel: viewModel))
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func activateButton() {
        if !registerView.usernameTextField.isEmpty() && !registerView.mailTextField.isEmpty() {
            registerView.nextButton.isEnabled = true
            registerView.nextButton.updateAppearance()
        } else {
            registerView.nextButton.isEnabled = false
            registerView.nextButton.updateAppearance()
        }
    }
    
    private func setupTargets() {
        registerView.backButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        registerView.usernameTextField.textField.addTarget(self, action: #selector(activateButton), for: .editingChanged)
        registerView.mailTextField.textField.addTarget(self, action: #selector(activateButton), for: .editingChanged)
        registerView.nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
    }
}
