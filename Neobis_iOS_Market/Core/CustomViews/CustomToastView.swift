import UIKit

class CustomToastView: UIView {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.text = "Неверный логин или пароль"
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "exclamationmark.circle.fill"))
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    init(message: String) {
        super.init(frame: CGRect.zero)
        setupUI(message: message)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(message: String) {
        backgroundColor = UIColor(hex: "#F34545")
        self.layer.cornerRadius = 16
        
        messageLabel.text = message
        addSubview(image)
        addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(30)
        }
        
        image.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(messageLabel.snp.leading).offset(-6)
        }
    }
}

extension UIView {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastView = CustomToastView(message: message)

        addSubview(toastView)
        toastView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }

        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut) {
            toastView.alpha = 0.0
        } completion: { _ in
            toastView.removeFromSuperview()
        }
    }
    
    func showLowerToast(message: String, duration: TimeInterval = 2.0) {
        let toastView = CustomToastView(message: message)

        addSubview(toastView)
        toastView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(108)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }

        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut) {
            toastView.alpha = 0.0
        } completion: { _ in
            toastView.removeFromSuperview()
        }
    }
}
