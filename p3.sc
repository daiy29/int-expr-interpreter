  import scala.math

  sealed trait VarExpr
  case class Const(value:Int) extends VarExpr
  case class Var(variable: Symbol) extends VarExpr
  case class Neg(value: VarExpr) extends VarExpr
  case class Abs(value: VarExpr) extends VarExpr
  case class Plus(value: VarExpr, value2: VarExpr) extends VarExpr
  case class Minus(value: VarExpr, value2: VarExpr) extends VarExpr 
  case class Times(value: VarExpr, value2: VarExpr) extends VarExpr 
  case class Exp(value: VarExpr, value2: VarExpr) extends VarExpr 
  case class Subst(expr1: VarExpr, symb: Symbol, expr2: VarExpr) extends VarExpr

  
  def interpretVarExpr(expr : VarExpr) : Int = expr match{
    case Const(x) => x
    case Var(x) => 0
    case Neg(x) => interpretVarExpr(x) * -1
    case Abs(x) => interpretVarExpr(x).abs
    case Plus(x,y) => interpretVarExpr(x) + interpretVarExpr(y)
    case Minus(x,y) => interpretVarExpr(x) - interpretVarExpr(y)
    case Times(x,y) => interpretVarExpr(x) * interpretVarExpr(y)
    case Exp(x,y) => if (interpretVarExpr(y) < 0){
                         throw new Exception("No negative Y input")
                               }
                     else{
                         math.pow(interpretVarExpr(x),interpretVarExpr(y)).toInt
                         }
    case Subst(x,y,z) => SubstM(x,y,z)
  }

  def SubstM(expr: VarExpr, symb: Symbol, expr2: VarExpr) : Int = expr match{
    case Const(x) =>  interpretVarExpr(expr)
    case Var(x) if x.toString == symb.toString => interpretVarExpr(expr2) //2nd and 3rd arguments are temp just so the method can be called
    case Var(x) if x.toString != symb.toString => interpretVarExpr(expr)
    case Neg(x) => (-1) * SubstM(x, symb, expr2) // call and modify function until it becomes a case of Var(x), dont try to solve it here by itself - recurse
    case Abs(x) => SubstM(x, symb, expr2).abs //this doesnt work IMPORTANT
    case Plus(x,y) => SubstM(x,symb,expr2) + SubstM(y,symb,expr2) 
    case Minus(x,y) => SubstM(x,symb,expr2) - SubstM(y,symb,expr2)
    case Times(x,y) => SubstM(x,symb,expr2) * SubstM(y,symb,expr2)
    case Exp(x,y) =>if (SubstM(y,symb,expr2) < 0){
                         throw new Exception("No negative Y input")
                               }
                     else{
                         math.pow(SubstM(x,symb,expr2),SubstM(y,symb,expr2)).toInt
                         } 
    case Subst(x,y,z) => SubstM(SubstHelper(x,y,z),symb,expr2)
                         
  }

  def SubstHelper(expr: VarExpr, symb: Symbol, expr2: VarExpr) : VarExpr = expr match{
    case Const(x) =>  Const(x)
    case Var(x) => if (x.toString == symb.toString) {
                    expr2
    }
    else{
      Var(x)
    }
    case Neg(x) => Neg(SubstHelper(x,symb,expr2))
    case Abs(x) => Abs(SubstHelper(x,symb,expr2))
    case Plus(x,y) => Plus(SubstHelper(x,symb,expr2),SubstHelper(y,symb,expr2))
    case Minus(x,y) => Minus(SubstHelper(x,symb,expr2),SubstHelper(y,symb,expr2))
    case Times(x,y) => Times(SubstHelper(x,symb,expr2),SubstHelper(y,symb,expr2))
    case Exp(x,y) => Exp(SubstHelper(x,symb,expr2),SubstHelper(y,symb,expr2))
    case Subst(x,y,z) => Subst(SubstHelper(x,y,z),symb, expr2)
  }


  



        
