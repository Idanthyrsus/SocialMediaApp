//
//  FooterView.swift
//  iOSSocialMediaClone
//
//  Created by Alexander Korchak on 24.10.2022.
//

import Foundation
import UIKit

class TableFooter: UITableViewHeaderFooterView, UIGestureRecognizerDelegate {
    
    enum Offset: CGFloat {
        case padding = 16
    }
    
    var buttonTapped: (() -> Void)?
    
    static let identifier = "TableFooter"
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        gesture.addTarget(self, action: #selector(didTap))
        gesture.delegate = self
        return gesture
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
  private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: TableFooter.identifier)
        contentView.addSubview(postLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        postLabel.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            
            postLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Offset.padding.rawValue),
            postLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(Offset.padding.rawValue)),
            postLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Offset.padding.rawValue),
            postLabel.bottomAnchor.constraint(equalTo: likesLabel.topAnchor, constant: -(Offset.padding.rawValue)),
            
            likesLabel.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: Offset.padding.rawValue),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Offset.padding.rawValue),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(Offset.padding.rawValue)),
            
            viewsLabel.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: Offset.padding.rawValue),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(Offset.padding.rawValue)),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(Offset.padding.rawValue))
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(post: String) {
        postLabel.text = post
    }
    
    func apply(likes: String) {
        likesLabel.text = likes
    }
    
    func apply(views: String) {
        viewsLabel.text = views
    }
    
    @objc func didTap() {
        self.buttonTapped?()
    }
}

