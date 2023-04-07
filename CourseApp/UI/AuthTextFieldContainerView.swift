//
//  AuthTextFieldContainerVuw.swift
//  CourseApp
//
//  Created by User on 04.04.2023.
//

import Foundation
import UIKit

class AuthTextFieldContainerView: UIView {
    
    private enum Constants {
        
        static let codeNumberLableWidth: CGFloat = 45
        
        static let indent: CGFloat = 7
        
        static let cornerRadius: CGFloat = 6
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(codeNumberLable)
        addSubview(textField)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        codeNumberLable.frame = codeNumberLableFrame()
        textField.frame = textFieldFrame()
    }
    
    private func codeNumberLableFrame() -> CGRect {
        .init(
            origin: .zero,
            size: .init(width: Constants.codeNumberLableWidth, height: bounds.height)
        )
    }

    private func textFieldFrame() -> CGRect {
        .init(
            x: Constants.codeNumberLableWidth + Constants.indent,
            y: 0,
            width: bounds.width - (Constants.codeNumberLableWidth + Constants.indent),
            height: bounds.height
        )
    }
    
    private lazy var codeNumberLable: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = UIColor(named: "Colors/InactiveTextField")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = Constants.cornerRadius
        label.textColor = UIColor(named: "Colors/PlaceholderLabel")
        label.font = .systemFont(ofSize: 14, weight: .init(400))
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "+7"
        
        return label
    }()
    
    private lazy var textField: AuthTextFieldView = {
        let textField = AuthTextFieldView()
        
        return textField
    }()
}

extension AuthTextFieldContainerView {
    
    func isInputTextCorrect() -> Bool {
        if textField.errorHandling() {
            return false
        } else {
            return true
        }
    }
    
}

