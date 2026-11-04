import SwiftUI

/// The single screen: a 10×10 grid showing the roomba and the direction it
/// faces, a status line, and the two movement buttons.
/// Already implemented — it reflects `Roomba` state, so it comes alive
/// once the model is solved.
struct ContentView: View {
    @StateObject private var viewModel = RoombaViewModel()

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 2),
        count: Roomba.gridSize
    )

    var body: some View {
        VStack(spacing: 16) {
            Text("Roomba")
                .font(.title.bold())

            grid

            Text("Position (\(viewModel.roomba.position.x), \(viewModel.roomba.position.y)) · Facing \(directionName)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Button("↑ Move Forward") {
                    viewModel.moveForward()
                }
                .buttonStyle(.borderedProminent)

                Button("↻ Turn Right") {
                    viewModel.turnRight()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }

    private var grid: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            // Render top row (y = 9) first so north is up.
            ForEach((0..<Roomba.gridSize).reversed(), id: \.self) { y in
                ForEach(0..<Roomba.gridSize, id: \.self) { x in
                    cell(x: x, y: y)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }

    @ViewBuilder
    private func cell(x: Int, y: Int) -> some View {
        let isRoomba = viewModel.roomba.position.x == x && viewModel.roomba.position.y == y
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(isRoomba ? Color.accentColor : Color.secondary.opacity(0.15))
                .aspectRatio(1, contentMode: .fit)
            if isRoomba {
                Text(directionArrow)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
        }
    }

    private var directionArrow: String {
        switch viewModel.roomba.direction {
        case .north: return "↑"
        case .east: return "→"
        case .south: return "↓"
        case .west: return "←"
        }
    }

    private var directionName: String {
        switch viewModel.roomba.direction {
        case .north: return "North"
        case .east: return "East"
        case .south: return "South"
        case .west: return "West"
        }
    }
}

#Preview {
    ContentView()
}
