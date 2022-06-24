////
////  ArticleListVieww.swift
////  ScholarshipDemo2
////
////  Created by Park Kangwook on 2022/06/16.
////
//
//import SwiftUI
//
//struct ArticleListVieww: View {
//    
//    @ObservedObject var data = DataService()
//    @State private var searchText = ""
//    let today = Calendar.current.startOfDay(for: .now)
//    
//    var body: some View {
//        NavigationView {
//            List{
//                Section {
//                    
//                        ForEach(todaysResults()) { article in
//                            ArticleCell(article: article, isDateToday: true)
//                        }
//                    
//                } header: {
//                    Text("정컴💻")
//                        .foregroundColor(Color("SubColor"))
//                } footer: {
//                    if searchResults.filter({$0.publishDate.isInToday(date: today)}).count > 0{
//                        Text("\(todaysResults().count) Article(s)")
//                            .background(.clear)
//                    }
//                }
//                
//                Section {
//                    if previousResults().count == 0{
//                        Text("우릴 버렸으면서 어딜! 쓰읍!~!")
//                    } else {
//                        ForEach(previousResults()) { article in
//                            ArticleCell(article: article, isDateToday: false)
//                        }
//                    }
//                } header: {
//                    Text(oldPostsHeader)
//                        .foregroundColor(Color("SubColor"))
//                } footer: {
//                    if previousResults().count == 0{
//                        
//                    } else {
//                        Text("\(previousResults().count) Article(s)")
//                    }
//                }
//            }
//            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
//            .refreshable {
//                fetchData()
//            }
//            .disableAutocorrection(true)
//            .onAppear(perform: fetchData)
//            .navigationTitle(Text("성똥이의 장학금💸?!"))
//        }
//    }
//    
//    func todaysResults() -> [Article]{
//        return searchResults.filter({ $0.publishDate.isInToday(date: today) })
//    }
//    
//    func previousResults() -> [Article]{
//        return searchResults.filter({ $0.publishDate.isOlderThanToday(date: today) })
//    }
//    
//    var searchResults : [Article] {
//        if searchText.isEmpty{
//            return data.articleList
//        } else {
//            return data.articleList.filter({
//                $0.title.lowercased().localizedStandardContains(searchText.lowercased())
//                ||
//                $0.publishDate.esDate().localizedStandardContains(searchText.lowercased())
//            })
//        }
//    }
//    
//    var oldPostsHeader : String{
//        if searchText.isEmpty{
//            return "분생🌱"
//        } else {
//            return "Results for " + searchText
//        }
//    }
//    
//    func fetchData(){
//        data.fetchArticles()
//    }
//}
//
//struct ArticleListVieww_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleListVieww()
//    }
//}
