import scala.tools.nsc.io.File
import scala.util.Try

object MyApp extends App {

  def add(i: Int, sum: Int): Int = i match {
    case x if x <= 0 =>
      sum
    case x =>
      val n = x/3 - 2
      add(n, sum + n)
  }


  val f = File("./input.txt")
            .lines
            .map(_.trim)
            .map(x => Try(add(x.toInt, 0)).getOrElse(0))
            .sum

  println(s"Sum is $f")
}

