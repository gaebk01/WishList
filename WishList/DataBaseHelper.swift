//
//  DataBaseHelper.swift
//  WishList
//
//  Created by 김태균 on 2021/05/30.
//
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
//    
//    
//    class func saveObject(name: String, price: Int64, img: Data) -> Bool {
//        let context = getContext()
//        let entity = NSEntityDescription .entity(forEntityName: "WishList", in: context)
//        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
//        
//        manageObject.setValue(name, forKey: "name")
//        manageObject.setValue(price, forKey: "price")
//        manageObject.setValue(img, forKey: "img")
//        
//        do {
//            try context.save()
//             return true
//        } catch {
//            return false
//        }
//    }
//    
//    class func fetchObject() -> [WishList]? {
//        let context = getContext()
//        var wishes:[WishList]? = nil
//        do {
//            wishes = try context.fetch(WishList.fetchRequest())
//            return wishes
//        } catch {
//            return wishes
//        }
//    }
//    
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

// https://www.youtube.com/watch?v=3b8P44XdwkQ

class DataBaseHelper {
    static let shareInstance = DataBaseHelper()
    
    var models = [WishList]() 
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllList() {
        do {
            models = try context.fetch(WishList.fetchRequest())
        } catch {
            
        }
    }
    
    func createItem(name: String, price: Int64, img: Data) {
        let newItem = WishList(context: context)
        newItem.img = img
        newItem.name = name
        newItem.price = price
        
        do {
            try context.save()
            print("DEBUG: \(newItem.index(ofAccessibilityElement: 1))")
        } catch {
            
        }
    }
    
    func deleteItem(item: WishList) {
        context.delete(item)
        
        do {
            try context.save()
            getAllList()
            print("DEBUG: DELETE ITEM")
        } catch {
            print("DEBUG: FAILED DELETE ITEM")
        }
    }

    func updateItem(item: WishList, newName: String, newImage: Data, newPrice: Int64){
        item.name = newName
        item.img = newImage
        item.price = newPrice
        
        do {
            try context.save()
            getAllList()
        } catch {
            
        }
    }
}

// https://www.youtube.com/watch?v=rjHBINtpKA8
