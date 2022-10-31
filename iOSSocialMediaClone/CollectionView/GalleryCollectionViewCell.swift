//
//  GalleryCollectionViewCell.swift
//  iOSSocialMediaClone
//
//  Created by Alexander Korchak on 24.10.2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "gallery"
    
    private lazy var galleryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(galleryImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        galleryImage.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        galleryImage.image = nil
    }
    
    func addToGallery(picture: UIImage) {
        galleryImage.image = picture
    }
}

