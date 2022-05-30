//
//  coredatamanager.swift
//  Tic Tac Toe
//
//  Created by dhairya bhavsar on 2022-05-29.
//
import UIKit
import Foundation
import CoreData

class CoreDataHelper {
    static var instance : CoreDataHelper = CoreDataHelper()
    
    func dataCount() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                return arr.count
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return 0
    }
    
    func save(turn : String) {
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
        let managedContext =
        appDelegate.persistentContainer.viewContext
        
        let objEntityGame = NSEntityDescription.insertNewObject(forEntityName: "GameEntity", into: managedContext) as! GameEntity
        
        objEntityGame.turnstarts = turn
        objEntityGame.id = "MyGame"
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func addGame(move : MoveName, turn : String, start : String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! GameEntity
                    if obj.movesArray == nil {
                        var arrMoves : [String] = []
                        arrMoves.append(move.rawValue)
                        obj.movesArray = arrMoves as NSObject
                    } else {
                        var arrImg = obj.movesArray as! [String]
                        arrImg.append(move.rawValue)
                        obj.movesArray = arrImg as NSObject
                    }
                    obj.turnstarts = start
                    obj.turnEnds = turn
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func changeTurn(move : String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! GameEntity
                    obj.turnstarts = move
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func removeLastMove(turn : String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! GameEntity
                    if obj.movesArray != nil {
                        var arrImg = obj.movesArray as! [String]
                        arrImg.removeLast()
                        obj.movesArray = arrImg as NSObject
                    }
                    obj.turnstarts = turn
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func updateNought(count : Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! GameEntity
                    obj.scoreo = Double(count)
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func updateCross(count : Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! GameEntity
                    var arrMoves = obj.movesArray as! [String]
                    arrMoves.removeAll()
                    obj.scorex = Double(count)
                    obj.movesArray = arrMoves as NSObject
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getGameData() {
        appDelegate.arrGameData.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameEntity")
        
        do {
            appDelegate.arrGameData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func resetCoreData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    managedContext.delete(managedObject)
//                    let obj = managedObject as! GameEntity
//                    obj.movesArray = nil
//                    obj.scorex = 0.0
//                    obj.scoreo = 0.0
//                    obj.turnstarts = ""
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
