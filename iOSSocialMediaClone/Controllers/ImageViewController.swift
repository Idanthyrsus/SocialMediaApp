//
//  ImageViewController.swift
//  iOSSocialMediaClone
//
//  Created by Alexander Korchak on 30.10.2022.
//

import UIKit

class ImageViewController: UIViewController {
    
    var selectedIndex: Int = 0
    var imageArray: [CustomData] = []
    
    private lazy var myImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        let myImage = UIImage(named: "xmark")
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { _ in
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = .reveal
            transition.subtype = .fromLeft
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            myImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            
            closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -7),
            closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
   
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
        loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(myImage)
        view.addSubview(countLabel)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            countLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            countLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 175),
            countLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -170),
            
            closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -7),
            closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            
            myImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            myImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            myImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            myImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target:  self, action: #selector(singleTap))
        gesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(gesture)
    }
    
    private func loadImage() {
        myImage.image = UIImage(named: photosData[selectedIndex].image)
        countLabel.text = String(format: "%ld / %ld", selectedIndex + 1, photosData.count)
    }
    
    @objc func singleTap() {
        if closeButton.isHidden {
            closeButton.isHidden = false
            countLabel.isHidden = false
        } else {
            closeButton.isHidden = true
            countLabel.isHidden = true
        }
    }
}

extension UIViewController {
    
    func pushView(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        self.view.window?.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
