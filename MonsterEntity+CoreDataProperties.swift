//
//  MonsterEntity+CoreDataProperties.swift
//  TestCoreData
//
//  Created by haruto.makino on 2023/03/08.
//
//

import Foundation
import CoreData


extension MonsterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MonsterEntity> {
        return NSFetchRequest<MonsterEntity>(entityName: "MonsterEntity")
    }

    @NSManaged public var monsterName: String?

}

extension MonsterEntity : Identifiable {

}
