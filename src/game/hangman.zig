const hangman1 =
\\ +---+
\\ |   |
\\     |
\\     |
\\     |
\\     |
\\=========
\\
;

const hangman2 =
\\ +---+
\\ |   |
\\ O   |
\\     |
\\     |
\\     |
\\=========
\\
;

const hangman3 =
\\ +---+
\\ |   |
\\ O   |
\\ |   |
\\     |
\\     |
\\=========
\\
;

const hangman4 =
\\ +---+
\\ |   |
\\ O   |
\\/|   |
\\     |
\\     |
\\=========
\\
;

const hangman5 =
\\ +---+
\\ |   |
\\ O   |
\\/|\  |
\\     |
\\     |
\\=========
\\
;

const hangman6 =
\\ +---+
\\ |   |
\\ O   |
\\/|\  |
\\/    |
\\     |
\\=========
\\
;

const hangman7 =
\\ +---+
\\ |   |
\\ O   |
\\/|\  |
\\/ \  |
\\     |
\\=========
\\
;

pub const hangmanFrames = [_][]const u8{
    hangman1,
    hangman2,
    hangman3,
    hangman4,
    hangman5,
    hangman6,
    hangman7,
};