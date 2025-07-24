//
//  MainTabView.swift
//  HammerSystem
//
//  Created by Madi Sharipov on 23.07.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MenuView()
                .tabItem {
                    Image("Меню")
                    Text("Меню")
                }
            
            ContactsView()
                .tabItem {
                    Image("Контакты")
                    Text("Контакты")
                }
            
            ProfileView()
                .tabItem {
                    Image("Профиль")
                    Text("Профиль")
                }
            
            CartView()
                .tabItem {
                    Image("Корзина")
                    Text("Корзина")
                }
        }
        .accentColor(Color(red: 1.0, green: 0.247, blue: 0.447))
    }
}

struct ContactsView: View {
    var body: some View {
        Text("Контакты")
            .font(.title)
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Профиль")
            .font(.title)
    }
}

struct CartView: View {
    var body: some View {
        Text("Корзина")
            .font(.title)
    }
}

#Preview {
    MainTabView()
} 