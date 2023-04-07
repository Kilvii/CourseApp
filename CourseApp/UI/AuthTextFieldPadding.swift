//
//  AuthTextFieldPadding.swift
//  CourseApp
//
//  Created by User on 04.04.2023.
//

import Foundation
import UIKit

class AuthTextFieldWithPadding: UITextField {
    
    private let textPadding = UIEdgeInsets(
        top: 14,
        left: 16,
        bottom: 0,
        right: 0
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
