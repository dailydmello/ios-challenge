import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Roomba")
                .font(.title.bold())
            GridView(position: Position(x: 0, y: 0), direction: .north)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
