//
//  AppDelegate.swift
//  Reciplease
//
//  Created by Angelique Babin on 09/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack(modelName: "Reciplease")
    
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let detailRecipeViewController = DetailRecipeViewController()
//        detailRecipeViewController.coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
//        let favoritesRecipesViewController = FavoritesRecipesViewController()
//        favoritesRecipesViewController.coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
//        return true
//    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication,
//                     configurationForConnecting connectingSceneSession: UISceneSession,
//                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }

//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//    }

    // MARK: - Core Data stack

//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Reciplease")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
//    static var persistentContainer: NSPersistentContainer {
//        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
//    }
    
//    static var viewContext: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }

    // MARK: - Core Data Saving support

//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
}
