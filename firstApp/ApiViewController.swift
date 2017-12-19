//
//  ApiViewController.swift
//  firstApp
//
//  Created by Tatsuki Nakatsuka on 2017/11/19.
//  Copyright © 2017年 Tatsuki Nakatsuka. All rights reserved.
//

import UIKit
import CoreData
import Photos
import CoreLocation

var shopList:[Any] = []


class ApiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate{

    
//プロトコル追加
    
    

    
    var selectedSaveDate = Date()
        //表示したいデータ（配列）
    var selectedSegmentIndex = -1
    
    //foodリスト例（焼き鳥。。。）取得
    var foodTitle = ""

     //現在地の経度と緯度を取得するために生成
    var locationManager: CLLocationManager!

    //経度緯度の設定
    var latitude:Double = 0
    var longitude:Double = 0
    
//ロード待ち時間くるくる表示
        var ActivityIndicator: UIActivityIndicatorView!


    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var apiTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
        // ActivityIndicatorを作成＆中央に配置ーーーーーーーーーーーーーーーーーーーーーーー
        ActivityIndicator = UIActivityIndicatorView()
        ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        ActivityIndicator.center = self.view.center
        
        // クルクルをストップした時に非表示する
        ActivityIndicator.hidesWhenStopped = true
        
        // 色を設定
        ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        //Viewに追加
        self.view.addSubview(ActivityIndicator)
        
    
        print("えらばれたrange:\(selectedSegmentIndex)")

        
        ////位置情報
        //        setupLocationManager()
        //CLLocationManagerをインスタンス化
        locationManager = CLLocationManager()
        
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        locationManager.requestWhenInUseAuthorization()
        
        //5.tableViewにCellオブジェクトを追加してindentifierに「Cell」という名前をつける

        locationManager.delegate = self

        
        
        
       
        
        //
//        let latitude = "139.701561"
//        let longitude = "35.658243"
//        print(latitude)
//        print(longitude)
//        conectApi()
        
        

    }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch (status) {
        case .authorizedAlways:
            setupLocationManager()
            break
        case .authorizedWhenInUse:
            setupLocationManager()
            break
        case .notDetermined:
            break
        case .restricted:
            break
        case .denied:
            break
        }
    }
  

    
    
    func setupLocationManager() {
       
        guard let locationManager = locationManager else { return }
        
        let status = CLLocationManager.authorizationStatus()
        
        //authorizedWhenInUse=使用中の時だけ、位置情報を取得。
        if status == .authorizedWhenInUse {
            locationManager.distanceFilter = 300
            
            locationManager.distanceFilter = 500
            
            locationManager.distanceFilter = 1000
            
            locationManager.startUpdatingLocation()
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        print("latitude: \(latitude!)\nlongitude: \(longitude!)")
        //メンバー変数に変える
        self.latitude = (location?.coordinate.latitude)!
        self.longitude = (location?.coordinate.longitude)!
//
//        //Apiから位置情報取得。
        conectApi()
    }
    
    
    // 位置情報取得に失敗した時に呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager!,didFailWithError error: NSError!){
        print("error")
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
        //志村坂上139.695395　　35.776006
        
        
        
//        if let location = self.locationManager.location {//--------------
////
//        let longitude = "139.701561"
//        let latitude = "35.658243"
//        print(latitude)

//        }
        // TODO: API接続先　日本語を変換する処理が必要ーーーーーーーーーーーーーーーーーーーーーーー
        let urlStr = "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=d8bb513cb61392fcca6395309303369b&format=json&latitude=35.658243&longitude=139.701561&range=\(selectedSegmentIndex)&hit_per_page=20&freeword=\(foodTitle)"
    print(latitude)
    print(longitude)
       
//        "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=d8bb513cb61392fcca6395309303369b&format=json&latitude=\(latitude)&longitude=\(longitude)&range=\(selectedSegmentIndex)&hit_per_page=20&freeword=\(foodTitle)"

        let encodedURL = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        guard let url = NSURL(string: encodedURL!) else {
            print("無効なURL")
            return
        }
        
        print(url)


        
        if url != nil {
            let req = NSMutableURLRequest(url: url as URL)
            req.httpMethod = "GET"

            //TODO:taskに何も入ってないので終了するーーーーーーーーーーーーーーーーーーーーーーー
                let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { (data, resp, err) in
//                print(resp!.url!)
//                print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as Any)

                   
                // 受け取ったdataをJSONパース、エラーならcatchへジャンプ
                    do {
        
                    // dataをJSONパースし、変数"getJson"に格納
                    getJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary

                        if getJson["error"] == nil{
                            
                            //お店情報の振り分け
                            jsonIp = (getJson["total_hit_count"] as? String)!
                            jsonRest = (getJson["rest"] as? Array)!
                            //お店の数
                            shopList = jsonRest
                          
                        }
                        
                        self.activityIndicator.stopAnimating()
                        
                        if shopList.count == 0 {
                            let alert = UIAlertController(title: "Oh my gosh.お店がない😭", message:"逆にもう一度選べるチャンス到来!!", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "もう一度選Food!🍽", style: .default, handler: {action in self.navigationController?.popToRootViewController(animated: true)}))
                            self.present(alert, animated: false, completion: {() -> Void in print("アラート表示されました")})
                        }

                        
                    print (jsonIp)
                    print (jsonRest)
                        
         
                        
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
//            cell.textLabel!.text = "\(shopList[indexPath.row])"
            cell.textLabel?.textColor = UIColor.brown
            let dic = shopList[indexPath.row] as!NSDictionary
                cell.shopName.text = dic["name"] as? String
        //sentenceだが、休日を表示させる！
                cell.sentence.text = dic["holiday"] as? String
        //shopUrlだが、予算をひょうじさせる！
                cell.shopUrl.text = dic["budget"] as? String
//                  cell.webReserve.text = dic["reservation"] as? String
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
    override func viewDidDisappear(_ animated: Bool) {
        shopList = []
        self.apiTable.reloadData()
    }
//    override func viewDidDisappear(:_Bool) {
//        super.viewDidDisappear(true)
//
//        shopList.reloadData()
//        print()
//    }
    
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
