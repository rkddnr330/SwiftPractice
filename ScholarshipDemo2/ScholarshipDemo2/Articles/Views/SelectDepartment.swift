//
//  SelectTwo.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/23.
//

import SwiftUI

struct SelectDepartment: View {
    @EnvironmentObject var data : DataService
    @Binding var isPresenting: Bool
    @Binding var selectedCollege: String
    @State private var selectedDepartment = "화공생명환경공학부 환경공학전공"
    
    var departmentArr = DataDemo().departmentList
    
    var body: some View {
        NavigationView{
            VStack{
                Text("학과를 선택하세요").padding()
                Picker(selection: $selectedDepartment, label: Text("")) {
                    ForEach(departmentArr[selectedCollege]!, id: \.self) { index in
                        Text(index)
                    }
                }
                Button {
                    isPresenting = false
                    if selectedCollege == "공과대학", selectedDepartment == "화공생명환경공학부 환경공학전공" {
                        data.currentDepartment = selectedDepartment
                    } else {
                        data.currentDepartment = departmentArr[selectedCollege]![0]
                    }
                    data.currentDepartment = selectedDepartment
//                    print("0️⃣\(data.currentDepartment)")
                } label: {
                    Text("완료")
                }
            }
        }
    }
}
//
//struct SelectTwo_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectTwo()
//    }
//}
