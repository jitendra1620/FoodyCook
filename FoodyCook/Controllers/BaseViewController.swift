//
//  BaseViewController.swift
//  FoodyCook
//
//  Created by auriga on 6/27/21.
//

import UIKit

class BaseViewController: UIViewController {
    var activityView = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showActivityIndecator() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
        self.view.isUserInteractionEnabled = false
        activityView.hidesWhenStopped = true
    }
    func hideActivityIndecator() {
        self.activityView.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
}

