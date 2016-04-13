//
//  YCProgressView.swift
//  YCProgressHUD
//
//  Created by LakesMac on 16/4/8.
//  Copyright © 2016年 iLakeYC. All rights reserved.
//

import UIKit

class YCProgressView: UIView {

    private var progressView = UIProgressView(progressViewStyle: .Default)
    
    
    /// 完成部分渲染颜色
    var progressTintColor: UIColor {
        get {
            return self.progressView.progressTintColor!
        }
        set {
            self.progressView.progressTintColor = newValue
        }
    }
    
    ///未完成部分渲染颜色
    var trackTintColor: UIColor {
        get {
            return self.progressView.trackTintColor!
        }
        set {
            self.progressView.trackTintColor = newValue
        }
    }
    
    ///完成进度 0...1
    var progress: Float {
        get {
            return self.progressView.progress
        }
        set {
            self.progressView.setProgress(newValue, animated: true)
        }
    }
    
    func resetProgress() {
        progressView.progress = 0.3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAllViews()
    }
    
    private func setupAllViews() {
        progressView.progressTintColor = UIColor.orangeColor()
        progressView.trackTintColor = UIColor.groupTableViewBackgroundColor()
        addSubview(progressView)
    }
    
    override func layoutSubviews() {
        progressView.frame = CGRectMake(0, 0, self.bounds.size.width, 1)
    }
    
    func begin() {
        progress = 0.3
    }
    func finish() {
        progress = 1.0
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
