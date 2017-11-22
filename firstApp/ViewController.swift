//
//  ViewController.swift
//  firstApp
//
//  Created by Tatsuki Nakatsuka on 2017/11/15.
//  Copyright © 2017年 Tatsuki Nakatsuka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

var food = ["魚",
           "お好み焼き",
           "肉"]

@IBOutlet weak var foodImage: UIImageView!

    
    @IBAction func reButton(_ sender: UIButton) {
        
    let r = Int(arc4random()) % food.count
        print(r)
        self.selectImg(hako:r)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let r = Int(arc4random()) % food.count
        print(r)
        self.selectImg(hako:r)
        
//
//        // 表示する画像を設定する.
//        var myImage = UIImage(named: "\(foodImage)")
//
//        // 画像をUIImageViewに設定する.
//        myImageView.image = foodImage
//
      
}
            
    func selectImg(hako:Int){
        switch hako{
        case 0:
            foodImage.image = UIImage(named:"a_1.jpg")
        case 1:
            foodImage.image = UIImage(named:"a_2.jpg")
        default: //2
            foodImage.image = UIImage(named:"a_3.jpg")
        }
//
////        let notificationCenter = NotificationCenter.default
////        notificationCenter.addObserver(
////            self,
////            selector: Selector(("myImage:")),
////            name:NSNotification.Name.UIApplicationDidFinishLaunching,
////            object: nil)
//

    }

    
   
    
    
    
    


    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        





}
