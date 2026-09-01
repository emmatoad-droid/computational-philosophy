% ============================================
% Computational Philosophy
% Reality → Observer → Belief → Tri-State → Revision
% ============================================

% ---- The world ----

person(aunty_dot).
person(david).
person(emma).

ghost(uncle_harry).

% ---- Initial beliefs ----

believes(aunty_dot, ghost(uncle_harry), true).
believes(david, ghost(uncle_harry), false).
believes(emma, ghost(uncle_harry), unknown).

% ---- New observations ----

observes(david, strange_smell).
observes(aunty_dot, strange_smell).
% emma does not observe it

% ---- Tri-state NAND (The Mathematical Engine) ----

nand(true,    true,    false).
nand(true,    false,   true).
nand(false,   true,    true).
nand(false,   false,   true).

% Unknown propagates uncertainty.
nand(unknown, _,        unknown).
nand(_,        unknown, unknown).

% ---- Dynamic Belief Revision ----

% Map physical observation to a boolean logic state
evidence(Person, true) :- observes(Person, strange_smell), !.
evidence(_, false). % Default if no observation is made

% Calculate the new belief using the NAND gate
calculate_revision(Person, NewState) :-
    believes(Person, ghost(uncle_harry), InitialState),
    evidence(Person, EvidenceState),
    nand(InitialState, EvidenceState, NewState).

% Execute and print the results of the calculation
revise(Person) :-
    believes(Person, ghost(uncle_harry), InitialState),
    calculate_revision(Person, NewState),
    InitialState \= NewState, % Only speak up if their mind changes!
    format("~w processed the evidence through NAND: ~w -> ~w~n", [Person, InitialState, NewState]).

% ---- Consensus ----

agrees(P1, P2) :-
    believes(P1, ghost(uncle_harry), State),
    believes(P2, ghost(uncle_harry), State).

disagrees(P1, P2) :-
    believes(P1, ghost(uncle_harry), S1),
    believes(P2, ghost(uncle_harry), S2),
    S1 \= S2.

% ---- The ASCII Owl Engine ----
%
%  ,__,
%  (O,O)    <- The eyes are the ':'
%  /))      <- The beak is the '-'
% ""  ""

% If the state is true: The owl is wide awake!
draw_owl(true) :-
    write('    ,__,'), nl,
    write('    (O,O)  <- "Hoot! The truth is out there!"'), nl,
    write('    /))'), nl,
    write('   ""  ""'), nl.

% If the state is false: The owl is sleeping/skeptical.
draw_owl(false) :-
    write('    ,__,'), nl,
    write('    (-,-)  <- "Hoot... I do not buy it."'), nl,
    write('    /))'), nl,
    write('   ""  ""'), nl.

% If the state is unknown: The owl is winking/confused!
draw_owl(unknown) :-
    write('    ,__,'), nl,
    write('    (O,-)  <- "Hoot? Who knows?"'), nl,
    write('    /))'), nl,
    write('   ""  ""'), nl.

% Driver to make a specific person's inner owl speak
hoot(Person) :-
    believes(Person, ghost(uncle_harry), State),
    format("~w's Inner Owl state (~w):~n", [Person, State]),
    draw_owl(State),
    nl.

% ---- The driver ----

run_revisions :-
    write('--- MATHEMATICAL REVISIONS ---'), nl,
    forall(person(P), (revise(P) ; true)),
    nl.

run_consensus :-
    write('--- INITIAL CONSENSUS ---'), nl,
    forall(
        ( person(P1), person(P2), P1 @< P2 ),
        ( ( agrees(P1, P2)
          -> format("~w agrees with ~w~n", [P1, P2])
          ;  disagrees(P1, P2)
          -> format("~w disagrees with ~w~n", [P1, P2])
          ;  format("~w and ~w: unresolved~n", [P1, P2])
          )
        )
    ),
    nl.

run_owls :-
    write('--- INNER OWLS ---'), nl,
    forall(person(P), hoot(P)),
    nl.

main :-
    run_consensus,
    run_revisions,
    run_owls.

:- initialization(main).
