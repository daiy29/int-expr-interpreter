   import scala.math

  sealed trait Expr
  case class Const(value: Int) extends Expr
  case class Neg(value: Expr) extends Expr
  case class Abs(value: Expr) extends Expr
  case class Plus(value: Expr, value2: Expr) extends Expr
  case class Minus(value: Expr, value2: Expr) extends Expr 
  case class Times(value: Expr, value2: Expr) extends Expr 
  case class Exp(value: Expr, value2: Expr) extends Expr 

  
  def interpretExpr(expr : Expr) : Int = expr match{
    case Const(x) => x
    case Neg(x) => interpretExpr(x) * -1
    case Abs(x) => interpretExpr(x).abs
    case Plus(x,y) => interpretExpr(x) + interpretExpr(y)
    case Minus(x,y) => interpretExpr(x) - interpretExpr(y)
    case Times(x,y) => interpretExpr(x) * interpretExpr(y)
    case Exp(x,y) => if (interpretExpr(y) < 0){
                         throw new Exception("No negative Y input")
                               }
                     else{
                         math.pow(interpretExpr(x),interpretExpr(y)).toInt
                         }
  }
