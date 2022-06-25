//
//  OnboardingDemo.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/23.
//

import SwiftUI

struct OnboardingDemo: View {
    @State private var selectedTab = 0
    @Binding var isOnboardingActive: Bool
    var body: some View {
        VStack {
            ///Carousel : TabView의 Style 중 하나
            TabView(selection: $selectedTab){
                VStack{
                    Text("소속 대학을 선택하세요")
                    Button {
                        isOnboardingActive = false
                    } label: {
                        Text("Skip")
                    }
                }
                .tag(0)
                VStack{
                    Text("소속 학과를 선택하세요")
                    Button {
                        isOnboardingActive = false
                    } label: {
                        Text("Skip")
                    }
                }
                .tag(1)
                VStack{
                    Text("각 학과에 올라온 장학금 공지사항을 한 눈에 볼 수 있답니다.")
                    Button {
                        isOnboardingActive = false
                    } label: {
                        Text("시작하기")
                    }
                    
                }
                .tag(2)
            }
            .frame(width: 340, height: 600)
            //                .tabViewStyle(PageTabViewStyle())
            .tabViewStyle(PageTabViewStyle())
            .onAppear{
                setupAppearance()
            }
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(red: 0.467, green: 0.696, blue: 0.821, alpha: 1.0)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

//struct OnboardingDemo_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingDemo()
//    }
//}
