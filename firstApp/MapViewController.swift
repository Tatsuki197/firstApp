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


