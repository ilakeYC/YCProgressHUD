//
//  YCPopTipsView.swift
//  YCProgressHUD
//
//  Created by LakesMac on 16/4/8.
//  Copyright © 2016年 iLakeYC. All rights reserved.
//

import UIKit

private let screenBounds = UIScreen.mainScreen().bounds
private let spacings: CGFloat = 12

class YCPopTipsView: UIView {
    
    private var timer: NSTimer?
    private let labelContentView = UIView()
    private let titleLabel = UILabel()
    private var __title = ""

    private var __textColor = UIColor.darkGrayColor()
    private var __backgroundColor = UIColor.whiteColor()
    
    var timeRemain: Double = 0
    var showing = false
    
    ///已经消失
    var hasHides: (() -> ())?
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    init() {
        super.init(frame: screenBounds)
        setupAllViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupAllViews() {
//        self.userInteractionEnabled = false
        addSubview(labelContentView)
        labelContentView.layer.cornerRadius = 6
//        labelContentView.layer.masksToBounds = true
        labelContentView.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        labelContentView.layer.borderWidth = 1
        labelContentView.layer.shadowColor = UIColor.grayColor().CGColor
        labelContentView.layer.shadowOffset = CGSizeMake(0, 3)
        labelContentView.layer.shadowOpacity = 1

        titleLabel.textColor = __textColor
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 0
        labelContentView.backgroundColor = __backgroundColor
        labelContentView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        self.frame = screenBounds
        let labelSize = titleLabelSize()
        titleLabel.textColor = __textColor
        labelContentView.backgroundColor = __backgroundColor
        titleLabel.text = __title
        labelContentView.frame = CGRectMake(0, 0, spacings * 2 + labelSize.width, spacings * 2 + labelSize.height)
        labelContentView.center = CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2 + self.bounds.size.height / 2 * 0.382)
        titleLabel.frame = CGRectMake(0, 0, labelSize.width, labelSize.height)
        titleLabel.center = CGPointMake(labelContentView.bounds.size.width / 2, labelContentView.bounds.size.height / 2)
    }
    
    private func titleLabelSize() -> CGSize {
        let maxSize = CGSizeMake(screenBounds.size.width * 0.618, screenBounds.size.height * 0.618)
        let text = NSString(string: __title)
        let frame = text.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [
            NSFontAttributeName: titleLabel.font
            ], context: nil)
        return frame.size
    }
    
    
    private func timerStart() {
        if timer != nil {
            return
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        timeRemain -= 0.1
        if timeRemain < 0 {
            self.hidden()
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func show(title: String, inSecond: Double) {
        if title == "" {
            return
        }
        __title = title
        timeRemain = inSecond
        self.setNeedsLayout()
        self.show()
    }
    
    private func show() {
        if self.showing {
            return
        }
        self.showing = true
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.alpha = 0
        appDelegate.window?.addSubview(self)
        UIView.animateWithDuration(0.2, animations: { 
            self.alpha = 1
            }) { (finished) in
                if finished {
                    self.timerStart()
                }
        }
    }
    
    private func hidden() {
        if !self.showing {
            return
        }
        self.showing = false
        UIView.animateWithDuration(0.2, animations: {
            self.alpha = 0
            }) { (finished) in
                if finished {
                    self.hasHides?()
                    self.removeFromSuperview()
                }
        }
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
