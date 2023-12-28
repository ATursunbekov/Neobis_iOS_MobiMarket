import UIKit
import SnapKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barStyle = .default
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        setupConstraints()
        setupTabBar()
        tabBar.tintColor = UIColor(hex: "#5D5FEF")
    }

    lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -3)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4
        return view
    }()

    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        return button
    }()

    func setupConstraints() {
        tabBar.addSubview(customView)
        customView.addSubview(addButton)

        customView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }

        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.top.equalToSuperview().offset(-15)
        }
    }

    private func setupTabBar() {
        viewControllers = [
            generateVC(
                viewController: UINavigationController(rootViewController: MainViewController(viewModel: MainViewModel())),
                title: "Главная",
                image: UIImage(named: "home")
            ),
            generateVC(
                viewController: WalletViewController(),
                title: "Кошелек",
                image: UIImage(named: "wallet")
            ),
            UIViewController(), // Placeholder for the center tab
            generateVC(
                viewController: UIViewController(),
                title: "Чаты",
                image: UIImage(named: "chat")
            ),
            generateVC(
                viewController: UINavigationController(rootViewController: ProfileViewController(viewModel: ProfileViewModel())),
                title: "Профиль",
                image: UIImage(named: "user")
            )
        ]
    }

    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}
