//
//  icaloriesApp.swift
//  icalories
//
//  Created by Park Kangwook on 2022/05/16.
//

import SwiftUI

@main
struct icaloriesApp: App {
    ///@StateObject로 가져온다. DataController 파일에 있는 DataController class를 가져온다는 의미로 DataController() (이니셜라이저까지)
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                ///모든 곳에서 이 데이터를 쓸 수 있게하는 코드 ex) @Environment(\.managedObjectContext)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
