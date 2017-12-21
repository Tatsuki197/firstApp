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
           "フランス料理",
           "中国料理",
           "スペイン料理",
           "韓国料理",
           "居酒屋",
           "インド料理",
           "ワニ料理",
           "マジックバー",
           "チーズ料理",
           "レストラン",
           "海鮮料理"]

    var selectedIndex = -1
    

    
    
@IBOutlet weak var foodImage: UIImageView!


    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    @IBAction func reButton(_ sender: UIButton) {
        let r = Int(arc4random()) % food.count
        print(r)
        self.selectImg(hako:r)
        //foodName.title には、food情報が配列で入っている。
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

    

    
    
    // ボタン押されたときに発動-----------------------------------------
    @IBAction func shopDicide(_ sender: UIButton) {
 
           // セグエを通して画面移動
        self.performSegue(withIdentifier: "decide", sender: nil)
        
    }
        

    //Shop範囲セグエ(ページを紐付ける線)を使って、画面移動している時に発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var range = Int()

        //位置範囲に数字を割り当て
        print(rangeSegument.selectedSegmentIndex)
        switch rangeSegument.selectedSegmentIndex {
        case 0:
            range = 1
            print(1)
        case 1:
            range = 2
            print(2)
        case 2:
            range = 3
            print(3)
        default:
            break
        }
        ////foodリスト例（焼き鳥。。。）Api　　次の画面に情報を送る
        var foodTitle = food
        print(food)
        
        //次の画面のインスタンス（オブジェクト）を取得。
        //as! DetailViewControllerが、ダウンキャスト変換している箇所。
        
        //dvc= 次のページに情報を送る処理
        let dvc:ApiViewController = segue.destination            //segue.destination 画面の到着地点。
            as! ApiViewController
        dvc.selectedSegmentIndex = range
        dvc.foodTitle = foodName.title!
        
        //次の画面のプロパティ（メンバー変数）passedIndexに選択された行番号。移動するページに先にpassedIndexを飛ばす場所を要しする
//        dvc.passedIndex = selectedIndex                 //DetailViewControllerが持っているpassedIndexに飛ばす。
        
    }
    
  
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
        var api:ApiViewController = segue.source as! ApiViewController
        
        api.shopList = []
        api.apiTable.reloadData()
        
    }
    
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        





}
