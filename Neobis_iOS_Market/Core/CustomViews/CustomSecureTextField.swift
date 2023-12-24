import UIKit
import SnapKit

class CustomSecureTextField: UIView {
    
    lazy var placeholderText: UILabel = {
        let label = UILabel()
        label.text = "Enter"
        label.textColor = UIColor(hex: "#C1C1C1")
        label.font = UIFont(name: "GothamPro", size: 14)
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text"
        textField.font = UIFont(name: "GothamPro", size: 16)
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(hex: "#C1C1C1"),
            NSAttributedString.Key.font: UIFont(name: "GothamPro", size: 16) as Any
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Enter text", attributes: placeholderAttributes)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#C1C1C1")
        return view
    }()
    
    lazy var showButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hidden"), for: .normal)
        button.tintColor = UIColor(hex: "#C1C1C1")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupTargets()
    }
    
    private func setupConstraints() {
        addSubview(showButton)
        addSubview(textField)
        addSubview(placeholderText)
        addSubview(underlineView)
        
        showButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(18)
            make.width.equalTo(20)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(showButton.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
        }
        
        placeholderText.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        underlineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(-5)
        }
        //Hiding elements
        placeholderText.isHidden = true
    }
    
    private func setupTargets() {
        textField.addTarget(self, action: #selector(showPlaceholder), for: .editingChanged)
        showButton.addTarget(self, action: #selector(showPressed), for: .touchUpInside)
    }
    
    public func setupPlaceholder(placeholder: String) {
        textField.placeholder = placeholder
        placeholderText.text = placeholder
    }
    
    public func isEmpty() -> Bool{
        if let text = textField.text {
            return text.isEmpty
        }
        
        return false
    }
    
    public func wrongData(_ check: Bool) {
        if check {
            textField.textColor = .systemRed
            underlineView.backgroundColor = .systemRed
        } else {
            textField.textColor = .black
            underlineView.backgroundColor = UIColor(hex: "#C1C1C1")
        }
    }
    
    public func getPassword() -> String {
        return textField.text ?? ""
    }
    
    @objc func showPlaceholder() {
        if let text = textField.text, !text.isEmpty {
            placeholderText.isHidden = false
            showButton.tintColor = UIColor(hex: "#5458EA")
        } else if !placeholderText.isHidden {
            placeholderText.isHidden = true
            showButton.tintColor = UIColor(hex: "#C1C1C1")
        }
    }
    
    @objc func showPressed() {
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false
            showButton.setImage(UIImage(named: "showen"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            showButton.setImage(UIImage(named: "hidden"), for: .normal)
        }
        UIView.animate(withDuration: 0.5) {
            self.showButton.snp.updateConstraints { make in
                make.height.equalTo(self.textField.isSecureTextEntry ? 18 : 14)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
