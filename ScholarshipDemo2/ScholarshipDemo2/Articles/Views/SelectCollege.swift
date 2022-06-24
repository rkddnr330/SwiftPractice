//
//  SelectOne.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/23.
//

import SwiftUI

struct SelectCollege: View {
    @Binding var isPresenting: Bool
    @State var selection: Int = 3
    var arr = DataDemo().collegeList
    
    var body: some View {
        NavigationView{
        VStack {
            Text("소속 대학을 선택하세요")
            Picker(selection: $selection, label: Text("")) {
                ForEach(0..<arr.count, id: \.self) { index in
                    Text(arr[index])
                }
            }
            NavigationLink {
                SelectDepartment(isPresenting: $isPresenting, selection: $selection)
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
