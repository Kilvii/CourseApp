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
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .lightGray
        
        //view.addSubview(containerView)
        
        view.addSubview(titleLable)
        view.addSubview(phoneTextField)
        view.addSubview(loginButton)
        
    }
    
    enum Constants {
        static let padding: CGFloat = 16
        static let space: CGFloat = 20
    }
    
    //доделать
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //containerView.center = .init(x: view.bounds.midX, y: 250)
        let width = view.bounds.width - 2 * Constants.padding
        
        let lableSize = titleLable.sizeThatFits(.init(width: width, height: view.bounds.height))
        
        titleLable.frame = .init(
            x: Constants.padding,
            y: 150,
            width: width,
            height: lableSize.height
        )
        phoneTextField.frame = .init(
            x: Constants.padding,
            y: titleLable.frame.maxY + Constants.space,
            width: width,
            height: 50
        )
        loginButton.frame = .init(
            x: Constants.padding,
            y: phoneTextField.frame.maxY + Constants.space,
            width: width,
            height: 50
        )
        
        //titleLable.center = CGPoint(x: view.bounds.midX, y: 175)
        //phoneTextField.center = CGPoint(x: view.bounds.midX, y: 255)
        //loginButton.center = CGPoint(x: view.bounds.midX, y: 325)
        
    }
    
//    lazy var containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .magenta
//        view.clipsToBounds = true
//        return view
//    }()
    
    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Вход\nпо телефону\nВход\nпо телефону\nВход\nпо телефону"
        return label
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .green
        textField.attributedPlaceholder = NSAttributedString(
            string: "Телефон",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
        )
        textField.textColor = .darkText
        textField.font = .systemFont(ofSize: 20, weight: .regular)
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Войдите", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
}

