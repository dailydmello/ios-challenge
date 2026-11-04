import Observation

@MainActor
@Observable
final class RoombaViewModel {
    private(set) var roomba: Roomba

    init(roomba: Roomba = Roomba()) {
        self.roomba = roomba
    }

    var position: Position { roomba.position }
    var direction: Direction { roomba.direction }

    var statusText: String {
        "(\(position.x), \(position.y)) · \(direction.name)"
    }

    func moveForward() {
        roomba.moveForward()
    }

    func turnRight() {
        roomba.turnRight()
    }
}

extension Direction {
    var name: String {
        switch self {
        case .north: "North"
        case .east: "East"
        case .south: "South"
        case .west: "West"
        }
    }
}
