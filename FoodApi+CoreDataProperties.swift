//
//  FoodApi+CoreDataProperties.swift
//  firstApp
//
//  Created by Tatsuki Nakatsuka on 2017/11/24.
//  Copyright © 2017年 Tatsuki Nakatsuka. All rights reserved.
//
//

import Foundation
import CoreData


extension FoodApi {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodApi> {
        return NSFetchRequest<FoodApi>(entityName: "FoodApi")
    }

    public var saveData: NSDate?
    public var title: String?

}
