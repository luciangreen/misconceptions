# misconceptions

work out the buggy procedure that explains a student's wrong answers. Each known misconception for two-digit column subtraction is written as a procedure; a student's answers are explained by the procedures that give every one of them. The correct procedure is one of them, so right answers are explained too.

## Use

```prolog
?- use_module(prolog/misconceptions).
?- solve(correct, 52, 17, A).                   % A = 35
?- solve(smaller_from_larger, 52, 17, A).       % A = 45: takes 2 from 7 instead of borrowing
?- diagnose([52-17-45, 61-28-47], D).            % D = [smaller_from_larger]
```

## Proofs

`proofs/theorems.pl` proves 4 theorems by exhaustion: each one is checked for every case in a finite domain that covers every branch of the definitions. every two-digit subtraction with the top from 10..30 and the bottom from 10 up to the top.

1. Each procedure explains its own answers: diagnosing a set of its answers always includes it.
2. Every procedure in a diagnosis really gives every answer.
3. Problems that need borrowing tell the misconceptions apart: on 52 - 17 each procedure gives a different answer.
4. With no borrowing needed, smaller_from_larger, borrow_no_decrement and zero_when_smaller all agree with correct.

```sh
swipl -g main -t halt proofs/theorems.pl
```

## 200 inputs and outputs

`io/ios.txt` lists 200 inputs and outputs from real runs, and `io/ios.pl` has the same as Prolog facts. The inputs come from a fixed seed (`io/cases.pl`). `swipl -g check -t halt io/run.pl` runs them again. It fails if any output changes, or if a predicate doesn't confirm its own recorded output, which checks steadfastness. GitHub Actions runs the proofs and the examples on every push, and records the examples on the first push.

Licence: BSD-3-Clause.
