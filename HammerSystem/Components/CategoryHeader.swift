import SwiftUI

struct CategoryHeader: View {
    let categories: [String]
    @Binding var selectedCategory: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(0..<categories.count, id: \.self) { index in
                    CategoryButton(
                        title: categories[index],
                        isSelected: selectedCategory == index
                    ) {
                        selectedCategory = index
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
        .frame(height: 48)
    }
}

private struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    private let selectedColor = Color(red: 0.992, green: 0.227, blue: 0.412)
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? selectedColor.opacity(0.2) : Color.clear)
                    .frame(width: 100, height: 32)
                
                if !isSelected {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(selectedColor.opacity(0.4), lineWidth: 1)
                        .frame(width: 100, height: 32)
                }
                
                Text(title)
                    .font(.system(size: 13, weight: isSelected ? .bold : .regular))
                    .foregroundColor(isSelected ? selectedColor : selectedColor.opacity(0.4))
                    .frame(maxWidth: 90, maxHeight: 16)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
} 