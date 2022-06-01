//
//  ContentView.swift
//  SIWA
//
//  Created by Park Kangwook on 2022/06/01.
//

///SIWA을 이용하기 위해 이거 import해야함
import AuthenticationServices
import SwiftUI

struct ContentView: View {
    var body: some View {
        ///SignInWithAppleButton이라고 따로 제공
        SignInWithAppleButton(
            .signUp,    ///레이블. 어떤 문구 띄울지
            onRequest: configure,   ///클릭시 발동되는 함수 호출
            onCompletion: handle    ///다음 과정으로 넘어갈 때 (ASAuthorization 또는 Error) 발동되는 함수 호출
        )
        .frame(height: 45)
        .padding()
    }
    
    func configure(_ request: ASAuthorizationAppleIDRequest) {
        print("onRequest 발동")
    }
    
    func handle(_ authResult: Result<ASAuthorization, Error>) {
        print("handle 발동")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
