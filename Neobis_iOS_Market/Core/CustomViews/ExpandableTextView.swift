import UIKit
import SnapKit

class ExpandableTextView: UIView, UITextViewDelegate {

    private let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.font = UIFont(name: "GothamPro-Medium", size: 16)
        view.tintColor = .black
        return view
    }()

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Цена"
        label.font = UIFont(name: "GothamPro", size: 16)
        label.textColor = UIColor.lightGray
        return label
    }()

    private let whiteBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.masksToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubview(whiteBackgroundView)
        whiteBackgroundView.addSubview(textView)
        whiteBackgroundView.addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            whiteBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            whiteBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            whiteBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            whiteBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: whiteBackgroundView.leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: whiteBackgroundView.trailingAnchor, constant: -8),
            textView.topAnchor.constraint(equalTo: whiteBackgroundView.topAnchor, constant: 8),
            textView.bottomAnchor.constraint(equalTo: whiteBackgroundView.bottomAnchor, constant: -8),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30) // Set a minimum height
        ])

        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8)
        ])

        textView.delegate = self
    }

    // MARK: - UITextViewDelegate

    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: .infinity))
        textView.constraints.filter { $0.firstAttribute == .height }.first?.constant = size.height
    }
    
    func setupPlaceholder(placeholder: String) {
        placeholderLabel.text = placeholder
    }
    
    func getText() -> String{
        return textView.text
    }
}
