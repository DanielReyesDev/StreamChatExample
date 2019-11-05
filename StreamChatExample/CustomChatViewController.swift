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
    
    private lazy var gradeientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [almostBlack, darkSkyBlue]
        layer.locations = [0.0, 1.0]
        return layer
    }()
    
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
    
    private let composerSubview = UIView()
    
    private func styleChat() {
        
        composerView.style?.backgroundColor = darkSkyBlue
        composerView.style?.textColor = .white
        composerView.style?.placeholderTextColor = .white
        composerView.isOpaque = true
        
//        composerView.addSubview(composerSubview)
//        composerSubview.backgroundColor = .green
//        composerSubview.translatesAutoresizingMaskIntoConstraints = false
//        composerSubview.topAnchor.constraint(equalTo: composerView.topAnchor).isActive = true
//        composerSubview.leftAnchor.constraint(equalTo: composerView.leftAnchor, constant: 50).isActive = true
//        composerSubview.rightAnchor.constraint(equalTo: composerView.rightAnchor, constant: 50).isActive = true
//        composerSubview.bottomAnchor.constraint(equalTo: composerView.bottomAnchor).isActive = true
        
        
        style.incomingMessage.backgroundColor = darkSkyBlue
        //style.incomingMessage.backgroundColor
//        style.incomingMessage.chatBackgroundColor = .red
//        style.incomingMessage.backgroundColor = .green
//        style.incomingMessage.borderWidth = 0
//
//        style.outgoingMessage.chatBackgroundColor = .blue
//        style.outgoingMessage.backgroundColor = .yellow
//        style.outgoingMessage.font = .systemFont(ofSize: 15, weight: .bold)
//        style.outgoingMessage.cornerRadius = 0
//        style.outgoingMessage.showCurrentUserAvatar = true
    }
    
    // Override the default implementation of UI messages with default UIKit table view cell.
//    override func messageCell(at indexPath: IndexPath, message: Message,    readUsers: [User]) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "message") ?? UITableViewCell(style: .value2, reuseIdentifier: "message")
//        cell.textLabel?.text = message.user.name
//        cell.textLabel?.font = .systemFont(ofSize: 12, weight: .bold)
//        cell.detailTextLabel?.text = message.text
//        cell.detailTextLabel?.numberOfLines = 0
//        return cell
//    }
    
    
//    func gradient(frame: CGRect) -> CAGradientLayer {
//        let layer = CAGradientLayer()
//        layer.frame = frame
//        layer.startPoint = CGPoint(x: 0, y: 0.5)
//        layer.endPoint = CGPoint(x: 1, y: 0.5)
//        layer.colors = [UIColor.gray.cgColor, UIColor.cyan.cgColor]
//        return layer
//    }
    
//    override func messageCell(at indexPath: IndexPath, message: Message, readUsers: [User]) -> UITableViewCell {
//        guard let cell = super.messageCell(at: indexPath, message: message, readUsers: readUsers) as? MessageTableViewCell else {
//            fatalError("Error")
//        }
////        cell.imageView?.layer.insertSublayer(gradient(frame: cell.bounds), at:0)
//        return cell
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }
    
    private func setupNavbar() {
        title = nil
        navigationItem.rightBarButtonItem = nil
    }
    
}
