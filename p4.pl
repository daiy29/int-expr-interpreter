isMixedExpr(constE(X)) :- 0 is X mod 1, !.  
isMixedExpr(negE(X)) :- isMixedExpr(X).
isMixedExpr(absE(X)) :- isMixedExpr(X).
isMixedExpr(plusE(X,Y)) :- isMixedExpr(X), isMixedExpr(Y).
isMixedExpr(minusE(X,Y)) :- isMixedExpr(X), isMixedExpr(Y).
isMixedExpr(timesE(X,Y)) :- isMixedExpr(X), isMixedExpr(Y).
isMixedExpr(expE(X,Y)) :- isMixedExpr(X), isMixedExpr(Y).
isMixedExpr(tt) :- true.
isMixedExpr(ff) :- true.
isMixedExpr(bnotE(X)) :- isMixedExpr(X).
isMixedExpr(bandE(X,Y)) :- isMixedExpr(X), isMixedExpr(Y).
isMixedExpr(borE(X,Y)) :- isMixedExpr(X), isMixedExpr(Y).


interpretMixedExpr(constE(X), R) :- R is X.
interpretMixedExpr(negE(X), R) :- interpretMixedExpr(X,L), R is (L * (-1)).
interpretMixedExpr(absE(X), R) :- interpretMixedExpr(X,L), R is abs(L).
interpretMixedExpr(plusE(X,Y), R) :- interpretMixedExpr(X,L), interpretMixedExpr(Y,L2), R is L + L2.
interpretMixedExpr(minusE(X,Y), R) :- interpretMixedExpr(X,L), interpretMixedExpr(Y,L2), R is L - L2.
interpretMixedExpr(timesE(X,Y), R) :- interpretMixedExpr(X,L), interpretMixedExpr(Y,L2), R is L * L2.
interpretMixedExpr(expE(X,Y), R) :- interpretMixedExpr(X,L), interpretMixedExpr(Y,L2), R is L**L2.
interpretMixedExpr(tt, _) :- true.
interpretMixedExpr(ff, _) :- false.
interpretMixedExpr(bnotE(X), _) :- \+ interpretMixedExpr(X,_), !.
interpretMixedExpr(bandE(X,Y), _) :- interpretMixedExpr(X,_), interpretMixedExpr(Y,_),!.
interpretMixedExpr(borE(X,Y), _) :- interpretMixedExpr(X,_); interpretMixedExpr(Y,_),!.
