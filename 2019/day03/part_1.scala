import scala.tools.nsc.io.File
import scala.util.Try

// Uses a lot of memory. Run with: 
//  JAVA_OPTS="-Xmx1G -Xms64m -Xss16M" scala part_1.scala

object MyApp extends App {

  case class Coord(x: Int, y: Int)

  def fail(msg: String) = { println(s"[ERROR] $msg") ; sys.exit }

  def manhattanDist(coord: Coord) = coord.x + coord.y
  def manhattanSort(c1: Coord, c2: Coord) = {
    (c1.x + c1.y) < (c2.x + c2.y)
  }

  def move(path: List[Coord], nextPositions: List[String]): List[Coord] = {
    nextPositions.headOption.fold(path)(n => {
    
      val magnitude = Try("[^0-9]".r.replaceAllIn(n, "").toInt).getOrElse(fail(s"Failed to extract int from $n"))
      val direction = "[^UDLR]".r.replaceAllIn(n, "")
      val lastNode  = path.lastOption.getOrElse(fail("No initial coord provided")) 

      direction match {
        case "U" => 
          val nextSteps = (1 to magnitude).map(y => Coord(lastNode.x, lastNode.y + y))
          move(path ++ nextSteps, nextPositions.drop(1))
        case "D" =>
          val nextSteps = (1 to magnitude).map(y => Coord(lastNode.x, lastNode.y - y))
          move(path ++ nextSteps, nextPositions.drop(1))
        case "L" =>
          val nextSteps = (1 to magnitude).map(x => Coord(lastNode.x - x, lastNode.y))
          move(path ++ nextSteps, nextPositions.drop(1))
        case "R" =>
          val nextSteps = (1 to magnitude).map(x => Coord(lastNode.x + x, lastNode.y))
          move(path ++ nextSteps, nextPositions.drop(1))
        case x =>
          fail(s"Direction of $x was not extractable as 'U', 'D', 'L', 'R'")
      }
    })
  }


  val input          = File("./input.txt").lines.map(_.split(",")).toList
  val initialPos     = Coord(0, 0)

  val wire1Deltas    = input.lift(0).getOrElse(fail("first input not found")).toList
  val wire1Positions = move(List(initialPos), wire1Deltas)

  val wire2Deltas    = input.lift(1).getOrElse(fail("second input not found")).toList
  val wire2Positions = move(List(initialPos), wire2Deltas)

  val overlap        = wire1Positions.toSet intersect wire2Positions.toSet

  overlap
    .toList
    .filterNot(_ == initialPos)
    .sortWith(manhattanSort)
    .headOption.fold(
      fail("No overlap found!")
    )(c => 
      println(s"Found overlap at $c with manhattan distance ${manhattanDist(c)}")
    )
  
}
