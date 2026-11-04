import SwiftUI

struct ContentView: View {
    @State private var viewModel = RoombaViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Roomba")
                .font(.title.bold())

            GridView(position: viewModel.position, direction: viewModel.direction)

            Text(viewModel.statusText)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            ControlsView(
                onForward: viewModel.moveForward,
                onTurnRight: viewModel.turnRight
            )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
