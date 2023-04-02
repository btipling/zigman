const std = @import("std");
const words = @import("./words.zig");
const hangman = @import("./hangman.zig");
const ui = @import("./ui.zig");

const numChances = hangman.hangmanFrames.len - 1;

const Game = struct {
    word: []const u8,
    guesses: std.ArrayList(u8),

    pub fn deinit(_: *Game) void {
        // no need to denit as using single allocator!
    }

    pub fn won(self: *Game) bool {
        for (self.word) |c| {
            if (!self.hasGuessed(c)) {
                return false;
            }
        }
        return true;
    }

    pub fn hasGuessed(self: *Game, guess: u8) bool {
        for (self.guesses.items) |c| {
            if (c == guess) {
                return true;
            }
        }
        return false;
    }

    pub fn checkGuess(self: *Game, guess: u8) bool {
        for (self.word) |c| {
            if (c == guess) {
                return true;
            }
        }
        return false;
    }

    pub fn start(self: *Game) !void {
        var chances = numChances;
        var hasWon = false;
        ui.displayWelcomeMessage();
        while (chances > 0) {
            ui.displayChancesLeft(chances);
            ui.displayGuesses(self.guesses.items);
            ui.displayWord(self.word[0..], self.guesses.items);
            ui.displayPrompt();
            const guess = try ui.getGuess();
            if (self.hasGuessed(guess)) {
                ui.displayAlreadyGuessed(guess);
                continue;
            }
            try self.guesses.append(guess);
            if (self.checkGuess(guess)) {
                ui.displayMessage("Correct!");
                if (self.won()) {
                    ui.displayMessage("You won!");
                    hasWon = true;
                    break;
                }
            } else {
                ui.displayMessage("Incorrect!");
                chances -= 1;
                ui.displayFrame(numChances - chances);
            }
        }
        if (!hasWon) {
            ui.displayLost(self.word);
        }
    }

};

pub fn getGame(allocator: std.mem.Allocator) !*Game {
    var guesses = std.ArrayList(u8).init(allocator);
    try guesses.ensureTotalCapacityPrecise(numChances);
    var i = try getRandomNum(words.animals.len-1);
    const gameWord = words.animals[i];
    var g = try allocator.create(Game);
    g.word = gameWord;
    g.guesses = guesses;
    return g;
}

pub fn getRandomNum(max: u32) !u32 {
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();
    return rand.uintAtMost(u32, max);
}
