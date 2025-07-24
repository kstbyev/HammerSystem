import SwiftUI

struct CitySelector: View {
    @Binding var selectedCity: String
    @Binding var showCityPicker: Bool
    
    var body: some View {
        HStack {
            Button(action: { showCityPicker = true }) {
                HStack(spacing: 4) {
                    Text(selectedCity)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(Color(red: 0.133, green: 0.157, blue: 0.192))
                        .frame(height: 20)
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.blue)
                        .frame(width: 12, height: 6)
                }
            }
            .frame(height: 20)
            
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.top, 8)
        .background(Color.white)
    }
}

struct SuccessBanner: View {
    let onDismiss: () -> Void
    
    var body: some View {
        HStack {
            Text("Вход выполнен успешно")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.green)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            Button(action: onDismiss) {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.green)
                    .font(.system(size: 16))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 16)
        .padding(.top, 4)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

struct OfflineBanner: View {
    var body: some View {
        HStack {
            Image(systemName: "wifi.slash")
                .foregroundColor(.orange)
                .font(.system(size: 16))
            
            Text("Offline режим - показаны сохраненные данные")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.orange)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.orange.opacity(0.1))
        .cornerRadius(15)
        .padding(.horizontal, 16)
        .padding(.top, 4)
    }
}

struct PromoBanners: View {
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Image("discount30")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 343, height: 112)
                        .clipped()
                        .cornerRadius(16)

                    Image("hbd")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 112)
                        .clipped()
                        .cornerRadius(16)
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.top, 8)
        .id("banners")
    }
} 