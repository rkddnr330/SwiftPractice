//
//  ArticleCell.swift
//  ScholarshipDemo
//
//  Created by Park Kangwook on 2022/06/04.
//

import SwiftUI

struct ArticleCell: View {
    
    var article: Article
    var isDateToday: Bool
    
    var body: some View {
        HStack {
            Spacer()
            VStack{
                Text(article.title)
                    .bold()
                    .padding(.top)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                if !isDateToday{
                    Spacer()
                    Text(article.publishDate.esDate())
                        .bold()
                }
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

//struct ArticleCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleCell(article: Article(title: "Deneme", url: URL(string: "https://www.google.com")!, publishDate: .now), isDateToday: true)
//    }
//}
