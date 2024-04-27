% Define valid moves
move([X,Y], [X1,Y]) :- X1 is X+1. % Defines a move to the right from cell [X,Y].
move([X,Y], [X,Y1]) :- Y1 is Y+1. % Defines a move downward from cell [X,Y].
move([X,Y], [X1,Y]) :- X1 is X-1, X1 >= 0. % Defines a move to the left from cell [X,Y], ensuring the new X coordinate is within the board boundaries.
move([X,Y], [X,Y1]) :- Y1 is Y-1, Y1 >= 0. % Defines a move upward from cell [X,Y], ensuring the new Y coordinate is within the board boundaries.

% Checks if a cell [X,Y] is valid on the board by ensuring its coordinates are within the board boundaries.
valid_cell([X,Y], Board) :-
    length(Board, NRows),
    length(Board, NCols),
    X >= 0, X =< NRows,
    Y >= 0, Y =< NCols,
    nth0(X, Board, Row),
    nth0(Y, Row,_).

% Depth-first search to find a color cycle starting from a given cell (Start) on the board.
% It explores neighboring cells with the same color recursively until it forms a cycle or exhausts all possible paths.
detect_cycles_dfs(Board, Start, Current, Visited, Color, Cycle) :-
    move(Current, Next),
    valid_cell(Next, Board),
    (   Next == Start,
        length(Visited, Length),
        Length >= 4 ->
        reverse(Visited, Cycle)
    ;
        \+ member(Next, Visited),
        same_color(Start, Next, Board),
        detect_cycles_dfs(Board, Start, Next, [Next|Visited], Color, Cycle)
    ).

% DFS on each node to find all colored cycles
detect_cycles(Board, Cycle, Color) :-
    length(Board, NRows),
    nth0(0, Board, FirstRow),
    length(FirstRow, NCols),
    NRows1 is NRows - 1,
    NCols1 is NCols - 1,
    between(0, NRows1, X),
    between(0, NCols1, Y),
    Start = [X, Y],
    cell_color(Board, Start, Color),
    detect_cycles_dfs(Board, Start, Start, [Start], Color, Cycle).
    

% Predicate to get the color of a cell
cell_color(Board, [X,Y], Color) :-
    nth0(X, Board, Row),
    nth0(Y, Row, Color).

% Check if two cells have the same color
same_color([X1,Y1], [X2,Y2], Board) :-
    nth0(X1, Board, Row1),
    nth0(Y1, Row1, C1),
    nth0(X2, Board, Row2),
    nth0(Y2, Row2, C2),
    C1 == C2.