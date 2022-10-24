//
//  PostViewController.swift
//  Navigation
//
//  Created by Alexander Korchak on 22.09.2022.
//

import UIKit

class PostViewController: UIViewController {

    @objc func goToInfo() {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)
        infoViewController.view.backgroundColor = .systemPink
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        self.navigationItem.title = "Post"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let transitionButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(goToInfo))
        self.navigationItem.rightBarButtonItem = transitionButton
    }
}
