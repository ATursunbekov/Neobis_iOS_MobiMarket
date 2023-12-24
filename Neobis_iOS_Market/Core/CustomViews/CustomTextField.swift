import UIKit
import SnapKit

class CustomTextField: UIView {
    
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
        return textField
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#C1C1C1")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupTargets()
    }
    
    private func setupConstraints() {
        addSubview(textField)
        addSubview(placeholderText)
        addSubview(underlineView)
        
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
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
    
    public func getText() -> String {
        return textField.text ?? ""
    }
    
    @objc func showPlaceholder() {
        if let text = textField.text, !text.isEmpty {
            placeholderText.isHidden = false
        } else if !placeholderText.isHidden {
            placeholderText.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
