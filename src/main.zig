const std = @import("std");
const game = @import("game");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    
    const allocator = arena.allocator();
    
    var g = try game.getGame(allocator);
    defer g.deinit();

    try g.start();
}