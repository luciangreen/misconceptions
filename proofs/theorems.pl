% Theorems, proved by exhaustion. Run: swipl -g main -t halt proofs/theorems.pl
:- module(theorems, [main/0]).
:- use_module(prove).
:- discontiguous theorem/1.
:- use_module(library(lists)).
:- use_module(library(apply)).
main :- prove_all(theorems).
:- use_module('../prolog/misconceptions').

% Domain: every two-digit subtraction with the top from 10..30 and the bottom from 10 up to the top.
problem(T-B) :- between(10, 30, T), between(10, T, B).

% 1. Each procedure explains its own answers: diagnosing a set of its answers always includes it.
theorem(procedures_explain_themselves) :- forall(( procedure(P), problem(T1-B1), T1 mod 7 =:= 0, problem(T2-B2), T2 mod 5 =:= 0 ), ( solve(P, T1, B1, C1), solve(P, T2, B2, C2), diagnose([T1-B1-C1, T2-B2-C2], D), memberchk(P, D) )).

% 2. Every procedure in a diagnosis really gives every answer.
theorem(diagnoses_are_consistent) :- forall(( procedure(P), problem(T-B), solve(P, T, B, C), diagnose([T-B-C], D), member(Q, D) ), solve(Q, T, B, C)).

% 3. Problems that need borrowing tell the misconceptions apart: on 52 - 18 each procedure gives a different answer.
theorem(borrowing_separates) :- findall(C, ( procedure(P), solve(P, 52, 18, C) ), Cs), sort(Cs, S), length(Cs, N), length(S, N).

% 4. With no borrowing needed, smaller_from_larger, borrow_no_decrement and zero_when_smaller all agree with correct.
theorem(no_borrow_no_difference) :- forall(( problem(T-B), T mod 10 >= B mod 10 ), forall(member(P, [smaller_from_larger, borrow_no_decrement, zero_when_smaller]), ( solve(P, T, B, C), solve(correct, T, B, C) ))).
