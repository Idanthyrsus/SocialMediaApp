//
//  InfoViewController.swift
//  Navigation
//
//  Created by Alexander Korchak on 23.09.2022.
//

import UIKit

class InfoViewController: UIViewController {

    @objc func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        alertButton.layer.cornerRadius = 12
        alertButton.center = view.center
        alertButton.backgroundColor = .systemBlue
        alertButton.tintColor = .black
        alertButton.setTitle("Alert", for: .normal)
        alertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        self.view.addSubview(alertButton)
        
        super.viewDidLoad()
        showAlert()
    }
}


