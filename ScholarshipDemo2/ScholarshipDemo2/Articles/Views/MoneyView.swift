////
////  MoneyView.swift
////  ScholarshipDemo2
////
////  Created by Park Kangwook on 2022/06/22.
////
//
//import SwiftUI
//
//struct MoneyView: View {
//    var body: some View {
//        NavigationView {
//            List{
//                Section {
//                    //                    ForEach(todaysResults()) { article in
//                    //                        ArticleCell(article: article, isDateToday: true)
//                    Text("text")
//                    Text("text")
//                }
//            } header: {
//                Text("Today")
//                    .foregroundColor(Color("SubColor"))
//            } footer: {
//                //                Text("\(todaysResults().count) Article(s)")
//                Text("12 Article(s)")
//                    .background(.clear)
//                
//            }
//            
//            Section {
//                //                ForEach(previousResults()) { article in
//                //                    ArticleCell(article: article, isDateToday: false)
//                Text("text")
//                
//            }
//            
//        } header: {
//            //                Text(oldPostsHeader)
//            Text("old Posts Header")
//            
//                .foregroundColor(Color("SubColor"))
//        } footer: {
//            //                    Text("\(previousResults().count) Article(s)")
//            Text("2 Article(s)")
//        }
//        
//    }
//}
//
//
//

import SwiftUI



struct DataDemooo {
    var id = UUID()
    var university: String
    var department: String
    var url: String {
        guard let go = UrlDemo().urlList[department] else { return "" }
        return go
    }
}

struct MoneyView: View {
    var totalDemo : [String:[String]] =
    ["인문대":["불어","언어","국어"],
     "공대":["기공","화공","컴공"],
     "자연대":["물리","수학","화학"]
    ]
    @ObservedObject var data = DataService()
    @State private var searchText = ""
    @Binding var isOnboardingActive : Bool
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    isOnboardingActive = true
                } label: {
                    Text("온보딩 화면")
                }

                List{
                    Section {
        //                    ForEach(todaysResults()) { article in
        //                        ArticleCell(article: article, isDateToday: true)
        //                    }
                            ForEach(searchResults) { article in
                                ArticleCelll(article: article)
                            }
                        } header: {
                            Text("학과 이름")
                                .foregroundColor(Color("SubColor"))
                        } footer: {
                            Text("\(searchResults.count) Article(s)")
                                .background(.clear)
                    }
                    
                    
                    ///다른 학과 섹션이 되겠지. 또는 학교 공홈 공지사항
                    Section {
                        ForEach(searchOfficialResults) { article in
                            ArticleCelll(article: article)
                        }
                        
                    } header: {
                        Text("학교 공홈")
                            .foregroundColor(Color("SubColor"))
                    } footer: {
                        Text("\(searchOfficialResults.count) Article(s)")
                        
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .refreshable {
                    fetchData()
                }
                .disableAutocorrection(true)
                .onAppear(perform: fetchData)
            .navigationTitle(Text("장학금 목록"))
            }
        }
    }
    
    var searchResults : [Article] {
        if searchText.isEmpty{
            return data.articleList
        } else {
            return data.articleList.filter({
                $0.title.lowercased().localizedStandardContains(searchText.lowercased())
                ||
                $0.publishDate.esDate().localizedStandardContains(searchText.lowercased())
            })
        }
    }
    
    var searchOfficialResults : [Article] {
        if searchText.isEmpty{
            return data.officialList
        } else {
            return data.officialList.filter({
                $0.title.lowercased().localizedStandardContains(searchText.lowercased())
                ||
                $0.publishDate.esDate().localizedStandardContains(searchText.lowercased())
            })
        }
    }
    
    func fetchData(){
        data.fetchArticles()
    }
}

//struct MoneyView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoneyView()
//    }
//}
