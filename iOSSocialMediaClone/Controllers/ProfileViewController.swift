//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Alexander Korchak on 21.09.2022.
//

import UIKit


class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    let profileHeaderView = ProfileHeaderView()

   
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        table.register(TableFooter.self, forHeaderFooterViewReuseIdentifier: TableFooter.identifier)
        table.rowHeight = 300
        table.sectionHeaderTopPadding = 0
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
     private lazy var tapRecogniser: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        gesture.delegate = self
        gesture.addTarget(self, action: #selector(onTap))
        return gesture
    }()
    
    private lazy var newView: UIView = {
        let new = UIView()
        new.translatesAutoresizingMaskIntoConstraints = false
        return new
    }()
    
   private lazy var profileImageView: UIImageView = {
        let picture = UIImageView()
        picture.image = #imageLiteral(resourceName: "shri .jpeg")
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleAspectFill
        picture.clipsToBounds = true
        picture.layer.borderWidth = 3
        picture.layer.borderColor = UIColor.white.cgColor
        picture.layer.cornerRadius = 120 / 2
        picture.layer.masksToBounds = true
        
        return picture
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
     @objc func onTap() {
 
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.newView.addSubview(self.dismissButton)
            self.view.layoutIfNeeded()
            
            NSLayoutConstraint.activate([
                self.dismissButton.topAnchor.constraint(equalTo: self.newView.topAnchor),
                self.dismissButton.leadingAnchor.constraint(equalTo: self.newView.leadingAnchor, constant: 370),
                self.dismissButton.trailingAnchor.constraint(equalTo: self.newView.trailingAnchor, constant: -5)
            ])
        }
  
        UIView.animate(withDuration: 0.5, delay: 0) {
           
            self.newView.backgroundColor = UIColor(white: 1, alpha: 0.5)
            self.profileImageView.alpha = 1
            self.newView.addSubview(self.profileImageView)
    
            NSLayoutConstraint.activate([

                self.newView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
                self.newView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
                self.newView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
                self.newView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),

                self.profileImageView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
                self.profileImageView.widthAnchor.constraint(equalToConstant: 420),
                self.profileImageView.heightAnchor.constraint(equalToConstant: 400),
                self.profileImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 100)

            ])
            self.profileImageView.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func closeAvatar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut) {
            self.dismissButton.alpha = 0
        } completion: { _ in
            self.newView.alpha = 0
            self.profileImageView.layer.borderWidth = 3
            self.profileImageView.layer.bounds = CGRect(x: 0, y: 0, width: 120, height: 120)
            self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width/2
            self.profileImageView.layoutIfNeeded()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 29, left: 12, bottom: 12, right: 12)
        layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 12)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PhotosTableViewCell.self, forCellWithReuseIdentifier: PhotosTableViewCell.identifier)
        collection.register(CollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeader.identifier)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.frame.size = contentSize
        container.backgroundColor = .lightGray
        return container
    }()
    
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 2000)

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .white
        scrollView.contentSize = contentSize
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
       return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.addSubview(newView)
        containerView.addSubview(profileHeaderView)
        containerView.addSubview(collectionView)
        containerView.addSubview(tableView)
        
        profileHeaderView.backgroundColor = .gray
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.profileImageView.addGestureRecognizer(tapRecogniser)

        let safeArea = containerView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            profileHeaderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            profileHeaderView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 360),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: 1),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -12)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }

        if let customImage = UIImage(named: posts[indexPath.section].image) {
            cell.apply(customImage: customImage)
        }
        
       return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? TableHeader
        header?.apply(text: posts[section].author)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableFooter.identifier) as? TableFooter else {
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer")
            return footer
        }
        
        footer.apply(likes: String("Likes: \(posts[section].likes)"))
        footer.apply(views: String("Views: \(posts[section].views)"))
        footer.apply(post: posts[section].description)
        
        footer.buttonTapped = {
            footer.apply(likes: String("Likes: \(posts[section].likes += 1)"))
            self.tableView.reloadData()
        }
            
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) is CustomTableViewCell else { return }
        
        if let customImage = UIImage(named: posts[indexPath.section].image) {
            self.imageTapped(image: customImage, post: posts[indexPath.section].description, author: posts[indexPath.section].author, numberOfLikes: posts[indexPath.section].likes, numberOfViews: posts[indexPath.section].views)
            posts[indexPath.section].views += 1
            tableView.reloadData()
        }
    }
    
    func imageTapped(image: UIImage, post: String, author: String, numberOfLikes: Int, numberOfViews: Int) {
   
        let myView = UIView()
        myView.frame = UIScreen.main.bounds
        myView.backgroundColor = .white
        myView.isUserInteractionEnabled = true
        
        let customImage = UIImageView()
        customImage.contentMode = .scaleAspectFit
        customImage.image = image
        customImage.backgroundColor = .black
        customImage.translatesAutoresizingMaskIntoConstraints = false
        
        let labelText = UILabel()
        labelText.text = post
        labelText.backgroundColor = .white
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.font = UIFont.systemFont(ofSize: 14)
        labelText.textColor = .systemGray
        labelText.textAlignment = .left
        labelText.numberOfLines = 0
        labelText.lineBreakMode = .byWordWrapping
        
        let likesLabel = UILabel()
        likesLabel.font = UIFont.systemFont(ofSize: 16)
        likesLabel.textColor = .black
        likesLabel.numberOfLines = 2
        likesLabel.text = "Likes: \(numberOfLikes)"
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsLabel = UILabel()
        viewsLabel.font = UIFont.systemFont(ofSize: 16)
        viewsLabel.textColor = .black
        viewsLabel.numberOfLines = 2
        viewsLabel.text = "Views: \(numberOfViews)"
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let authorLabel = UILabel(frame: .zero)
        authorLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorLabel.textAlignment = .left
        authorLabel.numberOfLines = 0
        authorLabel.text = author
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreen))
        self.view.addSubview(myView)
        myView.addGestureRecognizer(tapGesture)
        myView.addSubview(labelText)
        myView.addSubview(customImage)
        myView.addSubview(likesLabel)
        myView.addSubview(viewsLabel)
        myView.addSubview(authorLabel)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        NSLayoutConstraint.activate([
        
            authorLabel.topAnchor.constraint(equalTo: myView.topAnchor, constant: 100),
            authorLabel.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -20),
            authorLabel.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 20),
            authorLabel.bottomAnchor.constraint(equalTo: customImage.topAnchor, constant: -20),
            
            customImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            customImage.leadingAnchor.constraint(equalTo: myView.leadingAnchor),
            customImage.trailingAnchor.constraint(equalTo: myView.trailingAnchor),
            customImage.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -280),
            
            labelText.topAnchor.constraint(equalTo: customImage.bottomAnchor),
            labelText.bottomAnchor.constraint(equalTo: likesLabel.topAnchor),
            labelText.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -8),
            labelText.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 8),
            
            likesLabel.topAnchor.constraint(equalTo: labelText.bottomAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -70),
            likesLabel.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
          
            viewsLabel.topAnchor.constraint(equalTo: labelText.bottomAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -70),
            viewsLabel.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
        
        ])
                
    }
    
    @objc func dismissFullscreen(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        100
    }
}


extension ProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }
        
        if let customPhoto = UIImage(named: photosData[indexPath.row].image) {
            cell.apply(picture: customPhoto)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width) / 4.6, height: (collectionView.frame.width) / 5.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeader.identifier, for: indexPath) as! CollectionHeader
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let view = PhotosViewController()
       view.title = "Photo Gallery"
       navigationController?.pushViewController(view, animated: true)
        
    }
}


