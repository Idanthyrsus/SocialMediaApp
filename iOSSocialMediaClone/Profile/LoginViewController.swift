//
//  LoginViewController.swift
//  iOSSocialMediaClone
//
//  Created by Alexander Korchak on 24.10.2022.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
  
    
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 200)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .white
        scrollView.contentSize = contentSize
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
       return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentSize
        return view
    }()
    
    private lazy var loginView: UIView = {
        let myView = UIView()
        myView.layer.cornerRadius = 10
        myView.layer.borderWidth = 0.5
        myView.layer.borderColor = UIColor.lightGray.cgColor
        myView.clipsToBounds = true
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    private lazy var emailTextField: TextFieldWithPadding = {
        let text = TextFieldWithPadding()
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .systemGray6
        text.textColor = .black
        text.font = .systemFont(ofSize: 16)
        text.autocapitalizationType = .none
        text.placeholder = "Email or phone"
        text.layer.borderWidth = 0.5
        text.textContentType = .emailAddress
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.delegate = self
        return text
    }()
    
    private lazy var passwordTextField: TextFieldWithPadding = {
        let text = TextFieldWithPadding()
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .systemGray6
        text.textColor = .black
        text.font = .systemFont(ofSize: 16)
        text.autocapitalizationType = .none
        text.placeholder = "Password"
        text.layer.borderWidth = 0.5
        text.isSecureTextEntry = true
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.delegate = self
        return text
    }()
    
    private lazy var imageView: UIImageView = {
        let myImage = UIImageView()
        myImage.image = UIImage(named: "logo")
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.contentMode = .scaleAspectFill
        myImage.clipsToBounds = true
        return myImage
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.init(white: 0, alpha: 0.8), for: .selected)
        button.setTitleColor(.init(white: 0, alpha: 0.8), for: .highlighted)
        button.setTitleColor(.init(white: 0, alpha: 0.8), for: .disabled)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addAction(UIAction(handler: { _ in
            self.alertLabel.isHidden = true
            
            guard self.emailTextField.text != "" else {
                self.emailTextField.shake()
                return
            }
            
            guard self.passwordTextField.text != "" else {
                self.passwordTextField.shake()
                return
            }
            
            if let count = self.passwordTextField.text?.count {
                
                guard count >= 8 else {
                    
                    self.contentView.addSubview(self.alertLabel)
                    self.alertLabel.isHidden = false

                    NSLayoutConstraint.activate([
                        self.alertLabel.topAnchor.constraint(equalTo: self.loginView.bottomAnchor, constant: 10),
                        self.alertLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
                        self.alertLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
                        self.alertLabel.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor, constant: -10),
                    ])
                    return
                }
            }
         
            let loginDetails = LoginDetails()
            guard self.passwordTextField.text == loginDetails.password, (self.emailTextField.text == loginDetails.phone || self.emailTextField.text == loginDetails.email) else {

                let alert = UIAlertController(title: "Error", message: "You entered incorrect data. Try again", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                self.passwordTextField.text = ""
                self.emailTextField.text = ""
                return
            }
           
            let profileViewController = ProfileViewController()
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.contentMode = .center
        label.text = "Password should contain at least 8 symbols"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupElements()
        let backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        view.addGestureRecognizer(backgroundTapGesture)
    }
    
    private func setupElements() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(loginView)
        contentView.addSubview(loginButton)
        loginView.addSubview(emailTextField)
        loginView.addSubview(passwordTextField)
       
        NSLayoutConstraint.activate([
            
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            loginView.heightAnchor.constraint(equalToConstant: 100),
            loginView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            loginView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginView.widthAnchor.constraint(equalTo: loginButton.widthAnchor),
            loginView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -50),

            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            loginButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 50),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    @objc private func didTapBackground() {
        view.endEditing(true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

public extension UIView {
    func shake(count: Float = 4, for duration: TimeInterval = 0.5, withTranslation translation: Float = 5) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
