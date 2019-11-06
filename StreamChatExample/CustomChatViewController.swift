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
    
    private lazy var sendButton = UIButton(type: .custom)
    
    private lazy var attachImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "image")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(attachImageAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var attachFileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "file")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(attachFileAction), for: .touchUpInside)
        return button
    }()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavbar()
    }
    
    private func setupNavbar() {
        navigationItem.setRightBarButton(settinsBarButtonItem, animated: false)
        setProfileTitleView(name: "Equipo Diseño Multimedia")
    }
    
    @objc private func settingsAction() {
        print(#function)
    }
    
    @objc private func attachImageAction() {
        showImagePicker(composerAddFileViewSourceType: .photo(.savedPhotosAlbum))
    }
    
    @objc private func attachFileAction() {
        showDocumentPickerController()
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
    private func showImagePicker(composerAddFileViewSourceType sourceType: ComposerAddFileView.SourceType) {
        guard case .photo(let pickerSourceType) = sourceType else {
            return
        }
        
        showImagePicker(sourceType: pickerSourceType) { [weak self] pickedImage, status in
            guard status == .authorized else {
                self?.showImpagePickerAuthorizationStatusAlert(status)
                return
            }
            
            guard let channel = self?.channelPresenter?.channel else {
                return
            }
            
            if let pickedImage = pickedImage, let uploaderItem = UploaderItem(channel: channel, pickedImage: pickedImage) {
                self?.composerView.addImageUploaderItem(uploaderItem)
            }
        }
    }
    
    private func showDocumentPickerController() {
        let documentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPickerViewController.allowsMultipleSelection = true
        documentPickerViewController.rx.didPickDocumentsAt
            .takeUntil(documentPickerViewController.rx.deallocated)
            .subscribe(onNext: { [weak self] in
                if let self = self, let channel = self.channelPresenter?.channel {
                    $0.forEach { url in self.composerView.addFileUploaderItem(UploaderItem(channel: channel, url: url)) }
                }
            })
            .disposed(by: disposeBag)
        present(documentPickerViewController, animated: true)
    }
}
