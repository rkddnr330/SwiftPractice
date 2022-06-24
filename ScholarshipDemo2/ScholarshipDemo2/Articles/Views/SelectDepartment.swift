//
//  SelectTwo.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/23.
//

import SwiftUI

struct SelectDepartment: View {
    @Binding var isPresenting: Bool
    @State var selectionn: Int = 0
    @Binding var selection: Int
    @State var departmentName: String = ""
    @State private var departmentNamee = "화공생명환경공학부 환경공학전공"
    
    
    var arr = DataDemo().departmentList
    
    var body: some View {
        NavigationView{
            VStack{
                Text("학과를 선택하세요").padding()
                Picker(selection: $selection, label: Text("")) {
                    ForEach(arr[DataDemo().collegeList[selection]]!, id: \.self) { index in
                        Text(index)
                    }
                }
                Button {
                    isPresenting = false
                    departmentNamee = DataDemo().departmentList[DataDemo().collegeList[selection]]![selectionn]
                    DataService().fetchArticles(department: DataDemo().departmentList[DataDemo().collegeList[selection]]![selectionn])
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
