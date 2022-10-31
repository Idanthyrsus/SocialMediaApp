//
//  PhotosTableViewCell.swift
//  iOSSocialMediaClone
//
//  Created by Alexander Korchak on 24.10.2022.
//

import Foundation
import UIKit

class PhotosTableViewCell: UICollectionViewCell {
    
    static let identifier = "PhotosTableViewCellId"
    
    private lazy var photosImageView: UIImageView = {
        let photos = UIImageView()
        photos.translatesAutoresizingMaskIntoConstraints = false
        photos.contentMode = .scaleAspectFill
        photos.layer.cornerRadius = 6
        photos.clipsToBounds = true
        photos.layer.masksToBounds = true
        return photos
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photosImageView)
        
        NSLayoutConstraint.activate([
            photosImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
       ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func apply(picture: UIImage) {
        self.photosImageView.image = picture
    }

}

  

