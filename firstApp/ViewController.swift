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

        conectApi()
        
    }
    
    func conectApi() {
        print(#function)
        // 取得したJSONを格納する変数を定義
        var getJson: NSDictionary!
        
        // 抽出した"ip"を格納する変数を定義
        var jsonIp = ""
        
        // 抽出した"hostname"を格納する変数を定義
        var jsonHostname = ""
        
        // 抽出した"ip"と"hostname"を結合する変数を定義
        var jsonString = ""
        
        // TODO: API接続先　日本語を変換する処理が必要
        let urlStr = "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=d8bb513cb61392fcca6395309303369b&format=json&latitude=&longitude=&range=1&hit_per_page=10&freeword="
        let url = URL(string: urlStr)
        
        if url != nil {
            let req = NSMutableURLRequest(url: url!)
            req.httpMethod = "GET"
            // req.httpBody = "userId=\(self.userId)&code=\(self.code)".data(using: String.Encoding.utf8)
            print(req)
            //TODO:taskに何も入ってないので終了する
            let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
                print(resp!.url!)
                print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as Any)
                
                // 受け取ったdataをJSONパース、エラーならcatchへジャンプ
                do {
                    // dataをJSONパースし、変数"getJson"に格納
                    getJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    jsonIp = (getJson["total_hit_count"] as? String)!
                    jsonHostname = (getJson["Hostname"] as? String)!
                    jsonString = "m9(・∀・)NW情報ゲトしますた！\n\nGlobalIP : " + jsonIp + "\nISP FQDN : " + jsonHostname
                    
                    print (jsonIp)
                    print (jsonHostname)
                    
                    DispatchQueue.main.async{
               
                        print(jsonString)
                    }
                } catch {
                    print ("json error")
                    return
                }
            })
            task.resume()
        }
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
