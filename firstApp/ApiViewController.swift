//
//  ApiViewController.swift
//  firstApp
//
//  Created by Tatsuki Nakatsuka on 2017/11/19.
//  Copyright © 2017年 Tatsuki Nakatsuka. All rights reserved.
//

import UIKit
//import CoreData
import Photos

class ApiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//プロトコル追加
    
    
    //表示したいデータ（配列）
    
    var shopList:[Any] = []
    var selectedSaveDate = Date()

    
//    "0",
//    "1",
//    "2",
//    "3",
//    "4",
//    "5",
//    "6",
//    "7",
//    "8",
//    "9"
    
    @IBOutlet weak var apiTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conectApi()
        
        //            override = 起動するときに　プラスαの表示、動きをする。
        
        
        //Storyboadで設定する（PickerViewの時はプログラムで指定する）
        //4.TableViewに指示をだすのがViwwControllerだと設定する
        //myTableView.delegate = self プログラムで書く場合
        //myTableView.dataSource = self プログラムで書く場合
        
        //5.tableViewにCellオブジェクトを追加してindentifierに「Cell」という名前をつける
        
    }
  
    func conectApi() {
//        print(#function)
        // 取得したJSONを格納する変数を定義
        var getJson: NSDictionary!
        
        // 抽出した"ip"を格納する変数を定義
        var jsonIp = ""
        
        // 抽出した"hostname"を格納する変数を定義
        var jsonRest = Array<Any>()
        
        // 抽出した"ip"と"hostname"を結合する変数を定義
        var jsonString = ""
        
        // TODO: API接続先　日本語を変換する処理が必要ーーーーーーーーーーーーーーーーーーーーーーー
        let urlStr = "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=d8bb513cb61392fcca6395309303369b&format=json&latitude=&longitude=&range=1&hit_per_page=10&freeword=%E3%83%AF%E3%83%8B%E6%96%99%E7%90%86"
        let url = URL(string: urlStr)
        
        if url != nil {
            let req = NSMutableURLRequest(url: url!)
            req.httpMethod = "GET"
            // req.httpBody = "userId=\(self.userId)&code=\(self.code)".data(using: String.Encoding.utf8)
//            print(req)
            //TODO:taskに何も入ってないので終了するーーーーーーーーーーーーーーーーーーーーーーー
            let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
//                print(resp!.url!)
//                print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as Any)
                
                // 受け取ったdataをJSONパース、エラーならcatchへジャンプ
                do {
                    // dataをJSONパースし、変数"getJson"に格納
                    getJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    jsonIp = (getJson["total_hit_count"] as? String)!
                    jsonRest = (getJson["rest"] as? Array)!
                    
                    
                    
//                    print (jsonIp)
                    print (jsonRest)
                    self.shopList = jsonRest
                    
                    self.apiTable.reloadData()
                    DispatchQueue.main.async{
                        
//                        print(jsonString)
                    }
                } catch {
                    print ("json error")
                    return
                }
            })
            task.resume()
        }
    }
    
    //何行目が選択されたか保存する変数.
    //-1は何もまだ行番号が保存されていないという目印。
    var selectedIndex = -1
    

    
    
    //2.行数の決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                var retValue = 0

                    retValue = 10

        //エラーがなかなか消えない時はcommand+shift+kで一旦エラーを削除r
        return shopList.count       //変数.countは、変数の中の配列を数を数える。
    }
    //    ３.リストに表示する文字列を決定し、表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //文字列を表示するセルの取得（セルの再利用） indexPath→セルの中に入る
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! apiTableViewCell
        //表示したい文字の設定
        //        cell.textLabel?.text = "\(indexPath.row)行目"
            cell.textLabel!.text = "\(shopList[indexPath.row])"
       
            cell.textLabel?.textColor = UIColor.brown
        let dic = shopList[indexPath.row] as!NSDictionary
            cell.shopName.text = dic["name_kana"] as? String
        
//        let url = URL(string: shopList[indexPath.row]["image"] as! String);

        var shopurl = dic["image_url"] as! NSDictionary
        print(shopurl["shop_image1"])
//        if (shopurl["shop_image1"] == "")  {
//        
//        let foodImageurl = URL(string: shopurl["shop_image1"] as! String)
//        }else{
//        let foodImageurl = URL(string: shopurl["shop_image1"] as! String)
//            var err: NSError?;
//            let shopdata :Data = (try! Data(contentsOf: foodImageurl!,options: NSData.ReadingOptions.mappedIfSafe));
//            let foodImage = UIImage(data:shopdata);
//            //            cell.foodImage.image = UIImage(named:"noimage.png")
//            cell.foodImage.image = foodImage
//
//        }
//       
//        if (foodImageurl != nil)  {
//
//            cell.foodImage.image = UIImage(named:"noimage.png")
//        }

        
        
        //        cell.sentence.text = dic["sentence"] as? String
        //        cell.shopUrl.text = dic["url"] as? String
        //        cell.foodImage.image = dic["image_url"] as? UIImage
        //        cell.foodImage.image = UIImage(named:"")
////        cell.foodImage.image = UIImage(named:dic["image_url"] as! String)
//        print(cell.textLabel)
//        print(cell.textLabel!)
// let foodImage = URL(string: "https://uds.gnst.jp/rest/img/26xd257k0000/t_0nck.jpg")
       
//
//
//        let shopdata = try? Data(contentsOf: shopurl!)
//        let foodImage: UIImage = UIImage(data: shopdata!)!
//
//
//        cell.foodImage.image = ここにUIImageを代入する
//        cell.foodImage.image = UIImage
        
        cell.accessoryType = .disclosureIndicator
//        cell.foodImage.image = UIImage(named:dic["https://uds.gnst.jp/rest/img/f42gjg7p0000/t_01d4.jpg"] as! String)
        return cell
    }

  
//        ３.リストに表示する文字列を決定し、表示
    
 
    //セルをタップしたら発動。　　各種類の説明ページに飛ぶ。
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)行目がタップされました")
        //選択された行番号を保存
        let dic = shopList[indexPath.row] as!
        NSDictionary
        
        selectedSaveDate = dic["saveDate"] as! Date
        
        //セグエ(ページを紐付ける線)の名前を指定して、画面移動処理を発動
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    //セグエ(ページを紐付ける線)を使って、画面移動している時に発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //次の画面のインスタンス（オブジェクト）を取得。
        //as! DetailViewControllerが、ダウンキャスト変換している箇所。
        
        let dvc:MapViewController = segue.destination            //segue.destination 画面の到着地点。
            as! MapViewController
        //次の画面のプロパティ（メンバー変数）passedIndexに選択された行番号。移動するページに先にpassedIndexを飛ばす場所を要しする
//        dvc.NextSaveDate = selectedSaveDate                 //DetailViewControllerが持っているpassedIndexに飛ばす。
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    }

