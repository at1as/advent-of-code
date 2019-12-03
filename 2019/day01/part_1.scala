import scala.tools.nsc.io.File
import scala.util.Try

object MyApp extends App {

  val f = File("./input.txt")
            .lines
            .map(_.trim)
            .map(x => Try(x.toInt/3 - 2).getOrElse(0))
            .sum

  println(s"Sum is $f")
}
