% Define valid moves
move([X,Y], [X1,Y]) :- X1 is X+1. % Defines a move to the right from cell [X,Y].
move([X,Y], [X,Y1]) :- Y1 is Y+1. % Defines a move downward from cell [X,Y].
move([X,Y], [X1,Y]) :- X1 is X-1, X1 >= 0. % Defines a move to the left from cell [X,Y], ensuring the new X coordinate is within the board boundaries.
move([X,Y], [X,Y1]) :- Y1 is Y-1, Y1 >= 0. % Defines a move upward from cell [X,Y], ensuring the new Y coordinate is within the board boundaries.

% Checks if a cell [X,Y] is valid on the board by ensuring its coordinates are within the board boundaries.
valid_cell([X,Y], Board) :-
    length(Board, NRows),
    length(Board, NCols),
    X >= 0, X <= NRows,
    Y >= 0, Y <= NCols.

% Depth-first search to find a color cycle starting from a given cell (Start) on the board.
% It explores neighboring cells with the same color recursively until it forms a cycle or exhausts all possible paths.
detect_cycles_dfs(Board, Start, Current, Visited, Color, Cycle) :-
    move(Current, Next),
    valid_cell(Next, Board),
    (
        Next == Start,
        length(Visited, Length),
        Length >= 4 ->
        reverse(Visited, Cycle),
        format("~w cycle found: ~w~n", [Color, Cycle])
    ;
        \+ member(Next, Visited),
        same_color(Start, Next, Board),
        detect_cycles_dfs(Board, Start, Next, [Next|Visited], Color, Cycle)
    ).

% DFS on each node to find all colored cycles
detect_cycles(Board) :-
    length(Board, NRows),
    nth0(0, Board, FirstRow),
    length(FirstRow, NCols),
    NRows1 is NRows - 1,
    NCols1 is NCols - 1,
    between(0, NRows1, X),
    between(0, NCols1, Y),
    cell_color(Board, [X, Y], Color),
    detect_cycles_dfs(Board, [X, Y], [X, Y], [[X, Y]], Color, _).
    fail. % Backtrack to find more cycles

detect_cycles(_) :-
    format("No cycles exist.~n").

% Predicate to get the color of a cell
cell_color(Board, [X,Y], Color) :-
    nth0(X, Board, Row),
    nth0(Y, Row, Color).

% Check if two cells have the same color
same_color([X1,Y1], [X2,Y2], Board) :-
    cell_color(Board,[X1,Y1] , C1),
    cell_color(Board,[X2,Y2] , C2),
    C1 == C2.
