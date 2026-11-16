:- module(cases, [title/1, case/3]).
:- use_module('../prolog/misconceptions').
:- use_module(engine).
title('misconceptions').
prob_g(T-B) :- rnd_int(10, 99, T), rnd_int(10, T, B).
case(solve, [P, T, B], solve) :- procedure(P0), !, findall(X, procedure(X), Ps), rnd_pick(Ps, P), ( P0 == P -> true ; true ), prob_g(T-B).
case(diagnose, [As], diagnose) :- findall(X, procedure(X), Ps), rnd_pick(Ps, P), rnd_int(1, 3, K), length(As, K), maplist([T-B-C]>>( prob_g(T-B), solve(P, T, B, C) ), As).
case(diagnose_mixed, [As], diagnose) :- rnd_int(1, 3, K), length(As, K), maplist([T-B-C]>>( prob_g(T-B), findall(X, procedure(X), Ps), rnd_pick(Ps, P), solve(P, T, B, C) ), As).
