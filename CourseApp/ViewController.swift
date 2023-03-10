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
        
        view.backgroundColor = .lightText
        view.addSubview(containerView)
        phoneTextField.delegate = self
        
        containerView.addSubview(titleLable)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(loginButton)
        
    }
    
    enum Constants {
        static let padding: CGFloat = 16
        static let space: CGFloat = 20
        static let upperIndent: CGFloat = 150
        static let panelHeight: CGFloat = 50
        static let textSize: CGFloat = 32
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = view.bounds.width - 2 * Constants.padding
        
        let labelSize = titleLable.sizeThatFits(
            .init(
                width: width,
                height: view.bounds.height
            )
        )

        
        titleLable.frame = .init(
            x: containerView.frame.maxX,
            y: containerView.frame.maxY,
            width: width,
            height: labelSize.height
        )
        
        
        phoneTextField.frame = .init(
            x: containerView.frame.maxX,
            y: titleLable.frame.maxY + Constants.space,
            width: width,
            height: Constants.panelHeight
        )
        
        loginButton.frame = .init(
            x: containerView.frame.maxX,
            y: phoneTextField.frame.maxY + Constants.space,
            width: width,
            height: Constants.panelHeight
        )
        
        containerView.frame = .init(
            x: Constants.padding,
            y: Constants.upperIndent,
            width: width,
            height: labelSize.height + Constants.panelHeight*2 + Constants.space*2
        )
        
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightText
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.font = .systemFont(ofSize: Constants.textSize, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.layer.cornerRadius = 5.0
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.white.cgColor
        label.text = "Вход"
        return label
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.attributedPlaceholder = NSAttributedString(
            string: "Телефон",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.textColor = .white
        textField.font = .systemFont(ofSize: Constants.textSize, weight: .medium)
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor

        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Войдите", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.textSize, weight: .bold)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    func formattedNumber(number: String) -> String {
        let phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "# ### ###-##-##"
        var result = ""
        var index = phoneNumber.startIndex
        for char in mask where index < phoneNumber.endIndex{
            if char == "#" {
                result.append(phoneNumber[index])
                index = phoneNumber.index(after: index)
            }
            else{
                result.append(char)
            }
        }
        return result
    }
}


extension ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {return false}
//        let _: Int = (text as NSString).length + (string as NSString).length - range.length
//        let allowedCharacters = "0123456789"
//        let numberOnly = CharacterSet.init(charactersIn: allowedCharacters).inverted
//        let stringValid = string.rangeOfCharacter(from: numberOnly) == nil
//        (stringValid && (newLength <= 11))
        
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formattedNumber(number: newString)
        
        return false
        
    }
}
