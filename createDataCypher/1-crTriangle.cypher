// CREATE triangle data nbrTriangles across and nbrLevels down
:param nbrTriangles => 3;
:param nbrLevels => 3;

// Create a triangles with nbrTriangles at each level for nbrLevels
// nbrTriangles: cypher parameter is the number of sub-triangles (vertical lines)
// nbrLevels: cypher parameter is the number of sub-triangle (horizontal line) levels
// nbrPoints = $nbrLevels x ($nbrTriangles + 1)

// Start with a blank database! Next statement clears all nodes and relationships
MATCH (n) DETACH DELETE n;

// create 2nd level to bottom of triangle relationships (it's really a grid)
WITH $nbrLevels * ($nbrTriangles + 1) AS nbrPoints,
     $nbrTriangles + 1 AS nbrSides
UNWIND range(1,$nbrTriangles) AS i  // across
  UNWIND range(0, nbrPoints - 1, nbrSides ) AS j  // down
    MERGE(left:Point {pID: i + j})
    MERGE(across:Point {pID: i + j + 1})
    MERGE (left)-[:ACROSS]->(across)
    WITH left, across, nbrPoints, nbrSides
    WHERE left.pID < (nbrPoints - $nbrTriangles )
      AND $nbrLevels > 1
        MERGE (leftDown:Point {pID: left.pID + nbrSides})
        MERGE (acrossDown:Point {pID: across.pID + nbrSides})
        MERGE(left)-[:DOWN]->(leftDown)
        MERGE(across)-[:DOWN]->(acrossDown);

// create 1st level (top) of triangle, a.k.a. "node 0"
CREATE(top:Point {pID: 0})
WITH top, $nbrTriangles + 1 AS nbrSides
UNWIND range(1,nbrSides) AS idx
  MATCH(bottom:Point {pID: idx})
  MERGE (top)-[:DOWN]->(bottom);
