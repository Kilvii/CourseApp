//
//  AuthTextFieldVuw.swift
//  CourseApp
//
//  Created by User on 04.04.2023.
//

import Foundation
import UIKit

class AuthTextFieldView: UIView {
    
    private enum Constants {
        
        enum Offset {
            
            static let horizontalPlaceholderLabel: CGFloat = 16
            
        }
        
        static let cornerRadius: CGFloat = 6
        static let borderWidth: CGFloat = 1
        
        static let placeholderLableText: String = "Номер телефона"
        
        static let defaultAnimationDuration: Double = 0.25
        
    }
    
    enum State {
        
        case `default`
        case active
        case error(message: TextFieldError)
        
    }
    
    enum TextFieldError: String {
        
        case wrongFormat = "Неверный формат телефона"
        case fieldIsEmpty = "Поле не может быть пустым"
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textField)
        addSubview(placeholderLabel)
        addSubview(errorLable)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textField.frame = textFieldFrame(state: state)
        placeholderLabel.frame = placeholderLabelFrame(state: state)
        errorLable.frame = errorLableFrame(state: state)
    }

    private func textFieldFrame(state: State) -> CGRect {
        .init(
            origin: .zero,
            size: .init(width: bounds.width, height: bounds.height)
        )
    }

    private func placeholderLabelFrame(state: State) -> CGRect {
        switch state {
        case .`default`:
            if textFieldText.isEmpty {
                return placeholderLabelFrame(withOffset: false)
            } else {
                return placeholderLabelFrame(withOffset: true)
            }
        case .active:
            return placeholderLabelFrame(withOffset: true)
        case .error(let message):
            switch message {
            case .fieldIsEmpty:
                return placeholderLabelFrame(withOffset: false)
            case .wrongFormat:
                return placeholderLabelFrame(withOffset: true)
            }
        }
    }
    
    private func placeholderLabelFrame(withOffset: Bool) -> CGRect {
        switch withOffset {
        case true:
            return .init(
                x: Constants.Offset.horizontalPlaceholderLabel,
                y: -(bounds.height / 4),
                width: bounds.width,
                height: bounds.height
            )
        case false:
            return .init(
                x: Constants.Offset.horizontalPlaceholderLabel,
                y: 0,
                width: bounds.width,
                height: bounds.height
            )
        }
    }

    private func errorLableFrame(state: State) -> CGRect {
        let size = errorLable.sizeThatFits(.init(width: bounds.width, height: 0))
        
        return .init(
            x: 0,
            y: bounds.height,
            width: bounds.width,
            height: size.height
        )
    }

    private(set) var state: State = .default
    
    private var textFieldText: String = ""

    func update(state: State, animated: Bool) {
        UIView.animate(withDuration: animated ? Constants.defaultAnimationDuration : 0) {
            self.update(state: state)
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
        }
    }

    private func update(state: State) {
        self.state = state

        switch state {
        case .`default`:
            textField.layer.backgroundColor = UIColor(named: "Colors/InactiveTextField")?.cgColor
            textField.layer.borderColor = UIColor(named: "Colors/InactiveTextField")?.cgColor
            
            placeholderLabel.alpha = 1
            if textFieldText.isEmpty {
                placeholderLabel.font = placeholderLabel.font.withSize(14)
            } else {
                placeholderLabel.font = placeholderLabel.font.withSize(12)
            }
            
            errorLable.text = nil
            errorLable.alpha = 0
        case .active:
            textField.layer.backgroundColor = UIColor(named: "Colors/ActiveTextField")?.cgColor
            textField.layer.borderColor = UIColor(named: "Colors/ActiveButton")?.cgColor
            
            placeholderLabel.alpha = 1
            placeholderLabel.font = placeholderLabel.font.withSize(12)
            
            errorLable.text = nil
            errorLable.alpha = 0
        case .error(let message):
            textField.layer.backgroundColor = UIColor(named: "Colors/ActiveTextField")?.cgColor
            textField.layer.borderColor = UIColor(named: "Colors/ErrorTextField")?.cgColor

            errorLable.text = message.rawValue
            errorLable.alpha = 1
        }

        setNeedsLayout()
    }

    private lazy var textField: AuthTextFieldWithPadding = {
        let textField = AuthTextFieldWithPadding()
        
        textField.delegate = self
        textField.backgroundColor = UIColor(named: "Colors/InactiveTextField")
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.borderWidth = Constants.borderWidth
        textField.layer.borderColor = UIColor(named: "Colors/InactiveTextField")?.cgColor
        textField.textColor = UIColor(named: "Colors/Black")
        textField.font = .systemFont(ofSize: 14, weight: .init(400))
        textField.keyboardType = .asciiCapableNumberPad
        
        return textField
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(named: "Colors/PlaceholderLabel")
        label.font = .systemFont(ofSize: 14, weight: .init(400))
        label.text = "Номер телефона"
        
        return label
    }()
    
    private lazy var errorLable: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Colors/ErrorTextField")
        label.font = .systemFont(ofSize: 12, weight: .init(400))
        
        return label
    }()

}

extension AuthTextFieldView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textFieldText.isEmpty {
            placeholderLabel.alpha = 0
        } else {
            placeholderLabel.alpha = 1
        }
        
        update(state: .active, animated: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textFieldText.isEmpty {
            placeholderLabel.alpha = 0
        } else {
            placeholderLabel.alpha = 1
        }
        
        self.textFieldText = textField.text ?? ""
        
        update(state: .default, animated: true)
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let textFieldTextCount = textField.text?.count ?? 0
        return textFieldTextCount + string.count - range.length <= 10
    }

}

extension AuthTextFieldView {
 
    func errorHandling() -> Bool {
        if textFieldText.isEmpty {
            update(state: .error(message: .fieldIsEmpty))
            return true
        }
        
        if textFieldText.count != 10 {
            update(state: .error(message: .wrongFormat))
            return true
        }
        
        return false
    }
    
}
