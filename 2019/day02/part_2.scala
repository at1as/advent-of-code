import scala.tools.nsc.io.File
import scala.util.Try

object MyApp extends App {

  def fail(msg: String) = { println(s"[ERROR] $msg")   ; sys.exit }
  def pass(msg: String) = { println(s"[SUCCESS] $msg") ; sys.exit }

  def output(x: Int, y: Int) = x * 100 + y

  def nextInstruction(instructionSet: List[Int], lineNum: Int, lineSize: Int): List[Int] = {

    val position    = lineNum * lineSize

    val instruction = instructionSet.lift(position+0).getOrElse(fail(s"expected instruction not found at group $lineNum"))
    val inputIdx1   = instructionSet.lift(position+1).getOrElse(fail(s"expected first value not found at group $lineNum"))
    val inputIdx2   = instructionSet.lift(position+2).getOrElse(fail(s"expected second value not found at group $lineNum"))
    val outputIdx   = instructionSet.lift(position+3).getOrElse(fail(s"expected output index not found at group $lineNum"))

    val inputVal1   = instructionSet.lift(inputIdx1).getOrElse(fail(s"expected first value not found at index $inputIdx1"))
    val inputVal2   = instructionSet.lift(inputIdx2).getOrElse(fail(s"expected second value not found at index $inputIdx2"))
        
    instruction match {
      case 1  => nextInstruction(instructionSet.updated(outputIdx, inputVal1 + inputVal2), lineNum + 1, lineSize)
      case 2  => nextInstruction(instructionSet.updated(outputIdx, inputVal1 * inputVal2), lineNum + 1, lineSize)
      case 99 => instructionSet
      case c  => fail(s"ERROR, got unexpected code $c")
    }
  }

  val lineSize = 4
  val target = 19690720
  val input = File("./input.txt")
                .lines
                .mkString.split(",")
                .map(x => Try(x.toInt).getOrElse(fail("error parsing input file - encountered non-integer value")))
                .toList

  for {
    x <- 0 to 100
    y <- 0 to 100
  } yield {
    nextInstruction(input.updated(1, x).updated(2, y), 0, lineSize).headOption.foreach(res => {
      if (res == target) { pass(s"Used (x, y) of $x $y with value ${output(x, y)}") }
    })
  }

}
