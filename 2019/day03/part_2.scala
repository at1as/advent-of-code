import scala.tools.nsc.io.File

// Uses a lot of memory. Run with: 
//  JAVA_OPTS="-Xmx1G -Xms64m -Xss16M" scala part_2.scala

object MyApp extends App {

  case class Coord(x: Int, y: Int)

  def fail(msg: String) = { println(s"[ERROR] $msg") ; sys.exit }

  def manhattanDist(coord: Coord) = coord.x + coord.y
  def steps(coord: Coord, path1: List[Coord], path2: List[Coord]) = {
    path1.indexOf(coord) + path2.indexOf(coord)
  }
  def manhattanSort(c1: Coord, c2: Coord, p1: List[Coord], p2: List[Coord]) = {
    steps(c1, p1, p2) < steps(c2, p1, p2)
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
    .sortWith({ case(c1, c2) => manhattanSort(c1, c2, wire1Positions, wire2Positions) })
    .headOption.fold(
      println("No overlap found!")
    )(c => 
      println(s"Found overlap at $c with step distance ${steps(c, wire1Positions, wire2Positions)}")
    )
  
}
