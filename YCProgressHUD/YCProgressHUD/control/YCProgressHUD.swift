//
//  YCProgressHUD.swift
//  YCProgressHUD
//
//  Created by LakesMac on 16/4/8.
//  Copyright © 2016年 iLakeYC. All rights reserved.
//

import UIKit

public enum YCProgressHUDStyle {
    case Default;
    case PlaceholderImageWithProgress
}

public class YCProgressHUD: NSObject {
    
    
    
    static let tipsView = YCPopTipsView()
    
    private weak var __superView: UIView?
    private      var __image: UIImage?
    
    private lazy var __imageWithProgress = YCProgressImageMasks(frame: .zero)
    private lazy var __actibityView      = YCProgressViewWithActivityView(frame: .zero)
    private lazy var __faliureView       = YCProgressTouchReloadView(frame: .zero)
    
    public var style: YCProgressHUDStyle = .Default
    public var isShowing = false
    public var tintColor       = UIColor.orangeColor()
    public var backgroundColor = UIColor.whiteColor()
    
    var animatedComplete: (() -> ())?
    
    public init(style: YCProgressHUDStyle) {
        super.init()
        self.style = style
        if style == .PlaceholderImageWithProgress {
            print("!  PlaceholderImageWithProgress样式在透明导航栏下可能会出现问题")
        }
    }
    
    
    ///设置图片
    public func image(image: UIImage?)
        -> YCProgressHUD {
        __image = image
        return self
    }
    
    ///设置无图
    public func noImage()
        -> YCProgressHUD {
            return self.image(UIImage())
    }
    
    ///渲染颜色
    public func tintColor(color: UIColor)
        -> YCProgressHUD {
            self.tintColor = color
            return self
    }
    
    ///背景颜色
    public func backGroundColor(color: UIColor)
        -> YCProgressHUD {
            self.backgroundColor = color
            return self
    }
    
    ///设置父试图
    public func inView(inView: UIView)
        -> YCProgressHUD {
        __superView = inView
        return self
    }
    
    //************************************************************************************************************
    // - MARK: -
    ///开始
    public func show()
        -> YCProgressHUD {
        switch style {
        case .PlaceholderImageWithProgress:
            self.showImageWithProgress()
            break
            
        case .Default :
            self.showActivityView()
            break
        }
        return self
    }
    
    ///完成
    public func finish()
        -> YCProgressHUD {
        if !isShowing {
            return self
        }
        
        switch style {
        case .PlaceholderImageWithProgress:
            self.finishImageWithProgress()
            break
            
        case .Default :
            self.finishActivityView()
            break
        }
        return self
    }
    
    public func faliure(touched: (() -> ()))
        -> YCProgressHUD {
            self.finish()
            self.showFaliure { 
                touched()
            }
            return self
    }
    
    
    
    //************************************************************************************************************
    // - MARK: - 弹出文字指示器
    ///弹出标题 1秒
    class func show(tips: String) {
        self.tipsView.show(tips, inSecond: 1)
    }
    
    ///弹出标题 1秒，并包括消失的回调
    class func show(tips: String, finish: (() -> ())) {
        self.show(tips)
        self.tipsView.hasHides = {
            finish()
        }
    }
    
    ///弹出标题
    class func show(tips: String, inSecond: Double) {
        self.tipsView.show(tips, inSecond: inSecond)
    }
    
    ///弹出标题，并包括消失的回调
    class func show(tips: String, inSecond: Double, finish: (() -> ())) {
        self.show(tips, inSecond: inSecond)
        self.tipsView.hasHides = {
            finish()
        }
    }
}

private extension YCProgressHUD {
    
    func showImageWithProgress() {
        if __superView == nil {
            return
        }
        if __image != nil {
            self.__imageWithProgress.image = __image!
        }
        
        __imageWithProgress.alpha = 1
        __imageWithProgress.begin()
        __imageWithProgress.frame = __superView!.bounds
        __imageWithProgress.progressTintColor = tintColor
        self.__superView?.addSubview(__imageWithProgress)
        self.isShowing = true
        
    }
    
    func finishImageWithProgress() {
        __imageWithProgress.finish()
        self.performSelector(#selector(__hidesImageWithProgress), withObject: self, afterDelay: 0.5)
    }
    
    @objc func __hidesImageWithProgress() {
        UIView.animateWithDuration(0.4, animations: {
            self.__imageWithProgress.alpha = 0
        }) { (finished) in
            if finished {
                self.isShowing = false
                self.__imageWithProgress.reset()
                self.__imageWithProgress.removeFromSuperview()
                self.animatedComplete?()
            }
        }
    }
    
    
    //************************************************************************************************************
    func showActivityView() {
        if __superView == nil {
            return
        }
        __actibityView.alpha = 0
        __actibityView.frame = __superView!.bounds
        __actibityView.activityContentView.backgroundColor = backgroundColor
        __actibityView.activityView.color = tintColor
        self.__superView?.addSubview(__actibityView)
        self.isShowing = true
        UIView.animateWithDuration(0.2) {
            self.__actibityView.alpha = 1
        }
    }
    
    func finishActivityView() {
        UIView.animateWithDuration(0.2, animations: { 
            self.__actibityView.alpha = 0
            }) { (finished) in
                if finished {
                    self.isShowing = false
                    self.__actibityView.removeFromSuperview()
                }
        }
    }
    
    //************************************************************************************************************
    
    func showFaliure(touched: (() -> ())) {
        if __superView == nil {
            return
        }
        
        __faliureView.alpha = 0
        __faliureView.frame = __superView!.bounds
        __faliureView.tint = tintColor
        __faliureView.background = backgroundColor
        __superView?.addSubview(__faliureView)
        UIView.animateWithDuration(0.2) { 
            self.__faliureView.alpha = 1
        }
        __faliureView.touched = {
            self.__faliureView.removeFromSuperview()
            touched()
        }
    }
}
