# Roomba — iOS Pair Programming Challenge

An iOS (SwiftUI) version of the pair programming task described in
[daynamic/ShopifyPairProgramming](https://github.com/daynamic/ShopifyPairProgramming),
a candidate-posted repo described there as *"a representation of a Pair programming
task given in an interview with Shopify."* That source is a single candidate's
Android/Kotlin recreation, so treat this as a faithful practice version of the
task — not Shopify's verbatim brief.

## The task

Create a single-screen app that allows the user to move a "roomba" around a
**10×10 grid**.

- Movement is restricted to **two buttons**: one to **move forward**, and one to
  **turn right**.
- Your representation of the roomba on the grid must **indicate the direction**
  the roomba is currently facing.
- The roomba **cannot pass through walls**; if it hits a wall, it should
  **automatically turn right instead of moving forward**.

### Conventions for this version (so the tests are unambiguous)

- Coordinates: `x` runs 0 (left) → 9 (right), `y` runs 0 (bottom) → 9 (top).
- The roomba starts at **(0, 0)** facing **north**.
- "Forward" moves one cell in the facing direction: north = y+1, east = x+1,
  south = y−1, west = x−1.
- The grid boundary is the wall. If the cell ahead is outside the grid, the
  roomba stays in place and turns right (exactly one 90° turn).

## What's in the repo

```
RoombaChallenge.xcodeproj
RoombaChallenge/
  RoombaChallengeApp.swift   – app entry point
  ContentView.swift          – an empty screen. Build everything from here.
RoombaChallengeTests/        – empty unit test target. Write your own tests.
```

You build the model, the UI, and the tests from scratch. A suggested split is a
`Roomba` model (position, direction, movement rules) apart from the SwiftUI view,
with unit tests that cover the model.

## Getting started

```bash
git clone https://github.com/dailydmello/ios-challenge.git
cd ios-challenge
open RoombaChallenge.xcodeproj
```

1. Run the app. You see one line of text: "Roomba".
2. Build the grid, the roomba, the direction indicator, and the two buttons.
3. Write unit tests for the rules above. Make them pass.

## Practice it like the real thing (suggested)

- Timebox yourself to **75 minutes**, narrate your reasoning out loud, and use
  your normal AI tools the way you would in the interview — you direct, you
  verify, you clean up.
- Get a running core first, then extend. Don't gold-plate the first pass.

## Follow-up extensions (what an interviewer might layer on next)

Try these only after the base task and tests pass:

1. **Interior obstacles** — add wall cells inside the grid; the same
   auto-turn-right rule applies when the cell ahead is a wall cell.
2. **Multiple roombas** — a second roomba on the grid; define and test what
   happens when one would move into the other's cell.
3. **Configurable grid** — grid size is no longer hard-coded to 10×10.
4. **Turn left + undo** — add both without breaking the two-button base spec
   in the model layer.
5. **Command sequences** — run a string of commands (e.g. `FFRFF`) and show
   the end state; test it.
6. **UI tests** — mirror the Android source's `RoombaScreenTest`: launch the
   app, verify the initial state, tap the buttons, verify the roomba moved /
   turned.
