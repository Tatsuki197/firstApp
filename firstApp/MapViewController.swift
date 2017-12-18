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

class MapViewController: UIViewController,CLLocationManagerDelegate{

    @IBOutlet weak var shopMap: MKMapView!
        //位置情報
    var locationManager: CLLocationManager! //---------------

    var selectedSaveDate:Date = Date()
    var contentTitle:[NSDictionary] = []
    var passedIndex = -1


    @IBOutlet weak var omiseName: UILabel!
    
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
////位置情報
//        setupLocationManager()
        //CLLocationManagerをインスタンス化
        locationManager = CLLocationManager()
        
        
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        locationManager.requestWhenInUseAuthorization()
       
      
        
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
        let span = MKCoordinateSpanMake(0.01, 0.01)
        //範囲オブジェクト
        let region = MKCoordinateRegionMake(coodinate, span)
        
        
        shopMap.setRegion(region, animated: true)
        //ピンを生成
        let myPin:MKPointAnnotation = MKPointAnnotation()
        myPin.coordinate = coodinate
        myPin.title = passedIndex as? String
        
        //3.タイトル、サブタイトルを設定（タップしたときに吹き出し情報）
//        myPin.title = "アヤラショッピングモール"
        myPin.subtitle = passedIndex as? String
        
        shopMap.addAnnotation(myPin)
        
        setupLocationManager()
        locationManager.delegate = self
        
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestWhenInUseAuthorization()
        
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
            
        }
    
    
    // 位置情報取得に失敗した時に呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager!,didFailWithError error: NSError!){
        print("error")
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
    

}//class閉じ




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


