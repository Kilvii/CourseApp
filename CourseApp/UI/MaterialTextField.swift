//
//  MaterialTextField.swift
//  CourseApp
//
//  Created by User on 15.03.2023.
//

import Foundation
import UIKit

class MaterialTextField: UIView {
    
    enum State {
        case `default`
        case active
        case error(message: String)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        
        addSubview(textField)
        addSubview(placeholderLabel)
        addSubview(separatorView)
        addSubview(errorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.frame = textFileFrame(state: state)
        placeholderLabel.frame = placeholderLabelFrame(state: state)
        separatorView.frame = separatorLabelFrame(state: state)
        errorLabel.frame = errorLabelFrame(state: state)
        
        if bounds.height != errorLabel.frame.maxY {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        .init(
            width: UIView.noIntrinsicMetric,
            height: errorLabel.frame.maxY
        )
    }
    
    private enum Constants {
        static let textFieldHeight: CGFloat = 50
        static let separatorHeight: CGFloat = 1
        
    }
    
    func textFileFrame(state: State) -> CGRect {
        .init(
            origin: .zero,
            size: .init(
                width: bounds.width,
                height: Constants.textFieldHeight
            )
        )
    }
    
    func placeholderLabelFrame(state: State) -> CGRect {
        .zero
    }
    
    func separatorLabelFrame(state: State) -> CGRect {
        .init(
            x: 0,
            y: Constants.textFieldHeight,
            width: bounds.width,
            height: Constants.separatorHeight
        )
    }
    
    func errorLabelFrame(state: State) -> CGRect {
        
        let size = errorLabel.sizeThatFits(.init(width: bounds.width, height: 0))
        
        return .init(
            x: 0,
            y: Constants.textFieldHeight + Constants.separatorHeight,
            width: bounds.width,
            height: size.height
        )
    }
    
    private(set) var state: State = .default
    
    func update(state: State, animated: Bool){
        UIView.animate(withDuration: animated ? 3 : 0){
            self.update(state: state)
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func update(state: State) {
        self.state = state
        
        switch state {
        case .`default`:
            separatorView.backgroundColor = .red
            errorLabel.text = nil
            errorLabel.alpha = 0
        case .active:
            separatorView.backgroundColor = .green
            errorLabel.text = nil
            errorLabel.alpha = 0
        case .error(let message):
            separatorView.backgroundColor = .black
            errorLabel.text = message
            errorLabel.alpha = 1
        }
        
        setNeedsLayout()
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .cyan
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .purple

        return label
    }()
 
    
}
