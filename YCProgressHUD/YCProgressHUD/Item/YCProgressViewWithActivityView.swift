//
//  YCProgressViewWithActivityView.swift
//  YCProgressHUD
//
//  Created by LakesMac on 16/4/8.
//  Copyright © 2016年 iLakeYC. All rights reserved.
//

import UIKit

class YCProgressViewWithActivityView: UIView {
    let activityView        = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let activityContentView = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupAllViews() {
        addSubview(activityContentView)
        activityContentView.addSubview(activityView)
        
        activityContentView.layer.cornerRadius = 6
        activityContentView.layer.shadowColor = UIColor.grayColor().CGColor
        activityContentView.layer.shadowOffset = CGSizeMake(0, 3)
        activityContentView.layer.shadowOpacity = 1
        
        activityView.startAnimating()
    }
    
    override func layoutSubviews() {
        activityContentView.frame  = CGRectMake(0, 0, 64, 64)
        activityContentView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
        activityView.center = CGPointMake(activityContentView.bounds.size.width / 2, activityContentView.bounds.size.height / 2)
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
