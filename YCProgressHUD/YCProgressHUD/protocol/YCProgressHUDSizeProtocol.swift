
//
//  YCProgressHUDSizeProtocol.swift
//  YCProgressHUD
//
//  Created by LakesMac on 16/4/12.
//  Copyright © 2016年 北京瀚维特科技有限公司. All rights reserved.
//

import UIKit


protocol SizesProtocol {
    
    var screenBounds : CGRect { get }
    
    var screenSize : CGSize { get }
    
    var screenWidth : CGFloat { get }
    
    var screenHeight : CGFloat { get }
    
    func widthRate(width: CGFloat) -> CGFloat
    func heightRate(height: CGFloat) -> CGFloat
}

extension SizesProtocol {
    
    var screenBounds : CGRect {
        return UIScreen.mainScreen().bounds
    }
    
    var screenSize : CGSize {
        return screenBounds.size
    }
    
    var screenWidth : CGFloat {
        return screenSize.width
    }
    
    var screenHeight : CGFloat {
        return screenSize.height
    }
    
    func widthRate(width: CGFloat) -> CGFloat {
        return (width / 375) * screenWidth
    }
    
    func heightRate(height: CGFloat) -> CGFloat {
        return (height / 667) * screenHeight
    }
}