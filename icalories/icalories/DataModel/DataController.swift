//
//  DataController.swift
//  icalories
//
//  Created by Park Kangwook on 2022/05/16.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    ///NSPersistentContainer : Data를 영구적으로 관리하려는 목적인듯 (앱 꺼켰해도 내가 수정한 대로 유지)
    ///name은 우리가 다루는 Core Data 파일 이름 그대로 넣기
    let container = NSPersistentContainer(name: "FoodModel")
    
    ///그리고 여기도 이니셜라이저가 필요하다
    init() {
        ///우리 데이터를 container라고 했는데, 이니셜라이저에서 container에서 PersistentStores를 load하겠다! 그리고 여기 error와 desc(부연설명)이 필요하기에 이 항목들 매개변수!
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    ///가장 먼저 Save하는 함수를 적어줄 거다! Save를 못하면 CoreData를 사용하는 의미가 없기 때문
    ///context라는 전달인자가 필요하고, 이는 NSManageObjectContext 타입이다
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!!!")
        } catch {
            print("We could not save the data... sorry :(")
        }
    }
    
    ///항목 추가하는 Add 함수,   name, calories, context라는 전달인자 필요 & 각각의 타입 선언
    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
        ///Food : FoodModel의 Food라는 entities를 가리킴
        ///Food 틀을 따르는 이 context의 정보들을 food라는 상수에 담아서 선언하고 각각의 id, name, date, calories를 지칭해준다
        let food = Food(context: context)
        food.id = UUID()
        food.name = name
        food.date = Date()
        food.calories = calories
        ///위에서 썼던 save 함수 발동해서 저장해주기
        save(context: context)
    }
    
    ///항목 수정하는 Edit 함수     &    각각 필요한 매개변수들의 타입 지정
    func editFood(food: Food, name: String, calories: Double, context: NSManagedObjectContext) {
        food.name = name
        food.calories = calories
        food.date = Date()
        
        save(context: context)
    }
}
