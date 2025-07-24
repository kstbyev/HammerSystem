import SwiftUI

struct MenuView: View {
    @StateObject private var foodService = FoodDataService()
    @State private var selectedCategory = 0
    @State private var showSuccessBanner = true
    @State private var selectedCity = "Москва"
    @State private var showCityPicker = false
    
    private let categories = ["Пицца", "Комбо", "Десерты", "Напитки"]
    
    private let pizzas = [
        FoodItem(
            name: "Ветчина и грибы",
            description: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус",
            price: 345,
            image: "hamandmushr",
            category: "Пицца"
        ),
        FoodItem(
            name: "Баварские колбаски",
            description: "Баварские колбаски, ветчина, пикантная пепперони, острая чоризо, моцарелла",
            price: 345,
            image: "bayernsausages",
            category: "Пицца"
        ),
        FoodItem(
            name: "Нежный лосось",
            description: "Лосось, томаты черри, моцарелла, соус песто",
            price: 395,
            image: "gentlemoose",
            category: "Пицца"
        ),
        FoodItem(
            name: "Пицца четыре сыра",
            description: "Соус Карбонара, Моцарелла, Пармезан, Роккфорти, Чеддер",
            price: 455,
            image: "4cheez",
            category: "Пицца"
        )
    ]
    
    private var currentItems: [FoodItem] {
        switch selectedCategory {
        case 0: return pizzas
        case 1: return foodService.getCombos()
        case 2: return foodService.getDesserts()
        case 3: return foodService.getDrinks()
        default: return pizzas
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CitySelector(selectedCity: $selectedCity, showCityPicker: $showCityPicker)
            
            if showSuccessBanner {
                SuccessBanner { showSuccessBanner = false }
            }
            
            if foodService.isOfflineMode() {
                OfflineBanner()
            }
            
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        PromoBanners()
                        
                        Section {
                            LazyVStack(spacing: 16) {
                                ForEach(currentItems) { item in
                                    FoodCard(item: item)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 20)
                            .padding(.bottom, 100)
                            .id("food-section-\(selectedCategory)")
                        } header: {
                            CategoryHeader(
                                categories: categories,
                                selectedCategory: $selectedCategory
                            )
                            .background(Color.white)
                        }
                    }
                }
                .onChange(of: selectedCategory) { _, newCategory in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        proxy.scrollTo("food-section-\(newCategory)", anchor: .top)
                    }
                }
            }
        }
        .background(Color(UIColor.systemBackground))
        .sheet(isPresented: $showCityPicker) {
            CityPickerView(selectedCity: $selectedCity, isPresented: $showCityPicker)
        }
        .onAppear {
            setupInitialState()
        }
    }
    
    private func setupInitialState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showSuccessBanner = false
        }
        
        Task {
            await foodService.loadData()
        }
    }
    

}

#Preview {
    MenuView()
} 