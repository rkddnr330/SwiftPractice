//
//  EditFoodView.swift
//  icalories
//
//  Created by Park Kangwook on 2022/05/17.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    ///이 코드는 뭘까
    var food : FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form{
            Section{
                TextField("\(food.name!)", text: $name)
                    ///Edit에서 기존 값 불러오게 하는 코드
                    .onAppear{
                        name = food.name!
                        calories = food.calories
                    }
                
                VStack{
                    Text("Calories : \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                    
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editFood(food: food, name: name, calories: calories, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
            ///onAppear 코드가 Section {}을 감싸는 여기 위치에 있어도 결과는 같음
//            .onAppear{
//                name = food.name!
//                calories = food.calories
//            }
        }
    }
}
