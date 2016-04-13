//
//  YCProgressTouchReloadView.swift
//  YCProgressHUD
//
//  Created by LakesMac on 16/4/12.
//  Copyright © 2016年 北京瀚维特科技有限公司. All rights reserved.
//

import UIKit

class YCProgressTouchReloadView: UIView, SizesProtocol {

    private var contentView = UIView()
    private var imageButton = UIButton(type: .System)
    private var messageLabel = UILabel(frame: .zero)
    private var reloadLabel  = UILabel(frame: .zero)
    
    var touched: (() -> ())?
    
    
    var tint: UIColor {
        get {
            return messageLabel.textColor
        }
        set {
            imageButton.tintColor = newValue
            messageLabel.textColor = newValue
            reloadLabel.textColor = newValue
        }
    }
    
    var background: UIColor {
        get {
            return contentView.backgroundColor!
        }
        set {
            contentView.backgroundColor = newValue
        }
    }
    
    var translucent: Bool {
        get {
            return self.backgroundColor == .clearColor()
        }
        set {
            self.backgroundColor = newValue == true ? .clearColor() : .whiteColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupAllViews() {
        addSubview(contentView)
        self.backgroundColor = .whiteColor()
        
        contentView.backgroundColor = .whiteColor()
        contentView.layer.cornerRadius = 6
        contentView.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        contentView.layer.borderWidth = 1
        contentView.layer.shadowColor = UIColor.grayColor().CGColor
        contentView.layer.shadowOffset = CGSizeMake(0, 3)
        contentView.layer.shadowOpacity = 1
        
        contentView.addSubview(imageButton)
        contentView.addSubview(messageLabel)
        contentView.addSubview(reloadLabel)
        
        imageButton.setImage(UIImage(named: "faliure"), forState: .Normal)
        imageButton.tintColor = .blackColor()
        messageLabel.text = "加载失败了"
        messageLabel.textAlignment = .Center
        messageLabel.font = .systemFontOfSize(14)
        
        reloadLabel.text = "轻点重新加载"
        reloadLabel.font = .systemFontOfSize(14)
        reloadLabel.textAlignment = .Center
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapAction)))
    }

    override func layoutSubviews() {
        contentView.frame = CGRectMake(0, 0, self.widthRate(121), self.heightRate(133))
        contentView.center = CGPointMake(self.bounds.width / 2, self.bounds.height / 2 - 40)
        imageButton.frame = CGRectMake(0, 10, self.widthRate(64), self.heightRate(64))
        imageButton.center = CGPointMake(contentView.bounds.width / 2, imageButton.center.y)
        messageLabel.frame = CGRectMake(0, imageButton.bounds.height + imageButton.frame.origin.y, contentView.bounds.width, (contentView.bounds.height - imageButton.bounds.height - imageButton.frame.origin.y) / 2)
        reloadLabel.frame = CGRectMake(0, messageLabel.frame.origin.y + messageLabel.frame.height, messageLabel.frame.width, messageLabel.frame.height)
    }
    
    func tapAction() {
        self.touched?()
    }
}
