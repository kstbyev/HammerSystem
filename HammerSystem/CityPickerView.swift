import SwiftUI

struct CityPickerView: View {
    @Binding var selectedCity: String
    @Binding var isPresented: Bool
    
    private let cities = [
        "Москва", "Санкт-Петербург", "Екатеринбург", "Новосибирск", 
        "Казань", "Нижний Новгород", "Челябинск", "Самара", 
        "Омск", "Ростов-на-Дону", "Уфа", "Красноярск"
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cities, id: \.self) { city in
                    Button(action: {
                        selectedCity = city
                        isPresented = false
                    }) {
                        HStack {
                            Text(city)
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                            
                            Spacer()
                            
                            if city == selectedCity {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color(red: 0.992, green: 0.227, blue: 0.412))
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Выберите город")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Готово") {
                    isPresented = false
                }
                .foregroundColor(Color(red: 0.992, green: 0.227, blue: 0.412))
            )
        }
    }
} 