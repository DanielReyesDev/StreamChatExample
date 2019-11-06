//
//  UIViewController+TitleView.swift
//  StreamChatExample
//
//  Created by Daniel Reyes Sanchez on 11/6/19.
//  Copyright © 2019 Daniel Reyes Sanchez. All rights reserved.
//

import UIKit

extension UIViewController {
    func setProfileTitleView(name: String, image: UIImage? = nil) {
        guard let width = self.navigationController?.navigationBar.frame.width else { return }
        let titleViewHalfHeight: CGFloat = 44.0 / 2
        let paddingForImageView = titleViewHalfHeight - 25 / 2
        let paddingForLabel = titleViewHalfHeight - 20.5 / 2
        
        let titleLabel = UILabel(frame: CGRect(x: 25 + 8, y: paddingForLabel, width: 0, height: 0))
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = name
        titleLabel.sizeToFit()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: paddingForImageView, width: 25, height: 25))
        imageView.image = image
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 25/2
        imageView.clipsToBounds = true
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        titleView.addSubview(titleLabel)
        titleView.addSubview(imageView)
        
        self.navigationItem.titleView = titleView
    }
}
