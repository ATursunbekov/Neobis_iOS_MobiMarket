//
//  PasswordViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 16/12/23.
//

import UIKit

class ConfirmationViewController: UIViewController {
    
    lazy var confirmationView = ConfirmationView()
    
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
        navigationItem.titleView = confirmationView.titleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: confirmationView.backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: confirmationView.showButton)
        setupTargets()
        confirmationView.passwordTextField.text = viewModel?.password1
        viewModel?.delegate = self
    }
    
    @objc func popBack() {
        self.dismiss(animated: true)
    }
    
    @objc func showPressed() {
        if !confirmationView.passwordTextField.isSecureTextEntry {
            confirmationView.passwordTextField.isSecureTextEntry = true
            confirmationView.confirmationTextField.isSecureTextEntry = true
            confirmationView.showButton.setImage(UIImage(named: "hidden"), for: .normal)
        } else {
            confirmationView.passwordTextField.isSecureTextEntry = false
            confirmationView.confirmationTextField.isSecureTextEntry = false
            confirmationView.showButton.setImage(UIImage(named: "showen"), for: .normal)
        }
    }
    
    @objc func activateButton() {
        if let text1 = confirmationView.passwordTextField.text, !text1.isEmpty, let text2 = confirmationView.confirmationTextField.text, !text2.isEmpty, text1 == text2 {
            confirmationView.nextButton.isEnabled = true
            confirmationView.nextButton.updateAppearance()
        } else if !confirmationView.nextButton.isEnabled {
            confirmationView.nextButton.isEnabled = false
            confirmationView.nextButton.updateAppearance()
        }
        
        if !confirmationView.validationText.isHidden {
            confirmationView.passwordTextField.textColor = .black
            confirmationView.confirmationTextField.textColor = .black
            confirmationView.validationText.isHidden = true
        }
    }
    
    @objc func wrongPassword() {
        if let text1 = confirmationView.passwordTextField.text, !text1.isEmpty, let text2 = confirmationView.confirmationTextField.text, !text2.isEmpty, text1 != text2 {
            confirmationView.passwordTextField.textColor = .systemRed
            confirmationView.confirmationTextField.textColor = .systemRed
            confirmationView.validationText.isHidden = false
        }
    }
    
    @objc func registerUser() {
        viewModel?.setPassword1(input: confirmationView.passwordTextField.text ?? "")
        viewModel?.setPassword2(input: confirmationView.confirmationTextField.text ?? "")
        
        viewModel?.registerUser()
    }
    
    private func setupTargets() {
        confirmationView.backButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        confirmationView.passwordTextField.addTarget(self, action: #selector(activateButton), for: .editingChanged)
        confirmationView.confirmationTextField.addTarget(self, action: #selector(activateButton), for: .editingChanged)
        confirmationView.showButton.addTarget(self, action: #selector(showPressed), for: .touchUpInside)
        confirmationView.confirmationTextField.addTarget(self, action: #selector(wrongPassword), for: .editingChanged)
        confirmationView.nextButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
    }
    
    override func loadView() {
        self.view = confirmationView
    }
}

extension ConfirmationViewController: RegisterDelegate {
    func successResponse() {
        DispatchQueue.main.async {
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    func failurResponse() {
        DispatchQueue.main.async {
            self.confirmationView.showLowerToast(message: "Ошибка !")
        }
    }
}
