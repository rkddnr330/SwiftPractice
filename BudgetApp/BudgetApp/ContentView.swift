//
//  ContentView.swift
//  BudgetApp
//
//  Created by Park Kangwook on 2022/05/17.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    private var budgetListVM: BudgetListViewModel
    
    @State var isPresented = false
    
    ///이게 뭔 소린데. vm이 갑자기 어디서 튀어나온거고, init이 왜 여기 있는 건데
    ///나는 이걸 model이나 viewmodel 파일에서만 봤다고. 왜 view에서 튀어나오냐고
    init(vm:BudgetListViewModel) {
        self.budgetListVM = vm
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Budgets!")
                    .padding()
            }
            .navigationTitle("Budget App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        isPresented.toggle()

                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                AddBudgetScreen()
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
        ContentView(vm: BudgetListViewModel(context: viewContext))
    }
}
