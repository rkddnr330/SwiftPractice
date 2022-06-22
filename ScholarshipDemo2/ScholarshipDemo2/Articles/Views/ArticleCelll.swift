//
//  ArticleCelll.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/22.
//

import SwiftUI

struct ArticleCelll: View {
    var article: Article
    
    var body: some View {
        HStack {
            Spacer()
            VStack{
                Text(article.title)
                    .bold()
                    .padding(.top)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }
            .onTapGesture {
                if let url = article.url{
                    UIApplication.shared.open(url)
                }
                
                
            }
            Spacer()
        }
    }
}

//struct ArticleCelll_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleCelll()
//    }
//}
