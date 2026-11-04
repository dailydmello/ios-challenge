import SwiftUI

struct GridView: View {
    let position: Position
    let direction: Direction
    // Cumulative angle for animation; falls back to the direction's own angle.
    var heading: Double?
    var gridSize: Int = Roomba.gridSize

    private let spacing: CGFloat = 2

    var body: some View {
        GeometryReader { proxy in
            let side = min(proxy.size.width, proxy.size.height)
            let cellSide = (side - spacing * CGFloat(gridSize - 1)) / CGFloat(gridSize)
            let pitch = cellSide + spacing

            ZStack(alignment: .topLeading) {
                // Top row (y = gridSize - 1) comes first so north points up.
                VStack(spacing: spacing) {
                    ForEach(0..<gridSize, id: \.self) { _ in
                        HStack(spacing: spacing) {
                            ForEach(0..<gridSize, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.secondary.opacity(0.15))
                                    .frame(width: cellSide, height: cellSide)
                            }
                        }
                    }
                }
                .accessibilityHidden(true)

                roomba(side: cellSide)
                    .offset(
                        x: CGFloat(position.x) * pitch,
                        y: CGFloat(gridSize - 1 - position.y) * pitch
                    )
            }
            .frame(width: side, height: side, alignment: .topLeading)
            .animation(.snappy, value: position)
            .animation(.snappy, value: heading ?? direction.degrees)
        }
        .aspectRatio(1, contentMode: .fit)
    }

    private func roomba(side: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.accentColor)
            .frame(width: side, height: side)
            .overlay {
                Image(systemName: "arrow.up")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .rotationEffect(.degrees(heading ?? direction.degrees))
            }
            .accessibilityElement()
            .accessibilityLabel("Roomba at \(position.x), \(position.y), facing \(direction.name)")
            .accessibilityIdentifier("roomba")
    }
}

#Preview("Start (0,0) north") {
    GridView(position: Position(x: 0, y: 0), direction: .north).padding()
}

#Preview("(5,5) east") {
    GridView(position: Position(x: 5, y: 5), direction: .east).padding()
}

#Preview("(9,9) south") {
    GridView(position: Position(x: 9, y: 9), direction: .south).padding()
}

#Preview("(0,9) west") {
    GridView(position: Position(x: 0, y: 9), direction: .west).padding()
}

#Preview("Inside a VStack with spacers") {
    VStack {
        Text("Title")
        GridView(position: Position(x: 0, y: 0), direction: .north)
        Spacer()
        Text("Footer")
    }
    .padding()
}
