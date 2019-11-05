//
//  AppDelegate.swift
//  StreamChatExample
//
//  Created by Daniel Reyes Sanchez on 11/4/19.
//  Copyright © 2019 Daniel Reyes Sanchez. All rights reserved.
//

import UIKit
import StreamChat
import StreamChatCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureStreeamChatClient()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: makeChannelsViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    func configureStreeamChatClient() {
        Client.config = .init(apiKey: "g9fmk3wvuh33")
        Client.shared.set(user: User(id: "curly-poetry-5", name: "Curly poetry"),
                          token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiY3VybHktcG9ldHJ5LTUifQ.X1-_u2JQNz6mfoNL0cx2M-QXW17jHOaTe5A_mikbUdU")
    }
    
    func makeChannelsViewController() -> ChannelsViewController {
        let channelsViewController = CustomChannelsViewController()
        channelsViewController.channelsPresenter = .init(channelType: .messaging, filter: .key("members", .in(["curly-poetry-5"])))
        return channelsViewController
    }
    
}

