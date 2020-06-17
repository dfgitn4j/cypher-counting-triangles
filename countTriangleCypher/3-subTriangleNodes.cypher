// The paths through the graph represented by the cypher pattern and include a count
// of the number of nodes in each triangle
MATCH (top:Point) WHERE NOT ( (top:Point)<--(:Point) )  // Find first node of triangle, has no incoming relationships
MATCH path=(top)-[:DOWN*]->(:Point)-[:ACROSS*]->(:Point)<-[:DOWN*]-(top)
RETURN nodes(path) as paths, length(path) as nodeCnt
ORDER BY nodeCnt ASC
