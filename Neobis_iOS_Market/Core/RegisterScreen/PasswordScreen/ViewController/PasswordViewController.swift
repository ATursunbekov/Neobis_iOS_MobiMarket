//
//  PasswordViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 16/12/23.
//

import UIKit

class PasswordViewController: UIViewController {
    
    lazy var passwordView = PasswordView()
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
        navigationItem.titleView = passwordView.titleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: passwordView.backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: passwordView.showButton)
        setupTargets()
    }
    
    @objc func popBack() {
        self.dismiss(animated: true)
    }
    
    @objc func showPressed() {
        if !passwordView.passwordTextField.isSecureTextEntry {
            passwordView.passwordTextField.isSecureTextEntry = true
            passwordView.showButton.setImage(UIImage(named: "hidden"), for: .normal)
        } else {
            passwordView.passwordTextField.isSecureTextEntry = false
            passwordView.showButton.setImage(UIImage(named: "showen"), for: .normal)
        }
    }
    
    @objc func activateButton() {
        if let text = passwordView.passwordTextField.text, !text.isEmpty {
            passwordView.nextButton.isEnabled = true
            passwordView.nextButton.updateAppearance()
        } else {
            passwordView.nextButton.isEnabled = false
            passwordView.nextButton.updateAppearance()
        }
    }
    
    @objc func nextPressed() {
        viewModel?.setPassword1(input: passwordView.passwordTextField.text ?? "")
        let vc = UINavigationController(rootViewController: ConfirmationViewController(viewModel: viewModel))
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func setupTargets() {
        passwordView.backButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        passwordView.passwordTextField.addTarget(self, action: #selector(activateButton), for: .editingChanged)
        passwordView.showButton.addTarget(self, action: #selector(showPressed), for: .touchUpInside)
        passwordView.nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
    }
    
    override func loadView() {
        self.view = passwordView
    }
}
