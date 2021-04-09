isExpr(constE(X)) :- 0 is X mod 1, !.  
isExpr(negE(X)) :- isExpr(X).
isExpr(absE(X)) :- isExpr(X).
isExpr(plusE(X,Y)) :- isExpr(X), isExpr(Y).
isExpr(minusE(X,Y)) :- isExpr(X), isExpr(Y).
isExpr(timesE(X,Y)) :- isExpr(X), isExpr(Y).
isExpr(expE(X,Y)) :- isExpr(X), isExpr(Y).

interpretExpr(constE(X), R) :- 0 is X mod 1, R is X.
interpretExpr(negE(X), R) :- interpretExpr(X,L), R is (L * (-1)).
interpretExpr(absE(X), R) :- interpretExpr(X,L), R is abs(L).
interpretExpr(plusE(X,Y), R) :- interpretExpr(X,L), interpretExpr(Y,L2), R is L + L2.
interpretExpr(minusE(X,Y), R) :- interpretExpr(X,L), interpretExpr(Y,L2), R is L - L2.
interpretExpr(timesE(X,Y), R) :- interpretExpr(X,L), interpretExpr(Y,L2), R is L * L2.
interpretExpr(expE(X,Y), R) :- interpretExpr(X,L), interpretExpr(Y,L2), L2 >= 0, R is L**L2.