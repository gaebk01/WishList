//
//  WishList+CoreDataProperties.swift
//  WishList
//
//  Created by 김태균 on 2021/05/31.
//
//

import Foundation
import CoreData


extension WishList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishList> {
        return NSFetchRequest<WishList>(entityName: "WishList")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Int64
    @NSManaged public var img: Data?

}

extension WishList : Identifiable {

}
