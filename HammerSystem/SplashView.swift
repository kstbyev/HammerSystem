import SwiftUI

struct SplashView: View {
    @State private var isShowingAuth = false
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.247, blue: 0.447)
                .ignoresSafeArea()
            
            Image("logo")
                .resizable()
                .frame(width: 322, height: 103)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isShowingAuth = true
            }
        }
        .fullScreenCover(isPresented: $isShowingAuth) {
            AuthView()
        }
    }
}

#Preview {
    SplashView()
} 