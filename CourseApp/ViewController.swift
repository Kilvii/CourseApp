//
//  ViewController.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        view.backgroundColor = .lightText
        view.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(loginButton)
        
       let containerCenterYConstraint = containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
       self.containerCenterYConstraint = containerCenterYConstraint
        
        NSLayoutConstraint.activate(
            [
                containerView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
                containerView.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor),
                
                containerCenterYConstraint,
                
                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
                titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
//                titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 120),
                
                phoneTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                phoneTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                phoneTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                phoneTextField.heightAnchor.constraint(equalToConstant: 50),
                
                loginButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
                loginButton.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                loginButton.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                loginButton.heightAnchor.constraint(equalToConstant: 50)
            
            ]
        )
    }
    
    enum Constants {
        static let padding: CGFloat = 16
        static let space: CGFloat = 20
        static let upperIndent: CGFloat = 150
        static let panelHeight: CGFloat = 50
        static let textSize: CGFloat = 32
    }
    
    private var containerCenterYConstraint: NSLayoutConstraint?
    private var tableViewBottomLayoutConstraint: NSLayoutConstraint?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightText
        view.clipsToBounds = true
        view.layer.cornerRadius = 5.0
        view.layer.borderWidth = 3.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.backgroundColor = .lightGray
        label.font = .systemFont(ofSize: Constants.textSize, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.layer.cornerRadius = 5.0
        label.layer.borderWidth = 1.5
        label.layer.borderColor = UIColor.black.cgColor
        label.text = "Вход по телефону\nВход по телефону"
        
        return label
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.attributedPlaceholder = NSAttributedString(
            string: "Телефон",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.textColor = .white
        textField.font = .systemFont(ofSize: Constants.textSize, weight: .medium)
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.delegate = self

        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Войдите", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.textSize, weight: .bold)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
       
        return button
    }()
    
}

extension ViewController : UITextFieldDelegate {
    @objc func keyboardWillShowNotification(_ notification: Notification){
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 1
        let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? CGRect(x: 0, y: 0, width: 0, height: 260)
        
        UIView.animate(withDuration: duration){
            self.view.backgroundColor = .orange

            self.containerCenterYConstraint?.constant = -keyboardRect.height / 2

            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHideNotification(_ notification: Notification){
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 1
    
        UIView.animate(withDuration: duration){
            self.view.backgroundColor = .lightText

            self.containerCenterYConstraint?.constant = 0

            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        UIView.animate(withDuration: 1){
//            self.view.backgroundColor = .orange
//            self.titleLabel.layer.borderColor = UIColor.black.cgColor
//            self.phoneTextField.layer.borderColor = UIColor.black.cgColor
//            self.loginButton.layer.borderColor = UIColor.black.cgColor
//            self.containerCenterYConstraint?.constant = -250
//
//            self.view.layoutIfNeeded()
//        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text else {return false}
        let newLength: Int = (text as NSString).length + (string as NSString).length - range.length
        let allowedCharacters = "0123456789"
        let numberOnly = CharacterSet.init(charactersIn: allowedCharacters).inverted
        let stringValid = string.rangeOfCharacter(from: numberOnly) == nil
        return (stringValid && (newLength <= 11))

    }
}
