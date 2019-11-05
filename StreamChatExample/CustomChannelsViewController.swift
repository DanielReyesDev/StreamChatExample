//
//  CustomChannelsViewController.swift
//  StreamChatExample
//
//  Created by Daniel Reyes Sanchez on 11/5/19.
//  Copyright © 2019 Daniel Reyes Sanchez. All rights reserved.
//

import UIKit
import StreamChat
import StreamChatCore

final class CustomChannelsViewController: ChannelsViewController {
    override func channelCell(at indexPath: IndexPath, channelPresenter: ChannelPresenter) -> UITableViewCell {
        let cell = super.channelCell(at: indexPath, channelPresenter: channelPresenter)
        guard let channelCell = cell as? ChannelTableViewCell else {
            return cell
        }
        // Check the number of unread messages.
//        if channelPresenter.unreadCount > 0 {
//            // Add the info about unread messages to the cell.
//            channelCell.update(info: "\(channelPresenter.unreadCount) unread", isUnread: true)
//        }
        return channelCell
    }
    
    override func createChatViewController(with channelPresenter: ChannelPresenter, indexPath: IndexPath) -> ChatViewController {
        return CustomChatViewController()
    }
}
