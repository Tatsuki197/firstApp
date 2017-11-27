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

    var selectedIndex = -1
    
@IBOutlet weak var foodImage: UIImageView!

    
    @IBAction func reButton(_ sender: UIButton) {
        let r = Int(arc4random()) % food.count
        print(r)
        self.selectImg(hako:r)
         foodName.title = "\(food[r])"
    }

    @IBOutlet weak var foodName: UINavigationItem!

        
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let r = Int(arc4random()) % food.count
        print(r)
        self.selectImg(hako:r)
        // ナビゲーションバータイトル表示
        foodName.title = "\(food[r])"
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

    
//    //セルをタップしたら発動。　　紅茶の各種類の説明ページに飛ぶ。
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(indexPath.row)行目がタップされました")
//        //選択された行番号を保存
//        selectedIndex = indexPath.row
//
//        //セグエ(ページを紐付ける線)の名前を指定して、画面移動処理を発動
//        performSegue(withIdentifier: "showDetail", sender: nil)
//    }
    // ボタン押されたときに発動
    @IBAction func shopDicide(_ sender: UIButton) {
           // セグエを通して画面移動
        self.performSegue(withIdentifier: "decide", sender: nil)

        
        
    }
    
   
    
    //セグエ(ページを紐付ける線)を使って、画面移動している時に発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //次の画面のインスタンス（オブジェクト）を取得。
        //as! DetailViewControllerが、ダウンキャスト変換している箇所。
        
        let dvc:ApiViewController = segue.destination            //segue.destination 画面の到着地点。
            as! ApiViewController
        
        //次の画面のプロパティ（メンバー変数）passedIndexに選択された行番号。移動するページに先にpassedIndexを飛ばす場所を要しする
//        dvc.passedIndex = selectedIndex                 //DetailViewControllerが持っているpassedIndexに飛ばす。
        
    }
    
    
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        





}
