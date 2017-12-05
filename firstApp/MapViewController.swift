//
//  MapViewController.swift
//  firstAppTests
//
//  Created by Tatsuki Nakatsuka on 2017/11/19.
//  Copyright © 2017年 Tatsuki Nakatsuka. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var shopMap: MKMapView!
    
    var selectedSaveDate:Date = Date()
    var contentTitle:[NSDictionary] = []
    var passedIndex = -1
    
    @IBOutlet weak var omiseName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
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
        

        
      
//        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
//        let filepath = Bundle.main.path(forResource: "shopList", ofType:"plist")
//        //ファイルの内容を読み込んでディクショナリー型に格納
//        let dic = NSDictionary(contentsOfFile: filepath!)
//
//        //今画面に表示したいデータの取得   NSDictionary(ネクストステップ)
//        let detailInfo = dic![getAreaName] as! NSDictionary
//
////        print(detailInfo["description"] as! String)
////        print(detailInfo["image_url"] as! String)
//        print(detailInfo["latitude"] as! String)
//        print(detailInfo["longitude"] as! String)
//
//        //タイトル
        //        seaTitle.text = getAreaName
        
//        //タイトルを、ナビゲーションの真ん中に表示。
//        navigationItem.title = getAreaName
        //これでも良い！　　self=このクラスの名前を提示する。

        
        
//        タイトルダメパターン
//                navigationController?.taitle = getAreaName
        
//        //説明を表示
//        textDesc.text = detailInfo["shopName"] as! String

//        //画像
//        foodImage.image = UIImage(named:detailInfo["image"] as! String)
//
        //地図
//        let latitude = detailInfo["latitude"] as! String
//        let longitude = detailInfo["longitude"] as! String
        //座標オブジェクト
//        //型変換　String型ー＞Double型
//        let coodinate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
//
//        //拡縮率
//        let span = MKCoordinateSpanMake(0.01, 0.01)
//        //範囲オブジェクト
//        let region = MKCoordinateRegionMake(coodinate, span)
//
//
//        //地図にセット
//        shopMap.setRegion(region, animated: true)
//        //ピンを生成
//        let myPin:MKPointAnnotation = MKPointAnnotation()
//        myPin.coordinate = coodinate
//        myPin.title = getAreaName
//
//        shopMap.addAnnotation(myPin)

        
    }
    
   
    
    
 
    @IBAction func returnApiView(_ sender: UIButton) {
        //画面移動(戻る)
        let count = (self.navigationController?.viewControllers.count)! - 2
        _ = self.navigationController?.viewControllers[count]
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


