//
//  Entity+CoreDataProperties.swift
//  firstApp
//
//  Created by Tatsuki Nakatsuka on 2017/11/23.
//  Copyright © 2017年 Tatsuki Nakatsuka. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }


}
