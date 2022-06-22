//
//  DetailView.swift
//  MC2Demo
//
//  Created by Park Kangwook on 2022/06/09.
//

import SwiftUI

struct DetailView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        NavigationView{
            VStack {
                ///Carousel : TabView의 Style 중 하나
                TabView(selection: $selectedTab){
                    DetailStandingView()
                        .tag(0)
                    DetailNFCView()
                        .tag(1)
                    DetailInformationView()
                        .tag(2)
                }
                .frame(width: 340, height: 600)
//                .tabViewStyle(PageTabViewStyle())
                .tabViewStyle(PageTabViewStyle())
                .background(Color.gray)
                .cornerRadius(15)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
