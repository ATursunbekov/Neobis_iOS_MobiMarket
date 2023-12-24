//
//  PhoneConfirmationViewController.swift
//  Neobis_iOS_Market
//
//  Created by Alikhan Tursunbekov on 23/12/23.
//

import UIKit

class PhoneConfirmationViewController: UIViewController {
    
    var delegate: PhoneDelegate?
    var phoneNumber: String?
    
    init(delegate: PhoneDelegate, phone: String) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.phoneNumber = phone
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var timer: Timer?
    var secondsRemaining = 60

    let confirmView = PhoneConfirmationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: confirmView.backButton)
        confirmView.textField.delegate = self
        startTimer()
        setupTargets()
    }
    
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            let minutes = secondsRemaining / 60
            let seconds = secondsRemaining % 60
            confirmView.timer.text = String(format: "%02d:%02d", minutes, seconds)
            secondsRemaining -= 1
        } else {
            timer?.invalidate()
            confirmView.timer.text = "01:00"
            confirmView.nextButton.isHidden = false
            confirmView.infoText.isHidden = true
            confirmView.loader.stopAnimating()
            confirmView.timer.isHidden = true
        }
    }
    
    @objc func resendPassword() {
        confirmView.nextButton.isHidden = true
        confirmView.infoText.isHidden = false
        confirmView.loader.startAnimating()
        confirmView.timer.isHidden = false
        startTimer()
        secondsRemaining += 10
        confirmView.validationText.isHidden = true
    }
    
    @objc func checkCode() {
        if let text = confirmView.textField.text, text.count == 4 , text == "1234"{
            delegate?.didEnterPhoneNumber(phoneNumber ?? "")
            if let viewControllers = navigationController?.viewControllers {
                navigationController?.popToViewController(viewControllers[1], animated: true)
            }
        } else if !confirmView.validationText.isHidden {
            confirmView.validationText.isHidden = true
        } else {
            confirmView.validationText.isHidden = false
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func setupTargets() {
        confirmView.nextButton.addTarget(self, action: #selector(resendPassword), for: .touchUpInside)
        confirmView.textField.addTarget(self, action: #selector(checkCode), for: .editingChanged)
    }
    
    override func loadView() {
        self.view = confirmView
    }
}

extension PhoneConfirmationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count ?? 0) + string.count - range.length
        return newLength <= 4
    }
}
