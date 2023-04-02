const std = @import("std");
const hangman = @import("./hangman.zig");

pub fn displayWelcomeMessage() void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("Welcome to Hangman!\n", .{}) catch unreachable;
}

pub fn displayChancesLeft(chancesLeft: usize) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("You have {d} chances left\n", .{chancesLeft}) catch unreachable;
}

pub fn displayGuesses(guesses: []u8) void {
    const stdout = std.io.getStdOut().writer();
    if (guesses.len == 0) {
        stdout.print("You have not guessed any letters yet\n", .{}) catch unreachable;
        return;
    }
    stdout.print("You have guessed: ", .{}) catch unreachable;
    for (guesses) |guess| {
        if (guess != 0) {
            stdout.print("{c} ", .{guess}) catch unreachable;
        }
    }
    stdout.print("\n", .{}) catch unreachable;
}

pub fn hasChar(word: []const u8, guess: u8) bool {
    for (word) |letter| {
        if (letter == guess) {
            return true;
        }
    }
    return false;
}

pub fn displayWord(word: []const u8, guesses: []u8) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("The word is: ", .{}) catch unreachable;
    for (word) |letter| {
        if (hasChar(guesses, letter)) {
            stdout.print("{c}", .{letter}) catch unreachable;
        } else {
            stdout.print("_", .{}) catch unreachable;
        }
    }
    stdout.print("\n", .{}) catch unreachable;
}

pub fn displayPrompt() void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("Guess a letter: ", .{}) catch unreachable;
}

pub fn displayMessage(msg: []const u8) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("{s}\n", .{msg}) catch unreachable;
}

pub fn displayAlreadyGuessed(guess: u8) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("You have already guessed {c}!\n", .{guess}) catch unreachable;
}

pub fn displayFrame(frameNo: usize) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("{s}", .{hangman.hangmanFrames[frameNo]}) catch unreachable;
}

pub fn displayLost(word : [] const u8) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("You lost! The word was {s}!\n", .{word}) catch unreachable;
}

pub fn getGuess() !u8 {
    const stdin = std.io.getStdIn().reader();
    var buf: [1]u8 = undefined;
    const l = try stdin.readAtLeast(&buf, 1);
    if (l == 0) {
        return ' ';
    }
    try stdin.skipUntilDelimiterOrEof('\n');
    return buf[0];
}