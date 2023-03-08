//
//  Monster+CoreDataProperties.swift
//  TestCoreData
//
//  Created by haruto.makino on 2023/03/08.
//
//

import Foundation
import CoreData


extension Monster {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Monster> {
        return NSFetchRequest<Monster>(entityName: "Monster")
    }

    @NSManaged public var monsterName: String?

}

extension Monster : Identifiable {

}
