import Foundation

/// The four directions the roomba can face.
/// Turning right cycles: north → east → south → west → north.
enum Direction {
    case north, east, south, west
}

/// A cell on the 10×10 grid.
/// x runs 0 (left) → 9 (right), y runs 0 (bottom) → 9 (top).
struct Position: Equatable {
    var x: Int
    var y: Int
}

/// The roomba model: position + facing direction on a 10×10 grid.
///
/// THE CHALLENGE — implement `turnRight()` and `moveForward()` so that
/// `RoombaTests` pass. Rules:
///
/// - The roomba starts at (0, 0) facing north (the defaults below).
/// - `turnRight()` rotates the roomba 90° clockwise in place.
/// - `moveForward()` moves one cell in the facing direction
///   (north = y+1, east = x+1, south = y−1, west = x−1).
/// - The grid boundary is a wall: if the cell ahead is outside the grid,
///   the roomba does NOT move — it turns right instead (one 90° turn).
struct Roomba {
    static let gridSize = 10

    private(set) var position: Position
    private(set) var direction: Direction

    init(start: Position = Position(x: 0, y: 0), direction: Direction = .north) {
        self.position = start
        self.direction = direction
    }

    /// Rotate 90° clockwise: north → east → south → west → north.
    mutating func turnRight() {
        // TODO: implement
    }

    /// Move one cell forward. If a wall is ahead (the next cell would be
    /// outside the grid), turn right instead of moving.
    mutating func moveForward() {
        // TODO: implement
    }
}
