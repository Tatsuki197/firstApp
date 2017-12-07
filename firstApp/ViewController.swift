//
//  ViewController.swift
//  firstApp
//
//  Created by Tatsuki Nakatsuka on 2017/11/15.
//  Copyright © 2017年 Tatsuki Nakatsuka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

var food = ["焼き鳥",
           "イタリアン",
           "お好み焼き",
           "お寿司",
           "焼肉",
           "ステーキ",
           "フレンチ料理",
           "中華料理",
           "スペイン料理",
           "韓国料理",
           "大衆居酒屋",
           "インド料理",
           "ワニ料理",
           "マジックバー",
           "チーズ料理",
           "ホテルレストラン",
           "海鮮料理"]

    var selectedIndex = -1
    
@IBOutlet weak var foodImage: UIImageView!


    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    @IBAction func reButton(_ sender: UIButton) {
        let r = Int(arc4random()) % food.count
        print(r)
        self.selectImg(hako:r)
         foodName.title = "\(food[r])"
    }

    @IBOutlet weak var foodName: UINavigationItem!

        
    @IBOutlet weak var rangeSegument: UISegmentedControl!
    
    @IBOutlet weak var budgetButton: UISegmentedControl!
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let r = Int(arc4random()) % food.count
        print(r)
        self.selectImg(hako:r)
        // ナビゲーションバータイトル表示
        foodName.title = "\(food[r])"
//
        
        rangeSegument.frame = CGRect(x: 0, y: 292, width: 320, height: 29)
        
        budgetButton.frame = CGRect(x: 20, y: 376, width: 279, height: 29)
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
            foodImage.image = UIImage(named:"a_0.jpg")
        case 1:
            foodImage.image = UIImage(named:"a_1.jpg")
        case 2:
            foodImage.image = UIImage(named:"a_2.jpg")
        case 3:
            foodImage.image = UIImage(named:"a_3.jpg")
        case 4:
            foodImage.image = UIImage(named:"a_4.jpg")
        case 5:
            foodImage.image = UIImage(named:"a_5.jpg")
        case 6:
            foodImage.image = UIImage(named:"a_6.jpg")
        case 7:
            foodImage.image = UIImage(named:"a_7.jpg")
        case 8:
            foodImage.image = UIImage(named:"a_8.jpg")
        case 9:
            foodImage.image = UIImage(named:"a_9.jpg")
        case 10:
            foodImage.image = UIImage(named:"a_10.jpg")
        case 11:
            foodImage.image = UIImage(named:"a_11.jpg")
        case 12:
            foodImage.image = UIImage(named:"a_12.jpg")
        case 13:
            foodImage.image = UIImage(named:"a_13.jpg")
        case 14:
            foodImage.image = UIImage(named:"a_14.jpg")
        case 15:
            foodImage.image = UIImage(named:"a_15.jpg")
        case 16:
            foodImage.image = UIImage(named:"a_16.jpg")
            
        default: //2
            break
        }
    
        

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
        var range = Int()
        
        
        print(rangeSegument.selectedSegmentIndex)
//        switch rangeSegument.selectedSegmentIndex {
//        case 0:
//            range = 300
//            print(300)
//        case 1:
//            range = 500
//            print(500)
//        case 2:
//            range = 1000
//            print(1000)
//        default:
//            break
//        }
        
        //次の画面のインスタンス（オブジェクト）を取得。
        //as! DetailViewControllerが、ダウンキャスト変換している箇所。
        
        let dvc:ApiViewController = segue.destination            //segue.destination 画面の到着地点。
            as! ApiViewController
        dvc.selectedSegmentIndex = rangeSegument.selectedSegmentIndex
        
        //次の画面のプロパティ（メンバー変数）passedIndexに選択された行番号。移動するページに先にpassedIndexを飛ばす場所を要しする
//        dvc.passedIndex = selectedIndex                 //DetailViewControllerが持っているpassedIndexに飛ばす。
        
    }
    
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
        
    }
    
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        





}
