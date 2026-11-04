import Testing
@testable import RoombaChallenge

@MainActor
@Suite("RoombaViewModel")
struct RoombaViewModelTests {

    @Test func startsAtOriginFacingNorth() {
        let viewModel = RoombaViewModel()
        #expect(viewModel.position == Position(x: 0, y: 0))
        #expect(viewModel.direction == .north)
        #expect(viewModel.statusText == "(0, 0) · North")
    }

    @Test func moveForwardUpdatesPositionAndStatus() {
        let viewModel = RoombaViewModel()
        viewModel.moveForward()
        #expect(viewModel.position == Position(x: 0, y: 1))
        #expect(viewModel.statusText == "(0, 1) · North")
    }

    @Test func turnRightUpdatesDirectionAndStatus() {
        let viewModel = RoombaViewModel()
        viewModel.turnRight()
        #expect(viewModel.direction == .east)
        #expect(viewModel.position == Position(x: 0, y: 0))
        #expect(viewModel.statusText == "(0, 0) · East")
    }

    @Test func movingIntoWallTurnsRight() {
        let viewModel = RoombaViewModel(
            roomba: Roomba(start: Position(x: 0, y: 9), direction: .north)
        )
        viewModel.moveForward()
        #expect(viewModel.position == Position(x: 0, y: 9))
        #expect(viewModel.statusText == "(0, 9) · East")
    }

    @Test(arguments: [
        (Direction.north, "North"),
        (Direction.east, "East"),
        (Direction.south, "South"),
        (Direction.west, "West"),
    ])
    func directionNames(direction: Direction, expected: String) {
        #expect(direction.name == expected)
    }
}
