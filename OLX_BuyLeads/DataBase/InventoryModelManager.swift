//
//  InventoryModelManager.swift
//  InventorySwift
//
//  Created by Vikram on 10/08/24.
//

import UIKit
import CoreData

class InventoryModelManager: NSObject {
    

    var makes = [Makes]()
    var models = [Models]()
    var variants = [Variants]()
    var stocks = [Ads]()

    
    var m_modelDic = [AnyHashable: Any]()
    var modelDic = [AnyHashable: Any]()

//    var managedObjectContext: NSManagedObjectContext!
//    private(set) var persistentStoreCoordinator: NSPersistentStoreCoordinator?
    
    
     let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }


// MARK: - Singleton
    static let sharedInstance: InventoryModelManager = {
        let instance = InventoryModelManager()
        return instance
    }()

//    override init() {
//        super.init()
//        if self != nil {
//            m_modelDic = [AnyHashable: Any]()
//            modelDic=m_modelDic
//        }
//    }
    
    func copy(withZone zone: NSZone) -> Any {
        
        return self
    }

    // MARK: - ManagedObjectContext
    
    func ManagedObjectContext() -> NSManagedObjectContext {
        return context
    }
//    
//    func currentContext() -> NSManagedObjectContext {
//         // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
////        let inventory = Inventory()
////        let context = inventory.persistentContainer.viewContext
//        
//         let context = CoreDataStack.shared.persistentContainer.viewContext
////        else {
////            fatalError("Failed to initialize NSManagedObjectContext")
////        }
//        return context
//    }

    
//    func saveContext() {
//            do {
//                try self.currentContext().save()
//            }  catch let error as NSError
//            {
//                NSLog("Unresolved error \(error), \(error.userInfo)")
//            }
//    }

     func saveContext() {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print("Failed to save context: \(error)")
                }
            }
        }
    
    func loadFromDB(){
    
        makes = self.loadEntityFromDB(entityName: "Makes") as! [Makes]
        models = self.loadEntityFromDB(entityName: "Models") as! [Models]
        variants = self.loadEntityFromDB(entityName: "Variants") as! [Variants]
        stocks = self.loadEntityFromDB(entityName: "Ads") as! [Ads]

    }
    
    func loadEntityFromDB(entityName: String) -> AnyObject {
        return loadEntity(fromDB: entityName, withPredicateFormat: nil)
    }
    
    func loadEntity(fromDB entityName: String, withPredicateFormat predicateFormat: NSPredicate?) -> AnyObject {
        var fetchResults: [Any]?
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        var entity: NSEntityDescription?
        entity = NSEntityDescription.entity(forEntityName: entityName, in:context)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.entity = entity
        
        if predicateFormat != nil {
            fetchRequest.predicate = predicateFormat
        }
        fetchResults = try! context.fetch(fetchRequest)
        if fetchResults == nil {
            print("Error fetching \(entityName)")
        }
        else {
            print("\(entityName) fetching succeeded")
        }
        return fetchResults as AnyObject
    }
    
    func clearEntity(entity: String) -> Bool{
    
        let fetchAllObjects = NSFetchRequest<NSFetchRequestResult>()
        fetchAllObjects.entity = NSEntityDescription.entity(forEntityName: entity, in: context)
        fetchAllObjects.includesPropertyValues = false  //only fetch the managedObjectID
        let allObjects: [NSManagedObject] = try! context.fetch(fetchAllObjects) as! [NSManagedObject]

        for  object: NSManagedObject in allObjects {
            context.delete(object)
        }
        let saveError: Error? = nil
        
        return saveError == nil
    }
    
    
    //MARK:-  Add/Remove Activity

    func addStocks(objects: Ads){
        stocks.append(objects)
    }
    func removeStocks(objects: Ads) {
        stocks.remove(at: stocks.firstIndex(of: objects)!)
    }

    
    func addMakes(objects: Makes){
        makes.append(objects)
    }
    func removeAAMakes(objects: Makes) {
        makes.remove(at: makes.firstIndex(of: objects)!)
    }

    func addModels(objects: Models){
        models.append(objects)
    }
    func removeAAModels(objects: Models) {
        models.remove(at: models.firstIndex(of: objects)!)
    }

    func addAAVariants(objects: Variants){
        variants.append(objects)
    }
    func removeAAVariants(objects: Variants) {
        variants.remove(at: variants.firstIndex(of: objects)!)
    }


    //MARK: - DB Unloading
//    func unload(){
//        managedObjectContext = nil
//    }
    
}


public class CoreDataStack {

    public static let shared = CoreDataStack()

    public let persistentContainer: NSPersistentContainer

    private init() {
        // Load the Core Data model from the framework's bundle
        let bundle = Bundle(for: CoreDataStack.self)
        guard let modelURL = bundle.url(forResource: "InventorySwiftModel", withExtension: "momd") else {
            fatalError("Failed to locate Core Data model.")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load Core Data model.")
        }

        persistentContainer = NSPersistentContainer(name: "InventorySwiftModel", managedObjectModel: model)
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
    }

    public var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//public class CoreDataStack {
//    public static let shared = CoreDataStack()
//
//    public let persistentContainer: NSPersistentContainer
//
//    private init() {
//        let modelURL = Bundle(for: CoreDataStack.self).url(forResource: "InventorySwiftModel", withExtension: "momd")!
//        let model = NSManagedObjectModel(contentsOf: modelURL)
//        persistentContainer = NSPersistentContainer(name: "InventorySwiftModel", managedObjectModel: model!)
//        persistentContainer.loadPersistentStores { (description, error) in
//            if let error = error {
//                fatalError("Failed to load Core Data stack: \(error)")
//            }
//        }
//    }
//
//    public var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//}


//class CoreDataStack {
//    public static let shared = CoreDataStack()
//
//    public let persistentContainer: NSPersistentContainer
//
//    
//    private init() {
//        persistentContainer = NSPersistentContainer(name: "InventorySwiftModel")
//        persistentContainer.loadPersistentStores { (description, error) in
//            if let error = error {
//                fatalError("Failed to load Core Data stack: \(error)")
//            }
//        }
//    }
//
//    public var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//}
