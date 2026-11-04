import SwiftUI

struct ControlsView: View {
    let onForward: () -> Void
    let onTurnRight: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button("Move Forward", systemImage: "arrow.up", action: onForward)
                .buttonStyle(.borderedProminent)

            Button("Turn Right", systemImage: "arrow.clockwise", action: onTurnRight)
                .buttonStyle(.bordered)
        }
    }
}

#Preview {
    ControlsView(onForward: {}, onTurnRight: {})
        .padding()
}
