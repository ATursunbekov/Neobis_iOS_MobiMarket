//
//  ViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 12/12/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var loginView = LoginView()
    var viewModel: LoginViewModelProtocol?
    
    init(viewModel: LoginViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        viewModel?.delegate = self
    }
    
    override func loadView() {
        self.view = loginView
    }
    
    func setupTargets() {
        loginView.customTextField.textField.addTarget(self, action: #selector(validationCheck), for: .editingChanged)
        loginView.passwordTextField.textField.addTarget(self, action: #selector(validationCheck), for: .editingChanged)
        loginView.loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }
    
    @objc func validationCheck() {
        if !loginView.customTextField.isEmpty() && !loginView.passwordTextField.isEmpty() && !loginView.loginButton.isEnabled {
            loginView.loginButton.isEnabled = true
            loginView.loginButton.updateAppearance()
        } else if loginView.loginButton.isEnabled && (loginView.customTextField.isEmpty() || loginView.passwordTextField.isEmpty()) {
            loginView.loginButton.isEnabled = false
            loginView.loginButton.updateAppearance()
        }
        
        if loginView.customTextField.underlineView.backgroundColor == .systemRed {
            loginView.customTextField.wrongData(false)
            loginView.passwordTextField.wrongData(false)
        }
    }
    
    @objc func loginPressed() {
        
//        let userRequest = SignInUserRequest(
//            username: loginView.customTextField.textField.text ?? "",
//            password: loginView.passwordTextField.textField.text ?? ""
//        )
//        
//        viewModel?.loginUser(body: userRequest)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = CustomTabBarController()
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    @objc func registerPressed() {
        let vc = UINavigationController(rootViewController: RegistrationViewController(viewModel: RegisterViewModel()))
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension LoginViewController: LoginDelegate {
    func successfullResponse() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = CustomTabBarController()
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    func failureResponse() {
        DispatchQueue.main.async {
            self.loginView.showToast(message: "Неверный логин или пароль")
            self.loginView.customTextField.wrongData(true)
            self.loginView.passwordTextField.wrongData(true)
        }
    }
}

