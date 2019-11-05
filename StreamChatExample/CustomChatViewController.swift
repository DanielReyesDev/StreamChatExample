//
//  CustomChatViewController.swift
//  StreamChatExample
//
//  Created by Daniel Reyes Sanchez on 11/5/19.
//  Copyright © 2019 Daniel Reyes Sanchez. All rights reserved.
//

import UIKit
import StreamChat
import StreamChatCore

final class CustomChatViewController: ChatViewController {
    
    private let almostBlack = UIColor(red: 7/255, green: 12/255, blue: 13/255, alpha: 1.0)
    private let darkSkyBlue = UIColor(red: 65/255, green: 143/255, blue: 222/255, alpha: 1.0)
    
    private lazy var settinsBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(settingsAction))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let channel = Channel(type: .messaging, id: "general")
        channelPresenter = ChannelPresenter(channel: channel)
        setupChannel()
        styleChat()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupChannel() {
        let channel = Channel(type: .messaging, id: "general")
        channelPresenter = ChannelPresenter(channel: channel)
    }
    
    private func styleChat() {
        composerView.style?.backgroundColor = darkSkyBlue
        composerView.style?.textColor = .white
        composerView.style?.placeholderTextColor = .white
        composerView.isOpaque = true
        style.incomingMessage.backgroundColor = darkSkyBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }
    
    private func setupNavbar() {
        title = nil
        setProfileTitleView(name: "Equipo Diseño Multimedia")
        navigationItem.setRightBarButton(settinsBarButtonItem, animated: false)
    }
    
    @objc private func settingsAction() {
        print(#function)
    }
    
    private func setProfileTitleView(name: String, image: UIImage? = nil) {
        guard let width = self.navigationController?.navigationBar.frame.width else { return }
        let titleViewHalfHeight:CGFloat = 44.0 / 2
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
