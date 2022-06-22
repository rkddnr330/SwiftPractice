//
//  ContentView.swift
//  SIWA
//
//  Created by Park Kangwook on 2022/06/01.
//

///SIWA을 이용하기 위해 이거 import해야함
import AuthenticationServices
import SwiftUI

///SIWA을 하면 user의 정보들이 낱개로 뿌려지는데, 이거를 한 곳으로 모아 데이터 관리를 용이하게 하기 위해 AppleUser란 구조체를 생성하고 담을 거임
///그리고 필요한 프로퍼티들은 userID, firstName, lastName, email이 있다
struct AppleUser: Codable {
    let userID: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential) {
        guard
            let firstName = credentials.fullName?.givenName,
            let lastName = credentials.fullName?.familyName,
            let email = credentials.email
        else { return nil }
        
        self.userID = credentials.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isGo = false
    
    var body: some View {
        NavigationView {
//            NavigationLink(destination: MainView(), isActive: $isGo)
//            {
                ///SignInWithAppleButton이라고 따로 제공
                SignInWithAppleButton(
                    .signUp,    ///레이블. 어떤 문구 띄울지
                    onRequest: configure,   ///클릭시 발동되는 함수 호출
                    onCompletion: handle    ///다음 과정으로 넘어갈 때 (ASAuthorization 또는 Error) 발동되는 함수 호출. sheet가 pop up 되고 필요한 과정이 진행된다
                )
                .signInWithAppleButtonStyle(
                    colorScheme == .dark ? .white : .black
                )
                .frame(height: 45)
                .padding()
//            }
        }
    }
    
    ///Button에서 onRequest시 우리가 구성할 행동들 규정
    ///아마 요청을 받으면 정보들을 가져오는 것일 것(이름, email 등)
    ///함수의 전달인자인 ASAuthorizationAppleIDRequest : AppleID가 인증을 요청한다는 의미
    func configure(_ request: ASAuthorizationAppleIDRequest) {
        print("onRequest 발동")
        request.requestedScopes = [.email, .fullName] ///jump to definition 확인하면 이 말고 더 많은 정보들을 가져올 수 있다
    }
    
    func handle(_ authResult: Result<ASAuthorization, Error>) {
        print("handle 발동")
        switch authResult {
        case .success(let auth):
            print(auth)
            switch auth.credential {
            case let appleIdCredentials as ASAuthorizationAppleIDCredential:
                print(appleIdCredentials)
                if let appleUser = AppleUser(credentials: appleIdCredentials),
                    let appleUserData = try? JSONEncoder().encode(appleUser) {
                    
                    UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userID)
                    print("saved apple user", appleUser)
                    isGo = true
                    
                ///처음 회원가입 하고 나서 로그인 할 때 어떻게 되는지 보여주는 부분 (처음이 아닌 경우. Sign Up이 완료된 경우)
                } else {
                    print("missing some fields", appleIdCredentials.email, appleIdCredentials.fullName, appleIdCredentials.user)
                    ///missing some fields nil Optional() 000068.c72226023fd24620a8c9762bc0e635f2.0832
                    ///email : nil
                    ///fullName : Optional()
                    ///user : 000068.c72226023fd24620a8c9762bc0e635f2.0832
                    
                    ///이미 회원가입이 완료가 된 상황이므로, UserDefaults에 우리 정보가 저장되어있음
                    ///위의 코드를 보면 우리 Data를 JSONEncoder로 저장했다
                    ///그렇기 때문에 다시 이를 가져와서 JSONDecoder로 풀어주면 우리가 원하는 값을 원하는 모양으로 얻을 수 있다.
                    guard
                        let appleUserData = UserDefaults.standard.data(forKey: appleIdCredentials.user),
                        let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData)
                    else { return }
                    
                    print(appleUser)
                    print(appleUser.email)
                    print(appleUser.userID)
                    print(appleUser.lastName)
                    print(appleUser.firstName)
                }
            
            default:
                print(auth.credential)
            }
        case .failure(let error):
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
