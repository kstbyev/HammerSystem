import SwiftUI

struct AuthView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var showError = false
    @State private var showSuccess = false
    @State private var isShowingMain = false
    @State private var isKeyboardShown = false
    
    var body: some View {
        ZStack {
            // Светло-серый фон
            Color.gray.opacity(0.1)
                .ignoresSafeArea()
            

            // Баннер ошибки поверх всего содержимого
            if showError {
                            VStack {
                                HStack {
                                    Text("Неверный логин или пароль")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(Color(red: 0.992, green: 0.227, blue: 0.412))
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)

                                    Button(action: {
                                        showError = false
                                    }) {
                                        Image(systemName: "xmark.circle")
                                            .foregroundColor(Color(red: 0.992, green: 0.227, blue: 0.412))
                                            .font(.system(size: 16))
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                                .frame(width: 343, height: 50)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 4)
                                .padding(.top, 0)

                                Spacer()
                            }
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.3), value: showError)
                            .zIndex(2)
                        }
            
            VStack(spacing: 0) {
                // Заголовок "Авторизация" в самом верху
                Text("Авторизация")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .padding(.bottom, isKeyboardShown ? 40 : 120)
                    .animation(.easeInOut(duration: 0.3), value: isKeyboardShown)
                
                            // Розовый логотип
            Image("logo2")
                .resizable()
                .frame(width: isKeyboardShown ? 300 : 322, height: isKeyboardShown ? 96 : 103)
                .padding(.bottom, isKeyboardShown ? 10 : 60)
                .animation(.easeInOut(duration: 0.3), value: isKeyboardShown)
                
                VStack(spacing: 20) {
                    // Поле логина с иконкой Union и анимацией
                    HStack {
                        Image("Union")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                        TextField("Логин", text: $login)
                            .foregroundColor(.black)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isKeyboardShown = true
                                }
                            }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .cornerRadius(15)
                    
                    // Поле пароля с иконкой lock-line
                    HStack {
                        Image("lock-line")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                        if showPassword {
                                                    TextField("Пароль", text: $password)
                            .foregroundColor(.black)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isKeyboardShown = true
                                }
                            }
                        } else {
                                                    SecureField("Пароль", text: $password)
                            .foregroundColor(.black)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isKeyboardShown = true
                                }
                            }
                        }
                        
                        // Показывать кнопку глаза только если есть текст в поле пароля
                        if !password.isEmpty {
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye" : "eye.slash")
                                    .foregroundColor(.gray.opacity(0.6))
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .cornerRadius(15)
                }
                            .padding(.horizontal, 30)
            .padding(.top, isKeyboardShown ? 10 : 0)
            .padding(.bottom, isKeyboardShown ? 20 : 0)
                
                Spacer()
                
                            // Контейнер для кнопки "Войти"
            VStack(spacing: 0) {
                    // Кнопка "Войти" с хорошим отображением текста
                    Button(action: {
                        performAuth()
                    }) {
                        Text("Войти")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color(red: 0.992, green: 0.227, blue: 0.412))
                            .cornerRadius(15)
                            .opacity(login.isEmpty || password.isEmpty ? 0.5 : 1.0)
                    }
                    .disabled(login.isEmpty || password.isEmpty)
                                    .padding(.horizontal, 30)
                .padding(.top, 15)
                .padding(.bottom, 20)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                )
                .cornerRadius(25)
                }
            }
        }
        .onTapGesture {
            // Скрыть клавиатуру при нажатии вне полей
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            withAnimation(.easeInOut(duration: 0.3)) {
                isKeyboardShown = false
            }
        }
        .onChange(of: showSuccess) { success in
            if success {
                // Сразу переходим на главный экран
                isShowingMain = true
            }
        }
        .fullScreenCover(isPresented: $isShowingMain) {
            MainTabView()
        }
    }
    
    private func performAuth() {
        // Простая валидация для демо
        if login.isEmpty || password.isEmpty {
            showError = true
            autoHideError()
            return
        }
        
        // Захардкоженные данные для теста
        if login == "admin" && password == "123" {
            showSuccess = true
        } else {
            showError = true
            autoHideError()
        }
    }
    
    private func autoHideError() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showError = false
        }
    }
}

#Preview {
    AuthView()
} 