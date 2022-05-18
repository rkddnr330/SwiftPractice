//
//  CoreDataManager.swift
//  BudgetApp
//
//  Created by Park Kangwook on 2022/05/17.
//

import Foundation
import CoreData

///이 클래스의 목적 : Core Data의 Stack을 이니셜라이즈하기 위해
class CoreDataManager {
    let persistentStoreContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    ///private : 다른 사람이 함부로 못하게끔? 의 의미 ?
    private init() {
        persistentStoreContainer = NSPersistentContainer(name: "BudgetAppModel") //Data Model 파일 이름
        persistentStoreContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
}
