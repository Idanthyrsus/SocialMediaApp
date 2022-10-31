//
//  HeaderView.swift
//  iOSSocialMediaClone
//
//  Created by Alexander Korchak on 24.10.2022.
//

import Foundation
import UIKit

class TableHeader: UITableViewHeaderFooterView {
    
    static let identifier = "TableHeader"
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: TableHeader.identifier)
        contentView.addSubview(authorLabel)
 
        NSLayoutConstraint.activate([
        
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

        ])
    }
    
    func apply(text: String) {
        authorLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
