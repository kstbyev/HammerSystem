import SwiftUI

struct FoodCard: View {
    let item: FoodItem
    
    var body: some View {
        HStack(spacing: 12) {
            FoodImageView(item: item)
            FoodContentView(item: item)
            Spacer()
        }
        .frame(maxWidth: 375, maxHeight: 156)
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

private struct FoodImageView: View {
    let item: FoodItem
    
    var body: some View {
        Group {
            if !item.image.isEmpty && (item.image.hasPrefix("http") || !item.image.contains("://")) {
                if item.image.hasPrefix("http") {
                    AsyncImage(url: URL(string: item.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        LoadingImageView()
                    }
                } else {
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            } else {
                FallbackImageView(category: item.category)
            }
        }
        .frame(width: 132, height: 132)
        .clipped()
        .cornerRadius(12)
    }
}

private struct LoadingImageView: View {
    var body: some View {
        Rectangle()
            .fill(Color.orange.opacity(0.2))
            .overlay(
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .orange))
            )
    }
}

private struct FallbackImageView: View {
    let category: String
    
    var body: some View {
        Rectangle()
            .fill(Color.orange.opacity(0.2))
            .overlay(
                Image(systemName: categoryIcon)
                    .font(.system(size: 40))
                    .foregroundColor(.orange.opacity(0.8))
            )
    }
    
    private var categoryIcon: String {
        switch category {
        case "Пицца": return "circle.fill"
        case "Комбо": return "square.stack.3d.up"
        case "Десерты": return "heart.fill"
        case "Напитки": return "drop.fill"
        default: return "circle.fill"
        }
    }
}

private struct FoodContentView: View {
    let item: FoodItem
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
                FoodTitleView(title: item.name)
                FoodDescriptionView(description: item.description)
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    PriceButton(price: item.price)
                }
                .padding(.bottom, 8)
            }
        }
        .frame(maxWidth: 171, maxHeight: 124)
    }
}

private struct FoodTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 15, weight: .semibold))
            .foregroundColor(Color(red: 0.133, green: 0.157, blue: 0.192))
            .frame(maxWidth: 150, maxHeight: 24, alignment: .leading)
            .lineLimit(1)
            .minimumScaleFactor(0.6)
            .padding(.leading, 18)
            .padding(.top, 0)
    }
}

private struct FoodDescriptionView: View {
    let description: String
    
    var body: some View {
        Text(description)
            .font(.system(size: 11, weight: .regular))
            .foregroundColor(Color(red: 0.665, green: 0.668, blue: 0.679))
            .frame(maxWidth: 170, maxHeight: 80, alignment: .topLeading)
            .lineLimit(6)
            .multilineTextAlignment(.leading)
            .lineSpacing(-1)
            .minimumScaleFactor(0.8)
            .padding(.leading, 18)
            .padding(.top, 2)
    }
}

private struct PriceButton: View {
    let price: Int
    
    var body: some View {
        Button(action: {}) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(red: 0.992, green: 0.227, blue: 0.412), lineWidth: 1)
                    .frame(width: 87, height: 32)
                    .background(Color.clear)
                
                Text("от \(price) ₽")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(red: 0.992, green: 0.227, blue: 0.412))
                    .frame(maxWidth: 75, maxHeight: 16)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
    }
} 