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
    
    private let sendButton = UIButton(type: .custom)
    private let attachImageButton = UIButton(type: .custom)
    private let attachFileButton = UIButton(type: .custom)
    
    private lazy var composerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = darkSkyBlue
        return view
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
    
    private func styleChat() {
        style.incomingMessage.backgroundColor = darkSkyBlue
        setupComposerView()
    }
    
    private func setupComposerView() {
        style.composer.edgeInsets = .init(top: 8, left: 88, bottom: 8, right: 55)
        style.composer.backgroundColor = .white
        style.composer.textColor = .black
        style.composer.height = 32
        style.composer.cornerRadius = 32/2
        style.composer.sendButtonVisibility = .none
        addComponserContainer()
        addCustomSendButton()
        addCustomAttachmentButtons()
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
    
}

extension CustomChatViewController {
    private func addComponserContainer() {
        view.insertSubview(composerContainer, belowSubview: composerView)
        composerContainer.snp.makeConstraints { make in
            make.top.equalTo(composerView.snp.top).offset(-8)
            make.bottom.equalTo(composerView.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    
    private func addCustomAttachmentButtons() {
        attachImageButton.setImage(UIImage(named: "image")?.withRenderingMode(.alwaysTemplate), for: .normal)
        attachFileButton.setImage(UIImage(named: "file")?.withRenderingMode(.alwaysTemplate), for: .normal)
        attachImageButton.tintColor = .white
        attachFileButton.tintColor = .white
        
        composerContainer.addSubview(attachImageButton)
        composerContainer.addSubview(attachFileButton)
        attachImageButton.snp.makeConstraints { make in
            make.centerY.equalTo(composerContainer.snp.centerY)
            make.right.equalTo(composerView.snp.left).offset(-16)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        attachFileButton.snp.makeConstraints { make in
            make.centerY.equalTo(composerContainer.snp.centerY)
            make.right.equalTo(attachImageButton.snp.left).offset(-8)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
    }
    
    private func addCustomSendButton() {
        sendButton.setImage(UIImage(named: "send")?.withRenderingMode(.alwaysTemplate), for: .normal)
        sendButton.tintColor = .white
        composerContainer.addSubview(sendButton)
        
        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(composerContainer.snp.centerY)
            make.right.equalTo(composerContainer.snp.right).offset(-15)
        }
        
        // React on visibility state of the sendButton.
        composerView.sendButtonVisibility
            .subscribe(onNext: { [weak self] visibility in self?.sendButton.isEnabled = visibility.isEnabled })
            .disposed(by: disposeBag)
        
        // Send a message.
        sendButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.send() })
            .disposed(by: disposeBag)
    }
}

extension CustomChatViewController {
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
