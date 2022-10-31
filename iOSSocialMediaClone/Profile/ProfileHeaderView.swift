//
//  ProfileHeaderView.swift
//  iOSSocialMediaClone
//
//  Created by Alexander Korchak on 24.10.2022.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
     lazy var profileImageView: UIImageView = {
         let picture = UIImageView()
         picture.image = #imageLiteral(resourceName: "shri .jpeg")
         picture.translatesAutoresizingMaskIntoConstraints = false
         picture.contentMode = .scaleAspectFill
         picture.clipsToBounds = true
         picture.layer.borderWidth = 3
         picture.layer.borderColor = UIColor.white.cgColor
         picture.layer.cornerRadius = 120 / 2
         picture.layer.masksToBounds = true
         picture.isUserInteractionEnabled = true
         
         return picture
     }()
     
    private lazy var nameLabel: UILabel = {
         let label = UILabel()
         label.text = "My profile"
         label.font = UIFont.boldSystemFont(ofSize: 18)
         label.textColor = .black
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
    private lazy var statusLabel: UILabel = {
         let status = UILabel()
         status.textColor = .darkGray
         status.text = "Sunshine"
         status.font = UIFont.systemFont(ofSize: 14)
         status.textAlignment = .center
         status.numberOfLines = 0
         status.contentMode = .scaleToFill
         status.translatesAutoresizingMaskIntoConstraints = false
         return status
     }()
     
    private lazy var showStatusButton: UIButton = {
         let button = UIButton()
         button.backgroundColor = .systemBlue
         button.setTitle("Show Status", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.setTitleColor(.black, for: .highlighted)
         button.titleLabel?.font = .systemFont(ofSize: 18)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.layer.cornerRadius = 12
         button.layer.shadowOffset.width = 4
         button.layer.shadowOffset.height = 4
         button.layer.shadowRadius = 4
         button.layer.shadowColor = UIColor.black.cgColor
         button.layer.shadowOpacity = 1.7
         button.addTarget(self, action: #selector(showStatus), for: .touchUpInside)
         return button
     }()
     
    private lazy var textField: UITextField = {
         let text = UITextField()
         text.backgroundColor = .white
         text.font = UIFont.systemFont(ofSize: 15)
         text.layer.cornerRadius = 12
         text.borderStyle = .roundedRect
         text.layer.borderWidth = 1
         text.clipsToBounds = true
         text.placeholder = "Enter your status here..."
         text.keyboardType = .default
         text.clearButtonMode = .whileEditing
         text.contentHorizontalAlignment = .center
         text.returnKeyType = .done
         text.autocapitalizationType = .sentences
         text.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
         text.translatesAutoresizingMaskIntoConstraints = false
         return text
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(profileImageView)
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(showStatusButton)
        self.addSubview(textField)
        let safeArea = self.safeAreaLayoutGuide
        
        let backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        self.addGestureRecognizer(backgroundTapGesture)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -116),
            
            nameLabel.centerXAnchor.constraint(equalTo: showStatusButton.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: showStatusButton.widthAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 27),
            
            showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.heightAnchor.constraint(equalToConstant: 110),
            statusLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: 40),
            statusLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -45),
            
            textField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -16),
            textField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 17),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
          
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
     @objc func showStatus() {
         guard textField.text != "" else {
             textField.shake()
             return
         }
         statusLabel.text = textField.text
     }
     
     @objc func statusTextChanged(_ textField: UITextField) {
        
     }
    
    @objc private func didTapBackground() {
        self.endEditing(true)
    }
     
}

