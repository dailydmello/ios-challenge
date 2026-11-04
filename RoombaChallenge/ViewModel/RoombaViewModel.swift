import Observation

@MainActor
@Observable
final class RoombaViewModel {
    private(set) var roomba: Roomba
    // Grows by 90 per right turn so the arrow always spins clockwise, never back.
    private(set) var headingDegrees: Double
    private(set) var wallHitCount = 0

    init(roomba: Roomba = Roomba()) {
        self.roomba = roomba
        self.headingDegrees = roomba.direction.degrees
    }

    var position: Position { roomba.position }
    var direction: Direction { roomba.direction }

    var statusText: String {
        "(\(position.x), \(position.y)) · \(direction.name)"
    }

    func moveForward() {
        let before = roomba.position
        roomba.moveForward()
        if roomba.position == before {
            wallHitCount += 1
            headingDegrees += 90
        }
    }

    func turnRight() {
        roomba.turnRight()
        headingDegrees += 90
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

    var degrees: Double {
        switch self {
        case .north: 0
        case .east: 90
        case .south: 180
        case .west: 270
        }
    }
}
