//
//  MapViewController.swift
//  firstAppTests
//
//  Created by Tatsuki Nakatsuka on 2017/11/19.
//  Copyright © 2017年 Tatsuki Nakatsuka. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var shopMap: MKMapView!
    var locationManager: CLLocationManager! //---------------
    var selectedSaveDate:Date = Date()
    var contentTitle:[NSDictionary] = []
    var passedIndex = -1
    
    @IBOutlet weak var omiseName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager() // インスタンスの生成-----------------
        locationManager.delegate = self as! CLLocationManagerDelegate // CLLocationManagerDelegateプロトコルを実装するクラスを指定する------------------
        
        let dic = shopList[passedIndex] as!NSDictionary
        
        omiseName.text = dic["name"] as? String
        print(dic["latitude"] as! String)
        print(dic["longitude"] as! String)
        
        print(dic)
        //地図
        let latitude = dic["latitude"] as! String
        let longitude = dic["longitude"] as! String
        
        //型変換　String型ー＞Double型
        let coodinate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
        //拡縮率
        let span = MKCoordinateSpanMake(0.05, 0.05)
        //範囲オブジェクト
        let region = MKCoordinateRegionMake(coodinate, span)
        
        
        shopMap.setRegion(region, animated: true)
        //ピンを生成
        let myPin:MKPointAnnotation = MKPointAnnotation()
        myPin.coordinate = coodinate
        myPin.title = passedIndex as? String
        
        shopMap.addAnnotation(myPin)

        
    }
    
   
    extension ViewController: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                print("ユーザーはこのアプリケーションに関してまだ選択を行っていません")
                // 許可を求めるコードを記述する（後述）
                break
            case .denied:
                print("ローケーションサービスの設定が「無効」になっています (ユーザーによって、明示的に拒否されています）")
                // 「設定 > プライバシー > 位置情報サービス で、位置情報サービスの利用を許可して下さい」を表示する
                break
            case .restricted:
                print("このアプリケーションは位置情報サービスを使用できません(ユーザによって拒否されたわけではありません)")
                // 「このアプリは、位置情報を取得できないために、正常に動作できません」を表示する
                break
            case .authorizedAlways:
                print("常時、位置情報の取得が許可されています。")
                // 位置情報取得の開始処理
                break
            case .authorizedWhenInUse:
                print("起動時のみ、位置情報の取得が許可されています。")
                // 位置情報取得の開始処理
                break
            }
        }
    }
    
    @IBAction func shareSns(_ sender: UIBarButtonItem) {
        let dic = shopList[passedIndex] as!NSDictionary
//        シェア用の画面（インスタンス）作成
        
         let url = dic["url"]
//        イニシャライザ（初期化）を同時に行う宣言　　UIActivityViewController＝送り先を選べるfecebok.line
        let controller = UIActivityViewController(activityItems:[url],applicationActivities: nil)
        print(dic["url"])
       
        //シェア用画面を表示
        present(controller, animated: true, completion: nil)
    }


    @IBAction func returnApiView(_ sender: UIButton) {
       
        var viewControllers = navigationController?.viewControllers
        viewControllers?.removeLast(1) // views to pop
        navigationController?.setViewControllers(viewControllers!, animated: true)

    }
    
    

}



//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


