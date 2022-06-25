//
//  MoneyView.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/22.
//


import SwiftUI

//struct DataDemooo {
//    var id = UUID()
//    var university: String
//    var department: String
//    var url: String {
//        guard let go = UrlDemo().urlList[department] else { return "" }
//        return go
//    }
//}

struct MoneyView: View {
    
    @EnvironmentObject var data: DataService
    @State private var searchText = ""
    @Binding var isOnboardingActive : Bool
    @State private var isPresenting = false
//    @State private var departmentName: String = "화공생명환경공학부 환경공학전공"
//    @Binding var departmentNamee: String
    
    var body: some View {
        NavigationView {
            VStack {
                

                List{
                    Section {
        //                    ForEach(todaysResults()) { article in
        //                        ArticleCell(article: article, isDateToday: true)
        //                    }
                            ForEach(searchResults) { article in
                                ArticleCelll(article: article)
                            }
                        } header: {
                            Text(data.currentDepartment)
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
                        Text("PNU 공지사항")
                            .foregroundColor(Color("SubColor"))
                    } footer: {
                        Text("\(searchOfficialResults.count) Article(s)")
                        
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .refreshable {
                    data.fetchArticles(department: data.currentDepartment)
                }
                .disableAutocorrection(true)
//                .onAppear(perform: fetchData)
            
                .navigationTitle(Text("장학금 목록"))
                
                Button {
                    isOnboardingActive = true
                } label: {
                    Text("온보딩 화면")
                }
                .padding()
                Button {
                    isPresenting = true
                } label: {
                    Text("학과 선택")
                }
                
            }
            .sheet(isPresented: $isPresenting) {
                VStack{
                    SelectCollege(isPresenting: $isPresenting)
                }
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
    
//    func fetchData(){
//        data.fetchArticles(department: "화공생명환경공학부 환경공학전공")
//    }
}

//struct MoneyView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        MoneyView()
//            .environmentObject(DataService())
//    }
//}
