//
//  GradientMessageTableViewCell.swift
//  StreamChatExample
//
//  Created by Daniel Reyes Sanchez on 11/5/19.
//  Copyright © 2019 Daniel Reyes Sanchez. All rights reserved.
//

import UIKit
import SnapKit
import StreamChat

final class CustomChatFooterView: UIView {
    typealias TimerCompletion = () -> Void
    
    private var timerWorker: DispatchWorkItem?
    private var timerCompletion: TimerCompletion?
    private var timeout: TimeInterval = 0
    
    private(set) lazy var avatarView: AvatarView = {
        let avatarView = AvatarView(cornerRadius: .chatFooterAvatarRadius)
        addSubview(avatarView)
        
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.messageSpacing).priority(999)
            make.bottom.equalToSuperview().offset(-CGFloat.messageSpacing).priority(999)
            make.left.equalToSuperview().offset(CGFloat.messageEdgePadding).priority(999)
        }
        
        return avatarView
    }()
    
    private(set) lazy var activityIndicatorView: UIActivityIndicatorView = {
        let style: UIActivityIndicatorView.Style = .white
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.stopAnimating()
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { $0.center.equalTo(avatarView.snp.center) }
        return activityIndicator
    }()
    
    private(set) lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.chatMedium
        label.textColor = .chatGray
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(avatarView.snp.centerY)
            make.left.equalTo(avatarView.snp.right).offset(CGFloat.messageInnerPadding).priority(999)
            make.right.equalToSuperview().offset(-CGFloat.messageEdgePadding).priority(999)
        }
        
        return label
    }()
    
    deinit {
        timerWorker?.cancel()
    }
    
    func hide() {
        isHidden = true
        avatarView.reset()
        activityIndicatorView.stopAnimating()
        timerWorker?.cancel()
        timerWorker = nil
    }
    
    func hide(after timeout: TimeInterval) {
        self.timeout = timeout
        restartHidingTimer()
    }
    
    func restartHidingTimer() {
        timerWorker?.cancel()
        
        if timeout > 0 {
            let timerWorker = DispatchWorkItem { [weak self] in self?.hide() }
            self.timerWorker = timerWorker
            DispatchQueue.main.asyncAfter(deadline: .now() + timeout, execute: timerWorker)
        }
    }
}
