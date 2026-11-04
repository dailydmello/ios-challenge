import SwiftUI

struct GridView: View {
    let position: Position
    let direction: Direction
    var gridSize: Int = Roomba.gridSize

    private let spacing: CGFloat = 2

    var body: some View {
        GeometryReader { proxy in
            let side = min(proxy.size.width, proxy.size.height)
            let cellSide = (side - spacing * CGFloat(gridSize - 1)) / CGFloat(gridSize)
            // Top row (y = gridSize - 1) comes first so north points up.
            VStack(spacing: spacing) {
                ForEach((0..<gridSize).reversed(), id: \.self) { y in
                    HStack(spacing: spacing) {
                        ForEach(0..<gridSize, id: \.self) { x in
                            cell(isRoomba: position == Position(x: x, y: y), side: cellSide)
                        }
                    }
                }
            }
            .frame(width: side, height: side)
        }
        .aspectRatio(1, contentMode: .fit)
    }

    private func cell(isRoomba: Bool, side: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(isRoomba ? Color.accentColor : Color.secondary.opacity(0.15))
            .frame(width: side, height: side)
            .overlay {
                if isRoomba {
                    Image(systemName: "arrow.up")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .rotationEffect(direction.angle)
                }
            }
    }
}

private extension Direction {
    var angle: Angle {
        switch self {
        case .north: .degrees(0)
        case .east: .degrees(90)
        case .south: .degrees(180)
        case .west: .degrees(270)
        }
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

#Preview("Inside a VStack with spacers") {
    VStack {
        Text("Title")
        GridView(position: Position(x: 0, y: 0), direction: .north)
        Spacer()
        Text("Footer")
    }
    .padding()
}

#Preview("(0,9) west") {
    GridView(position: Position(x: 0, y: 9), direction: .west).padding()
}
