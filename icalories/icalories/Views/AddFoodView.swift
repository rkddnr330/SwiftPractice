//
//  AddFoodView.swift
//  icalories
//
//  Created by Park Kangwook on 2022/05/16.
//

import SwiftUI

struct AddFoodView: View {
    ///이 wrapper들은 뭘까?
    ///Injecting Data때 선언해줬던 (icaloriesApp에서) wrapper를 여기에 쓴 거임
    @Environment(\.managedObjectContext) var managedObjContext
    ///dismiss는 따로 파일에서 선언 안해줬는데 여기서 씀. 아마 내장함수 그런 개념인듯
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("Food Name", text: $name)
                
                VStack {
                    Text("Calories : \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step:10)
                }
                .padding()
                
                HStack{
                    Spacer()
                    Button("Submit") {
                        ///DataController() (이니셜라이저 포함)에서 addFood 함수를 쓴다! 
                        DataController().addFood(name: name, calories: calories, context: managedObjContext)
                        ///Submit 버튼 눌렀으면 당연히 이 창 닫혀야지. 그니까 dismiss() 호출
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
