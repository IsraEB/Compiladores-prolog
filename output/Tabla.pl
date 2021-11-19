:- dynamic slr1/3.

slr1(0, t(x), shift(2)).
slr1(0, t(z), shift(4)).
slr1(2, t(y), shift(6)).
slr1(4, t(y), shift(6)).
slr1(5, t(z), shift(9)).
slr1(6, t(z), shift(4)).
slr1(8, t(z), shift(11)).
slr1(0, nt('S'), goto(1)).
slr1(0, nt('A'), goto(3)).
slr1(2, nt('B'), goto(5)).
slr1(4, nt('B'), goto(8)).
slr1(6, nt('A'), goto(10)).
slr1(1, fin, reduce(0)).
slr1(3, fin, reduce(2)).
slr1(7, t(z), reduce(4)).
slr1(9, fin, reduce(1)).
slr1(10, t(z), reduce(3)).
slr1(11, fin, reduce(5)).
slr1(11, t(z), reduce(5)).

