//
//  StateBinding1.swift
//  DataFlowStudy
//
//  Created by Park Kangwook on 2022/05/26.
//

import SwiftUI

struct StateBinding1: View {
    @State private var stars: Int=0     //Source of Truth
    @State private var isShowing = false    //Source of Truth
    ///여기서 정확히 모르겠는 점 : private를 쓰고 안쓰고의 차이
    ///private 이라는 게 이 View에서만 사용한다는 의미로 파악했는데 정확히 어떤 걸 얘기하는지 모르겠다
    
    var body: some View {
        VStack {
            Text("stars :\(stars)")
            
            Button("Add One ⭐️"){
                addStars()
            }
            
            Button("Check those ⭐️"){
                isShowing.self.toggle()
            }
            ///isShowing 값을 Binding으로 가져와서 isPresented를 판단
            .sheet(isPresented: $isShowing) {
                ///stars : 지금 이 View에 @State로 선언했기 때문에 Source of Truth가 있다
                ///CheckView에 Binding으로 넘겨줄 거다
                CheckView(star: $stars)
            }
        }
        .padding()
    }
    
    func addStars() {
        stars += 1
    }
}

struct CheckView: View {
    ///star라고 이름을 굳이 구별해서 선언했지만, $stars를 받은 거다.
    @Binding var star: Int
    var body: some View {
        Text("\(star) ⭐️")
    }
}

struct StateBinding1_Previews: PreviewProvider {
    static var previews: some View {
        StateBinding1()
    }
}
