//
//  CollectionHeader.swift
//  iOSSocialMediaClone
//
//  Created by Alexander Korchak on 24.10.2022.
//

import Foundation
import UIKit

class CollectionHeader: UICollectionReusableView {
    static let identifier = "header"
    
    private lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Photos"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "arrow.right"))
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photosLabel)
        addSubview(arrowImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        photosLabel.frame = CGRect(x: 12, y: 12, width: self.frame.width / 2, height: 18)
        arrowImage.frame = CGRect(x: 358, y: 12, width: 20, height: 18)
    }
}

