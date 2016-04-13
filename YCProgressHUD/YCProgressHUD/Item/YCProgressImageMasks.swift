//
//  YCProgressImageMasks.swift
//  YCProgressHUD
//
//  Created by LakesMac on 16/4/8.
//  Copyright © 2016年 iLakeYC. All rights reserved.
//

import UIKit

class YCProgressImageMasks: UIView {
    
    private var progressView = YCProgressView()
    private var imageView    = UIImageView()
    
    var progressTintColor : UIColor {
        get {
            return progressView.progressTintColor
        }
        set {
            progressView.progressTintColor = newValue
        }
    }
    
    var image: UIImage {
        get {
            return imageView.image == nil ? UIImage() : imageView.image!
        }
        set {
            imageView.image = newValue
        }
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
        imageView.userInteractionEnabled = true
        addSubview(imageView)
        addSubview(progressView)
    }
    
    override func layoutSubviews() {
        imageView.frame = self.bounds
        progressView.frame = CGRectMake(0, 0, imageView.frame.size.width, 1)
    }
    
    func begin() {
        self.progressView.begin()
    }
    func finish() {
        self.progressView.finish()
    }
    
    func reset() {
        progressView.resetProgress()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
