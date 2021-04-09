isVarExpr(constE(X)) :- 0 is X mod 1, !.  
isVarExpr(negE(X)) :- isVarExpr(X).
isVarExpr(absE(X)) :- isVarExpr(X).
isVarExpr(var(X)) :- isVarExpr(X).
isVarExpr(plusE(X,Y)) :- isVarExpr(X), isVarExpr(Y).
isVarExpr(minusE(X,Y)) :- isVarExpr(X), isVarExpr(Y).
isVarExpr(timesE(X,Y)) :- isVarExpr(X), isVarExpr(Y).
isVarExpr(expE(X,Y)) :- isVarExpr(X), isVarExpr(Y).
isVarExpr(subst(X,Y,Z)) :- isVarExpr(X), isVarExpr(Z), atom(Y). 

interpretVarExpr(constE(X), R) :- R is X.
interpretVarExpr(negE(X), R) :- interpretVarExpr(X,L), R is (L * (-1)).
interpretVarExpr(absE(X), R) :- interpretVarExpr(X,L), R is abs(L).
interpretVarExpr(var(_), R) :- R is 0.
interpretVarExpr(plusE(X,Y), R) :- interpretVarExpr(X,L), interpretVarExpr(Y,L2), R is L + L2.
interpretVarExpr(minusE(X,Y), R) :- interpretVarExpr(X,L), interpretVarExpr(Y,L2), R is L - L2.
interpretVarExpr(timesE(X,Y), R) :- interpretVarExpr(X,L), interpretVarExpr(Y,L2), R is L * L2.
interpretVarExpr(expE(X,Y), R) :- interpretVarExpr(X,L), interpretVarExpr(Y,L2), R is L**L2.

interpretVarExpr(subst(constE(X),_,_),R) :- R is X.
interpretVarExpr(subst(var(X),Y, Z),R) :- X = Y, interpretVarExpr(Z,R1), R is R1.
interpretVarExpr(subst(var(X),Y, _),R) :- X \= Y, R is 0.
interpretVarExpr(subst(absE(X),Y,Z),R) :- interpretVarExpr(subst(X,Y,Z),R1), R is abs(R1).
interpretVarExpr(subst(negE(X),Y,Z),R) :- interpretVarExpr(subst(X,Y,Z),R1), R is (R1 * (-1)).
interpretVarExpr(subst(plusE(X1,X2),Y,Z),R) :- interpretVarExpr(subst(X1,Y,Z),R1), interpretVarExpr(subst(X2,Y,Z),R2), R is R1 + R2.
interpretVarExpr(subst(minusE(X1,X2),Y,Z),R) :- interpretVarExpr(subst(X1,Y,Z),R1), interpretVarExpr(subst(X2,Y,Z),R2), R is R1 - R2.
interpretVarExpr(subst(timesE(X1,X2),Y,Z),R) :- interpretVarExpr(subst(X1,Y,Z),R1), interpretVarExpr(subst(X2,Y,Z),R2), R is R1 * R2.
interpretVarExpr(subst(expE(X1,X2),Y,Z),R) :- interpretVarExpr(subst(X1,Y,Z),R1), interpretVarExpr(subst(X2,Y,Z),R2), R is R1 ** R2.
interpretVarExpr(subst(subst(X1,X2,X3),Y,Z),R) :- substHelper(X1,X2,X3,X4), interpretVarExpr(subst(X4,Y,Z),R).


substHelper(constE(X),_,_,R) :- R = constE(X).
substHelper(var(X),Y,Z,R) :- X == Y, R = Z. %substHelper(var(x),x,constE(5),R)
substHelper(var(X),Y,_,R) :- X \== Y, R = var(X). %substHelper(var(x),x,constE(5),R)
substHelper(negE(X),Y,Z,R) :- substHelper(X,Y,Z,R1), R=negE(R1). % substHelper(absE(var(x)),x,constE(5),R)
substHelper(absE(X),Y,Z,R) :- substHelper(X,Y,Z,R1), R=absE(R1).
substHelper(plusE(X1,X2),Y,Z,R) :- substHelper(X1,Y,Z,R1), substHelper(X2,Y,Z,R2), R=plusE(R1,R2). % substHelper(plusE(var(x),var(y)),x,constE(5),R)
substHelper(timesE(X1,X2),Y,Z,R) :- substHelper(X1,Y,Z,R1), substHelper(X2,Y,Z,R2), R=timesE(R1,R2).
substHelper(expE(X1,X2),Y,Z,R) :- substHelper(X1,Y,Z,R1), substHelper(X2,Y,Z,R2), R=expE(R1,R2).
substHelper(subst(X1,X2,X3),Y,Z,R) :- substHelper(X1,X2,X3,X4), substHelper(X4,Y,Z,R).




