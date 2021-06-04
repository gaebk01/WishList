//
//  CoreDataHelper.swift
//  WishList
//
//  Created by 김태균 on 2021/06/01.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler: NSObject {
    static let shared = CoreDataHandler()
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(name: String, price: Int64, img: Data) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription .entity(forEntityName: "WishList", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(name, forKey: "name")
        manageObject.setValue(price, forKey: "price")
        manageObject.setValue(img, forKey: "img")
        
        do {
            try context.save()
             return true
        } catch {
            return false
        }
    }
    
    class func fetchObject() -> [WishList]? {
        let context = getContext()
        var wishes:[WishList]? = nil
        do {
            wishes = try context.fetch(WishList.fetchRequest())
            return wishes
        } catch {
            return wishes
        }
    }
    
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: WishList.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
}

