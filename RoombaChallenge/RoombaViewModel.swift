import Combine
import Foundation

/// Wires the UI to the `Roomba` model. Already implemented —
/// the buttons below start working as soon as `Roomba` is solved.
@MainActor
final class RoombaViewModel: ObservableObject {
    @Published private(set) var roomba = Roomba()

    func moveForward() {
        roomba.moveForward()
    }

    func turnRight() {
        roomba.turnRight()
    }
}
