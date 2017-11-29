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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(selectedSaveDate)
        read()
    }

    //すでに存在するデータの読み込み処理  データ上書き保存をする。
    func read(){
        
        //    一旦からにする（初期化）
        contentTitle = []
        //AppDelegateを使う用意しておく
        let appDalegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
//        //エンティティをそうさするためのオブジェクトを作成
//        let viewContext = appDalegate.persistentContainer.viewContext
//
//        //どのエンティティからデータを取得してくるか設定（ToDoエンティティ）
//        let query:NSFetchRequest<ToDo> = ToDo.fetchRequest()
        //絞り込み検索(ここ追加！！！！！！！！！)-------------------------------------------------------------------------------------------------
        //絞り込みの条件　saveDate = %@ のsaveDateはattribute名
        let saveDatePredicate = NSPredicate(format: "saveDate = %@", selectedSaveDate as CVarArg)
//        query.predicate = saveDatePredicate
        
        
//        //-----------------------------------------------------------------------------------------------------------------
//        
//        do{
//            
////        データ一括取得
////            let fechResults = try viewContext.fetch(query) as! NSDictionary
//            
//            //きちんと保存できてるか、1行ずつ表示（デバックエリア）
//            for result: AnyObject in fechResults {
//                let title :String? = result.value(forKey:"title") as? String
//                let saveDate :Date? = result.value(forKey:"saveDate") as? Date
//                
//                print("絞り込んだ結果")
//                print("title:\(title!) saveDate:\(saveDate!)")
//                todoText.text = title
//                
//                var dic = ["title":title,"saveDate":saveDate] as [String : Any]
//                
//                
//                contentTitle.append(dic as NSDictionary)
//                
//                
//            }
//            
//            
//        }catch{
//            
//        }
//        
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
