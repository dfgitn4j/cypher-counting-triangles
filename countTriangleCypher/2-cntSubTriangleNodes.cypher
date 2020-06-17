// Count the number of triangle patterns
MATCH (top:Point) WHERE NOT ( (top:Point)<--(:Point) )  // Find first node of triangle, has no incoming relationships
MATCH path=(top)-[:DOWN*]->(:Point)-[:ACROSS*]->(:Point)<-[:DOWN*]-(top)
RETURN count(path) AS triangleCount
