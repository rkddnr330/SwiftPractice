//
//  BudgetListViewModel.swift
//  BudgetApp
//
//  Created by Park Kangwook on 2022/05/17.
//

import Foundation
import CoreData

class BudgetListViewModel: ObservableObject {
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
}
