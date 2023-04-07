//
//  ViewController.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        
        enum Margin {
            
            static let horizontalMainStackView: CGFloat = 30
            static let horizontalFooterStackView: CGFloat = 78
            static let bottom: CGFloat = 50
            
        }
        
        static let buttonHeight: CGFloat = 42
        static let authTextFieldContainerViewHeight: CGFloat = 56
        
        static let buttonСornerRadius: CGFloat = 8
        
        static let defaultAnimationDuration: Double = 0.25
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Colors/Background")
        
        view.addSubview(logoImageView)
        view.addSubview(mainStackView)
        view.addSubview(footerStackView)
        
        let mainStackViewTopConstraint = mainStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor)
        self.mainStackViewTopConstraint = mainStackViewTopConstraint
        
        let logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.topAnchor)
        self.logoImageViewTopConstraint = logoImageViewTopConstraint
        
        NSLayoutConstraint.activate(
            [
                logoImageViewTopConstraint,
                logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

                mainStackViewTopConstraint,
                mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.horizontalMainStackView),
                mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.horizontalMainStackView),
                
                authTextFieldContainerView.heightAnchor.constraint(equalToConstant: Constants.authTextFieldContainerViewHeight),
                authTextFieldContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.horizontalMainStackView),
                authTextFieldContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.horizontalMainStackView),
                
                loginButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
                
                footerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.Margin.bottom),
                footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.horizontalFooterStackView),
                footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.horizontalFooterStackView),
            ]
        )
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowNotification(_ :)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideNotification(_ :)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private var mainStackViewTopConstraint: NSLayoutConstraint?
    private var logoImageViewTopConstraint: NSLayoutConstraint?
    
    private var mainStackViewSubviews: [UIView] {
        [
            titleLable,
            authTextFieldContainerView,
            loginButton
        ]
    }
    
    private var footerStackViewSubviews: [UIView] {
        [
            appleCircleLogoImageView,
            vkCircleLogoImageView,
            okCircleLogoImageView,
            facebookCircleLogoImageView
        ]
    }

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/BackgroundLogo")
        
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: mainStackViewSubviews)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 30
        
        return stackView
    }()

    private lazy var titleLable: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .init(800))
        label.textColor = UIColor(named: "Colors/Black")
        label.numberOfLines = 0
        label.text = "ВХОД ИЛИ\nРЕГИСТРАЦИЯ"
        
        return label
    }()
    
    private lazy var authTextFieldContainerView: AuthTextFieldContainerView = {
        let view = AuthTextFieldContainerView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton.init()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Colors/ActiveButton")
        button.setTitleColor(UIColor(named: "Colors/White"), for: .normal)
        button.setTitle("Получить код", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .init(500))
        button.layer.cornerRadius = Constants.buttonСornerRadius
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: footerStackViewSubviews)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 12
        
        return stackView
    }()
    
    private lazy var appleCircleLogoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/AppleCircleLogo")
        
        return imageView
    }()
    
    private lazy var vkCircleLogoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/VKCircleLogo")
        
        return imageView
    }()
    
    private lazy var okCircleLogoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/OKCircleLogo")
        
        return imageView
    }()
    
    private lazy var facebookCircleLogoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/FacebookCircleLogo")
        
        return imageView
    }()
    
}

extension ViewController {
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func keyboardWillShowNotification(_ notification: Notification) {
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? Constants.defaultAnimationDuration
        let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? CGRect(x: 0, y: 0, width: 0, height: 260)
        
        UIView.animate(withDuration: animationDuration, delay: 0) {
            self.logoImageViewTopConstraint?.constant = -(keyboardRect.height / 8)
            self.mainStackViewTopConstraint?.constant = -(keyboardRect.height / 8)
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHideNotification(_ notification: Notification) {
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? Constants.defaultAnimationDuration
        
        UIView.animate(withDuration: animationDuration, delay: 0) {
            self.logoImageViewTopConstraint?.constant = 0
            self.mainStackViewTopConstraint?.constant = 0
            
            self.view.layoutIfNeeded()
        }
    }
}

extension ViewController {
    
    @objc
    private func authButtonTapped() {
        dismissKeyboard()
        
        if (authTextFieldContainerView.isInputTextCorrect()) {
            
            // Переход к следующему экрану
            
            return
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
            
            return
        }
    }
    
}

