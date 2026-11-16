% misconceptions: work out the buggy procedure that explains a student's wrong answers. Each
% known misconception for two-digit column subtraction is written as a procedure; a student's
% answers are explained by the procedures that give every one of them. The correct procedure is
% one of them, so right answers are explained too.
%?- solve(correct, 52, 17, A).                   % A = 35
%?- solve(smaller_from_larger, 52, 17, A).       % A = 45: takes 2 from 7 instead of borrowing
%?- diagnose([52-17-45, 61-28-47], D).            % D = [smaller_from_larger]
:- module(misconceptions, [procedure/1, solve/4, diagnose/2]).
:- use_module(library(lists)).
:- use_module(library(apply)).

procedure(P) :- member(P, [correct, smaller_from_larger, borrow_no_decrement, add_instead, zero_when_smaller]).

digits(N, T, U) :- T is N // 10, U is N mod 10.

% solve(+Procedure, +Top, +Bottom, -Answer) for two-digit numbers, Top >= Bottom.
solve(correct, A, B, C) :- C is A - B.
solve(smaller_from_larger, A, B, C) :- digits(A, At, Au), digits(B, Bt, Bu), U is abs(Au - Bu), T is abs(At - Bt), C is 10 * T + U.
solve(borrow_no_decrement, A, B, C) :- digits(A, At, Au), digits(B, Bt, Bu), ( Au >= Bu -> U is Au - Bu ; U is Au + 10 - Bu ), T is At - Bt, C is 10 * T + U.
solve(add_instead, A, B, C) :- C is A + B.
solve(zero_when_smaller, A, B, C) :- digits(A, At, Au), digits(B, Bt, Bu), ( Au >= Bu -> U is Au - Bu ; U = 0 ), T is At - Bt, C is 10 * T + U.

% diagnose(+Answers, -Procedures): Answers are Top-Bottom-Answer; the procedures that give all of them.
diagnose(As, Ps) :- findall(P, ( procedure(P), forall(member(T-B-C, As), solve(P, T, B, C)) ), Ps).
