//
//  AddBudgetViewModel.swift
//  BudgetApp
//
//  Created by Park Kangwook on 2022/05/18.
//

import Foundation
import CoreData

class AddBudgetViewModel: ObservableObject {
    ///1. NSManagedObjectContect 하나 선언
    var context: NSManagedObjectContext
    ///2.이니셜라이저
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}
