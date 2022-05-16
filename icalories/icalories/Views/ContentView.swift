//
//  ContentView.swift
//  icalories
//
//  Created by Park Kangwook on 2022/05/16.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    ///database로부터 data를 쓰기 위해 FetchRequest 필요
    ///sortDescriptors : 가져오는 배열 방식 설정. 여기서는 date를 기준으로. + 역순으로 (날짜가 제일 적은 것부터 == 최신 것부터)
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("\(Int(totalCaloriesToday())) Kcal (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                List{
                    ForEach(food){ food in
                        NavigationLink(destination: Text("\(food.calories)")){
                            VStack(alignment: .leading, spacing: 6){
                                HStack{
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text("\(food.name!)")
                                                .bold()
                                            Text("\(Int(food.calories))") + Text(" calories").foregroundColor(.red)
                                        }
                                    }
                                    Spacer()
                                    Text("\(calcTimeSince(date: food.date!))")
                                        .foregroundColor(.gray)
                                        .italic()
                                }
                            }
                        }
                    }.onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
            .navigationTitle("iCalories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
//                    Button(Image(systemName: "plus.circle")){
//                        showingAddView.toggle()
//                    }
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }

                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    ///이거 개꿀. EditButton() 하나만 써놓으면 알아서 구현해준다
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddFoodView()
            }
        }
        .navigationViewStyle(.stack)
        
    }
    ///offset: IndexSet 이 뭘까?
    private func deleteFood(offsets: IndexSet) {
        ///delete는 애니메이션(해당 항목 옆으로 스와이프)이 포함된 것. 그러므로 따로 지정안해주고 {} 열어서 코드 쳐주기
        withAnimation {
            ///forEach문 돌면서 해당 index 찾으면 delete 한다는 구문인 거 같은데, map이 정확히 뭐고, $0이 정확히 뭘까?
            offsets.map {food[$0]}.forEach(managedObjContext.delete)
            ///삭제해젔으면 빠진 상태의 값 저장해주기.
            DataController().save(context: managedObjContext)
        }
    }
    
    func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        return caloriesToday
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
