//
//  CoreDataManager.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 18/11/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAddresses() -> [AddressModel] {
        let request: NSFetchRequest<AddressModel> = AddressModel.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch addresses: \(error)")
            return []
        }
    }
    func addAddress(alamat: String, kabupaten: String, profinsi: String, kodePos: String) -> CoreDataResult {
        let newAddress = AddressModel(context: context)
        newAddress.alamat = alamat
        newAddress.kabupaten = kabupaten
        newAddress.profinsi = profinsi
        newAddress.kodePos = kodePos
        
        do {
            try context.save()
            return .added
        } catch {
            print("Failed to save address: \(error)")
            return .failed
        }
    }
    
    func deleteAddress(address: AddressModel) -> CoreDataResult {
        context.delete(address)
        do {
            try context.save()
            return .deleted
        } catch {
            print("Failed to delete address: \(error)")
            return .failed
        }
    }
    
    func updateAddress(address: AddressModel, newAlamat: String, newKabupaten: String, newProfinsi: String, newKodePos: String) -> CoreDataResult {
        address.alamat = newAlamat
        address.kabupaten = newKabupaten
        address.profinsi = newProfinsi
        address.kodePos = newKodePos
        
        do {
            try context.save()
            return .updated
        } catch {
            print("Failed to update address: \(error)")
            return .failed
        }
    }
}

enum CoreDataResult {
    case added, failed, deleted, updated
}
