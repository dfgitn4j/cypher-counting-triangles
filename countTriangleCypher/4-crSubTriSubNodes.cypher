// Create a subgraph for each triangle path returned by the cypher pattern for visualization
// See: https://neo4j.com/docs/labs/apoc/current/graph-updates/graph-refactoring/

// property to indicate original data set nodes
MATCH (n) SET n.origTri = TRUE;

MATCH (top:Point) WHERE NOT ( (top:Point)<--(:Point) )  // Find first node of triangle, has no incoming relationships
MATCH path=(top)-[:DOWN*]->(:Point)-[:ACROSS*]->(:Point)<-[:DOWN*]-(top)
WITH path
call apoc.refactor.cloneSubgraphFromPaths([path], {skipProperties:['origTri']}) YIELD input, output, error
RETURN input, output, error;
