//
//  InventorySaveDataIntoDB.swift
//  InventorySwift
//
//  Created by Vikram on 10/08/24.
//

import UIKit
import CoreData

class InventorySaveDataIntoDB: NSObject {

    var background = false;
    
//    static var backgroundContext: NSManagedObjectContext = {
//        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//        context.persistentStoreCoordinator = CoreDataStack.shared.persistentContainer
//        context.undoManager = nil
//        return context
//    }()

    static let sharedInstance: InventorySaveDataIntoDB = {
        let instance = InventorySaveDataIntoDB()
        return instance
    }()
    func saveleadsandsubleadsIntoDB(response: Any) {
        
        guard let responseDic = response as? [String: Any] else { return }
        guard let statesArray = responseDic["buyleadstatus"]! as? [[String: Any]] else { return }
        let context = CoreDataStack.shared.persistentContainer.viewContext
        for (index, stateDict) in statesArray.enumerated() {
            let statuses = NSEntityDescription.insertNewObject(forEntityName: "LeadStatus", into: InventoryModelManager.sharedInstance.context) as! LeadStatus
            statuses.name = stateDict["name"] as? String
            for sublead in stateDict["substatus"] as! NSArray{
                let SubLeads = NSEntityDescription.insertNewObject(forEntityName: "SubLeads", into: InventoryModelManager.sharedInstance.context) as! SubLeads
                let sublead = sublead as! [String:Any]
                SubLeads.name = sublead["name"] as! String
                statuses.addToSubleads(SubLeads)
            }
        }
        do {
            try context.save()
            print("status and substatus saved successfully to Core Data.")
            
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    
        func saveStockTitles(_ response: Any?) {
            guard let makesArray = response as? [[String: Any]] else { return }
            let context = CoreDataStack.shared.persistentContainer.viewContext
            let backgroundContext2 = InventoryModelManager.sharedInstance.ManagedObjectContext()
            backgroundContext2.performAndWait {
                for makeDict in makesArray {
                    let stocks = NSEntityDescription.insertNewObject(forEntityName: "Ads", into: InventoryModelManager.sharedInstance.context) as! Ads
                    stocks.name = makeDict["title"] as? String
                    stocks.adId = makeDict["adId"] as? String
                    InventoryAPIManager.sharedInstance.addStocks(ads: stocks)
                }
            }
                try? backgroundContext2.save()
                do {
                    try context.save()
                } catch {
                    print("Failed to save: \(error)")
                }
    
        }
    
  
    func saveStatesandcitiesIntoDB(response: Any) {
        
        guard let responseDic = response as? [String: Any] else { return }
        guard let statesArray = responseDic["data"]! as? [[String: Any]] else { return }
        let context = CoreDataStack.shared.persistentContainer.viewContext
        for (index, stateDict) in statesArray.enumerated() {
            let states = NSEntityDescription.insertNewObject(forEntityName: "States", into: InventoryModelManager.sharedInstance.context) as! States
            states.name = stateDict["state"] as? String
            for city in stateDict["cities"] as! NSArray{
                let cities = NSEntityDescription.insertNewObject(forEntityName: "Cities", into: InventoryModelManager.sharedInstance.context) as! Cities
                let city = city as! String
                cities.name = city
                states.addToCities(cities)
            }
        }
        do {
            try context.save()
            print("states and cities saved successfully to Core Data.")
            
        } catch {
            print("Failed to save: \(error)")
        }
    }
    // MARK: - SaveMakesModelsAndVariants
    func saveMakesModelsAndVariantsIntoDB(response: Any) {
        guard let responseDic = response as? [String: Any] else { return }
     //   InventoryUserDefaults.sharedInstance.saveInitialYear(year: "\(responseDic["initial_year"] ?? "")")
//        saveMakesIntoDB(responseDic["makes"])
//        saveModelsIntoDB(responseDic["models"])
//        saveVariantsIntoDB(responseDic["variants"])
        self.saveCarDataToCoreData(from: responseDic["models"]!, context: InventoryModelManager.sharedInstance.context)
    }
    func saveCarDataToCoreData(from response: Any, context: NSManagedObjectContext) {
        
        guard let modelsArray = response as? [[String: Any]] else { return }
        let context = CoreDataStack.shared.persistentContainer.viewContext
        for (index, modelDict) in modelsArray.enumerated() {
            let make = NSEntityDescription.insertNewObject(forEntityName: "Makes", into: InventoryModelManager.sharedInstance.context) as! Makes
            make.name = modelDict["make"] as? String
            for modelData in modelDict["models"] as! NSArray{
                let model = NSEntityDescription.insertNewObject(forEntityName: "Models", into: InventoryModelManager.sharedInstance.context) as! Models
                print(modelData)
                let modeldic = modelData as! [String: Any]
                model.name = (modeldic["model"] as! String)
                make.addToModels(model)
                for variantName in modeldic["variants"]  as! NSArray{
                    let variant = NSEntityDescription.insertNewObject(forEntityName: "Variants", into: InventoryModelManager.sharedInstance.context) as! Variants
                    variant.name = (variantName as! String)
                    model.addToVarients(variant)
                }
            }
        }
        do {
            try context.save()
            print("makes, models and varients saved successfully to Core Data.")
            
        } catch {
            print("Failed to save: \(error)")
        }
    }
//    func saveMakesIntoDB(_ response: Any?) {
//        guard let makesArray = response as? [[String: Any]] else { return }
//        let context = CoreDataStack.shared.persistentContainer.viewContext
//        let backgroundContext2 = InventoryModelManager.sharedInstance.ManagedObjectContext()
//        backgroundContext2.performAndWait {
//            for makeDict in makesArray {
//                let makes = NSEntityDescription.insertNewObject(forEntityName: "Makes", into: InventoryModelManager.sharedInstance.context) as! Makes
//                makes.name = makeDict["name"] as? String
//                makes.pop = makeDict["pop"] as? String
//                makes.gf = makeDict["gf"] as? String
//                makes.newmake = makeDict["new"] as? String
//                if let makeId = makeDict["make_id"] as? Int {
//                    makes.makeId = (makeId) as NSNumber
//                }
//                InventoryAPIManager.sharedInstance.addMakes(makes: makes)
//            }
//        }
//            try? backgroundContext2.save()
//            do {
//                try context.save()
//            } catch {
//                print("Failed to save: \(error)")
//            }
//
//    }
//
//    func saveModelsIntoDB(_ response: Any?) {
//        guard let modelsArray = response as? [[String: Any]] else { return }
//        let context = CoreDataStack.shared.persistentContainer.viewContext
//        let backgroundContext2 = InventoryModelManager.sharedInstance.ManagedObjectContext()
//        backgroundContext2.performAndWait {
//            for (index, modelDict) in modelsArray.enumerated() {
//                print("Name index \(index)")
//                let models = NSEntityDescription.insertNewObject(forEntityName: "Models", into: InventoryModelManager.sharedInstance.context) as! Models
//                if let makeId = modelDict["make_id"] as? Int {
//                    models.makeId = (makeId) as NSNumber // NSNumber(value: makeId)
//                }
//                if let modelId = modelDict["model_id"] as? Int {
//                    models.modelId = (modelId) as NSNumber //NSNumber(value: modelId)
//                }
//                models.name = modelDict["name"] as? String ?? ""
//                models.gf = modelDict["gf"] as? String
//                models.newmodel = modelDict["new"] as? String
//                
//                InventoryAPIManager.sharedInstance.addModels(models: models)
//            }
//        }
//            try? backgroundContext2.save()
//            do {
//                try context.save()
//            } catch {
//                print("Failed to save: \(error)")
//            }
//    }
//
//    func saveVariantsIntoDB(_ response: Any?) {
//        guard let variantsArray = response as? [[String: Any]] else { return }
//        let context = CoreDataStack.shared.persistentContainer.viewContext
//        let backgroundContext2 = InventoryModelManager.sharedInstance.ManagedObjectContext()
//        backgroundContext2.performAndWait {
//            for variantDict in variantsArray {
//                let variants = NSEntityDescription.insertNewObject(forEntityName: "Variants", into: InventoryModelManager.sharedInstance.context) as! Variants
//                if let makeId = variantDict["make_id"] as? Int {
//                    variants.makeId = NSNumber(value: makeId)
//                }
//                if let modelId = variantDict["model_id"] as? Int {
//                    variants.modelId = NSNumber(value: modelId)
//                }
//                variants.gf = variantDict["gf"] as? String
//                if let variantId = variantDict["variant_id"] as? Int {
//                    variants.variantId = NSNumber(value: variantId)
//                }
//                variants.newvariant = variantDict["new"] as? String
//                variants.name = variantDict["name"] as? String ?? ""
//                if let startYear = variantDict["sy"] as? Int {
//                    variants.startyear = NSNumber(value: startYear)
//                }
//                if let endYear = variantDict["ey"] as? Int {
//                    variants.endyear = NSNumber(value: endYear)
//                }
//                variants.fuel = variantDict["f"] as? String ?? ""
//                variants.powerSt = variantDict["pw_st"] as? String
//                
//                InventoryAPIManager.sharedInstance.addVariants(variants: variants)
//            }
//        }
//            try? backgroundContext2.save()
//            do {
//                try context.save()
//            } catch {
//                print("Failed to save: \(error)")
//            }
//    }

}
