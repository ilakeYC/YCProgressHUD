//
//  ViewController.swift
//  YCProgressHUD
//
//  Created by LakesMac on 16/4/8.
//  Copyright © 2016年 iLakeYC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let hud = YCProgressHUD(style: YCProgressHUDStyle.Default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "神马新闻"
        hud.inView(self.view).tintColor(UIColor.orangeColor()).image(UIImage(named: "placeHoder")).show()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if hud.isShowing {
            hud.finish()
        } else {
            hud.show()
        }
    }
    
}
