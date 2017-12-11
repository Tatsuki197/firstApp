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

var shopList:[Any] = []


class ApiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
//プロトコル追加
    
    
    //表示したいデータ（配列）
    
    var selectedSaveDate = Date()
    
    var selectedSegmentIndex = -1

    
    

    @IBOutlet weak var apiTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        conectApi()
    
        print("えらばれたrange:\(selectedSegmentIndex)")

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
        
        //渋谷
//        let keido = "139.701561"
//        let ido = "35.658243"
        // TODO: API接続先　日本語を変換する処理が必要ーーーーーーーーーーーーーーーーーーーーーーー
        let urlStr = "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=d8bb513cb61392fcca6395309303369b&format=json&latitude=35.776006&longitude=139.695395&range=\(selectedSegmentIndex)&hit_per_page=20&freeword=%E3%83%AF%E3%83%8B%E6%96%99%E7%90%86"
        let url = URL(string: urlStr)
        print(url)
        print(selectedSegmentIndex)

//        let urlStr = "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=d8bb513cb61392fcca6395309303369b&format=json&latitude=35.658243&longitude=139.701561&range=\(selectedSegmentIndex)&hit_per_page=10&freeword=%E3%83%AF%E3%83%8B%E6%96%99%E7%90%86"
//

        
        if url != nil {
            let req = NSMutableURLRequest(url: url!)
            req.httpMethod = "GET"
//             req.httpBody = "userId=\(self.userId)&code=\(self.code)".data(using: String.Encoding.utf8)
//            print(req)
            //TODO:taskに何も入ってないので終了するーーーーーーーーーーーーーーーーーーーーーーー
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
//                print(resp!.url!)
//                print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as Any)

                
                // 受け取ったdataをJSONパース、エラーならcatchへジャンプ
                    do {
                    // dataをJSONパースし、変数"getJson"に格納
                    getJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                   
                    

                        

                    
//                    print (jsonIp)
                    print (jsonRest)
                        
            //shopListデータを入手できなかった時にアラートを出して、もう一度選択してもらう。
                        let alert = UIAlertController(title: "選ばれたお店が近くにありません", message:"もう一度選び直す。", preferredStyle: .alert)
                        
                        shopList = jsonRest
                        if shopList.count == 0 {
                            alert.addAction(UIAlertAction(title: "もう一度選ぶ", style: .default, handler: {action in self.navigationController?.popToRootViewController(animated: true)}))
                            self.present(alert, animated: false, completion: {() -> Void in print("アラート表示されました")})

                        }else{
                            
                            jsonIp = (getJson["total_hit_count"] as? String)!
                            jsonRest = (getJson["rest"] as? Array)!
                            
                        }
                  
                        
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
                var retValue = 20

        print(shopList)
        //エラーがなかなか消えない時はcommand+shift+kで一旦エラーを削除r
        
        print("お店数\(shopList.count)")
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
                cell.shopName.text = dic["name"] as? String
                cell.sentence.text = dic["holiday"] as? String
                cell.shopUrl.text = dic["url"] as? String
                    print(dic)
//        let url = URL(string: shopList[indexPath.row]["image"] as! String);
        
        
        let shopurl = dic["image_url"] as! NSDictionary
            print(shopurl["shop_image1"])
        
            var shopdata = shopurl["shop_image1"]!
                print(String(describing: type(of: shopdata)))
        

        
        if String(describing: type(of: shopdata)) == "__NSCFString" {
            
            var err: NSError?;
            
            var url = NSURL(string: String(describing: shopdata))
            let shopdatadata :Data = (try! Data(contentsOf: url as! URL,options: NSData.ReadingOptions.mappedIfSafe));
            let foodImage = UIImage(data:shopdatadata);
                cell.foodImage.image = foodImage
        }else{
                cell.foodImage.image = UIImage(named:"noimage.png")
            
        }
  
        cell.accessoryType = .disclosureIndicator

        return cell

    }
//        ３.リストに表示する文字列を決定し、表示
    
    //セルがタップされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //タップされた行のエリア名を保存
        selectedIndex = indexPath.row
            //選択された行番号を保存
            let dic = shopList[indexPath.row] as! NSDictionary
                //セグエのidentifier（識別子）を指定して、画面移動
                self.performSegue(withIdentifier: "showMap", sender: nil)
        
        
    }

    //セグエを使って画面移動する時発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面のインスタンスを取得
        let dvc = segue.destination as! MapViewController
        //
        //次の画面のプロパティにタップされた行のエリア名を渡す
        dvc.passedIndex = selectedIndex
        
        
    }
    
    
    //    移動した画面から戻って来たとき発動する
    
    @IBAction func returnView(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
        
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
