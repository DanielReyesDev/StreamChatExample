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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let channel = Channel(type: .messaging, id: "general")
        channelPresenter = ChannelPresenter(channel: channel)
        setupChannel()
        styleChat()
    }
    
    private func setupChannel() {
        let channel = Channel(type: .messaging, id: "general")
        channelPresenter = ChannelPresenter(channel: channel)
    }
    
    private func styleChat() {
        style.incomingMessage.chatBackgroundColor = UIColor(hue: 0.2, saturation: 0.3, brightness: 1, alpha: 1)
        style.incomingMessage.backgroundColor = UIColor(hue: 0.6, saturation: 0.5, brightness: 1, alpha: 1)
        style.incomingMessage.borderWidth = 0
        
        style.outgoingMessage.chatBackgroundColor = style.incomingMessage.chatBackgroundColor
        style.outgoingMessage.backgroundColor = style.incomingMessage.chatBackgroundColor
        style.outgoingMessage.font = .systemFont(ofSize: 15, weight: .bold)
        style.outgoingMessage.cornerRadius = 0
        style.outgoingMessage.showCurrentUserAvatar = false
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // Override the default implementation of UI messages with default UIKit table view cell.
    override func messageCell(at indexPath: IndexPath, message: Message,    readUsers: [User]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message") ?? UITableViewCell(style: .value2, reuseIdentifier: "message")
        cell.textLabel?.text = message.user.name
        cell.textLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        cell.detailTextLabel?.text = message.text
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }

}
