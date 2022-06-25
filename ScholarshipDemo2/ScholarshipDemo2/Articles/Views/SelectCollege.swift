//
//  SelectOne.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/23.
//

import SwiftUI

struct SelectCollege: View {
    @EnvironmentObject var data : DataService
    @Binding var isPresenting: Bool
    @State private var selectedCollege = "공과대학"
    
    var collegeArr = DataDemo().collegeList
    
    var body: some View {
        NavigationView{
            VStack {
                Text("소속 대학을 선택하세요")
                Picker(selection: $selectedCollege, label: Text("")) {
                    ForEach(collegeArr, id: \.self) { index in
                        Text(index)
                    }
                }
                NavigationLink {
                    SelectDepartment(isPresenting: $isPresenting, selectedCollege: $selectedCollege)
                } label: {
                    Text("다음")
                }
            }
        }
    }
}
//
//struct SelectOne_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectOne()
//    }
//}
