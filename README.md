### Overview

There are 3 prolog files, and 3 scala files.

### Part 1 Scala Code

The language consists of integer constants and seven prefix operators.

![Scala code](https://i.gyazo.com/31f0be64e522d946fdf11e22cb200269.png)

The unary operator const which operates on integers.
The unary operators neg (negative) and abs (absolute value) which operate on expressions of this language.
The binary operators plus, times, minus and exp (exponent) which operator on expressions of this language.

![Second](https://i.gyazo.com/bc6ba875f45e47fd91ff63fea7aec59a.png)

The second half of this program calculates the value of the mathematical expression by recursively calling itself. Since the function should only output integers, an exception is throw in the case of a negative power (y) called in the Exp(x,y) function

### Part 2 Prolog Code

The purpose of this portion of this identical to Part 1, with the exception that it is programmed in Prolog. An additional feature it will include, is a method to determine whether an inputted expression is valid. This is done by setting base cases of const,neg,abs as valid, and recursively calling isExpr on each argument for each argument in the binary operators.

![](https://gyazo.com/ed0df5b6c2c5ceb4ae8f6246eccab7f0.png)

The second part is completely identical in purpose to the first part done in scala. However, instead of throwing an exception as in part 1, the input is only considered valid and will be computed if the L2 argument, which represents the Y in pow(x,y), is greater than or equal to zero. This ensures that the outputted result will be an integer.

![](https://gyazo.com/482cb45b3d9acdab508eed72b82b526b.png)

### Part 3 Scala Code

In this part, we wish to add variables to our expressions. This can be done by adding a new operator var to our expressions. However, adding this operator introduces a problem with our interpretExpr method/predicate: we fix this by introducing a substitution operator which takes three arguments as stated in the requirements:

an expression to perform the substitution on,
the variable to be substituted, and
the expression to substitute for the variable.

The language consists of the same seven prefix operators from part 1, but as can be seen also includes Var and Subst.

![](https://gyazo.com/4ca6baa1cd2cd34babd74bebee2da0ca.png)

The second half of this program also calculates the value of the mathematical expression by recursively calling itself. Since the function should only output integers, an exception is throw in the case of a negative power (y) called in the Exp(x,y) function, as in part 1. A variable is given the default value of 0 if it is not instantiated, and the Subst(x,y,z) is performed by recursively calling a helper function.

![](https://gyazo.com/4c778ea108378fcd13a16991c891979e.png)

SubstM will recursively call itself to simplify the given expression, and substitute the variable at the end. In the case of substitutions of substitutions, another helper function is recursively called. This simply outputs the function so that the default value of 0 on variables is not realized.

![](https://gyazo.com/3813fed13cdafebe7b7ac8ce4e33a241.png)

### Part 3 Prolog Code

The prolog section of part 3 serves the same purpose as part 2 to part 1. The first half checks whether the inputted expression is valid

![](https://gyazo.com/1580db87c6de59ec6be4a19c20606cf3.png)

The second part calculates the value of an expression again by recursively calling itself. Each call of substitution is called using the expression to be substituted on as an argument.

![](https://gyazo.com/ce667f215e0cb722d8d5b67d0a1306bc.png)

A helper function is defined to "simplify" an expression in the case where multiple substitutions must be performed. This prevents the default value of 0 for a variable to be instantiated, leading to incorrect calculations. This does not directly compute the integer result of the expression, but simply performs the substitution inputted.

![](https://gyazo.com/910e67a541ba744ef1a3db120dff779f.png)

### Part 4 Scala Code

On this part, we create an alternate extension to our first language of expressions, which accepts expressions containing booleans. The new operators are the 0-ary tt and ff (0-ary meaning taking no arguments), the unary bnot and the binary band and bor. The restriction is that boolean expressions and integer expressions can not be mixed, we prevent this using an Option wrapper. The language consists of the same seven prefix operators from part 1, but as can be seen also includes bnot, band, tt, ff, bor.

![](https://gyazo.com/c87f3a7734d772c652ff8210fc4f2682.png)

Due to different return types, the interpreters for integer expressions and boolean expressions are separate. The integer interpreter is unchanged from part 1, but as can be seen the boolean interpreter evaluates TT, FF, Bnot, Band, and Bor by recursively pattern matching and calling itself.

![](https://gyazo.com/e9b64cca7faeb1835c15686037633440.png)

Finally, the mixed interpreter combines the integer and boolean interpreter by allowing either and Integer or Boolean output using the Either wrapper. It also prevents mixed expressions with the Option wrapped. Left(argument) will be used to represent Integers, and Right(argument) will be used to represent booleans. Some is used by option to represent valid non-mixed expressions, whereas None will be outputted for invalid expressions.

![](https://gyazo.com/5b1c66c23dbeb7e2c42e9fed2ce82954.png)

### Part 4 Prolog Code

The prolog section of part 4 serves the same purpose as the prolog portion of part 4. The first half checks whether the inputted expression is valid, and the second half evalutes the expression.

![](https://gyazo.com/0f0960381a57111d5a111863947eba55.png)

The second part calculates the value of an expression again by recursively calling itself. For the case of interpreting boolean expressions, I decided to use the built-in functions provided by Prolog instead of defining my own true and false types. the \\+ operator is built in negation, which we represent as bnotE, and "," can be used as a representation of and, and ";" be used as an interpretation of or.

![](https://gyazo.com/dd33fe5194c13e88fb409fb72a64d42b.png)
