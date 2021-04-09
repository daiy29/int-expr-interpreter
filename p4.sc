  import scala.math

  sealed trait MixedExpr
  case class Const(value:Int) extends MixedExpr
  case class Neg(value: MixedExpr) extends MixedExpr
  case class Abs(value: MixedExpr) extends MixedExpr
  case class Plus(value: MixedExpr, value2: MixedExpr) extends MixedExpr
  case class Minus(value: MixedExpr, value2: MixedExpr) extends MixedExpr
  case class Times(value: MixedExpr, value2: MixedExpr) extends MixedExpr
  case class Exp(value: MixedExpr, value2: MixedExpr) extends MixedExpr 
  case object TT extends MixedExpr
  case object FF extends MixedExpr
  case class Bnot(value: MixedExpr) extends MixedExpr
  case class Band(value: MixedExpr, value2: MixedExpr) extends MixedExpr
  case class Bor(value: MixedExpr, value2: MixedExpr) extends MixedExpr

  def interpretIntExpr(expr : MixedExpr) : Int = expr match{
    case Const(x) => x
    case Neg(x) => interpretIntExpr(x) * -1
    case Abs(x) => interpretIntExpr(x).abs
    case Plus(x,y) => interpretIntExpr(x) + interpretIntExpr(y)
    case Minus(x,y) => interpretIntExpr(x) - interpretIntExpr(y)
    case Times(x,y) => interpretIntExpr(x) * interpretIntExpr(y)
    case Exp(x,y) => if (SubstM(y,symb,expr2) < 0){
                         throw new Exception("No negative Y input")
                               }
                     else{
                         math.pow(SubstM(x,symb,expr2),SubstM(y,symb,expr2)).toInt
                         } 
  }
    
  def interpretBoolExpr(expr : MixedExpr) : Boolean = expr match{
    case TT => true
    case FF => false
    case Bnot(x) => !(interpretBoolExpr(x))
    case Band(x,y) => (interpretBoolExpr(x) && interpretBoolExpr(y)) == true
    case Bor(x,y) => (interpretBoolExpr(x) || interpretBoolExpr(y)) == true
   
  }


  def interpretMixedExpr(expr : MixedExpr) : Option[Either[Int, Boolean]] = {
    try{
       expr match{
          case Const(x) => Some(Left(x))
          case Neg(x) => Some(Left(interpretIntExpr(x) * -1))
          case Abs(x) => Some(Left(interpretIntExpr(x).abs))
          case Plus(x,y) => Some(Left(interpretIntExpr(x) + interpretIntExpr(y)))
          case Minus(x,y) => Some(Left(interpretIntExpr(x) - interpretIntExpr(y)))
          case Times(x,y) => Some(Left(interpretIntExpr(x) * interpretIntExpr(y)))
          case Exp(x,y) => Some(Left(math.pow(interpretIntExpr(x),interpretIntExpr(y)).toInt)) //Do something about y < 0
          case TT => Some(Right(true))
          case FF => Some(Right(false))
          case Bnot(x) => Some(Right(!(interpretBoolExpr(x))))
          case Band(x,y) => Some(Right((interpretBoolExpr(x) && interpretBoolExpr(y)) == true))
          case Bor(x,y) => Some(Right((interpretBoolExpr(x) || interpretBoolExpr(y)) == true))
       }
       
    }
    catch{
      case e : Exception => None
    }

  }






        
