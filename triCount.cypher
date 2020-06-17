CALL gds.graph.drop('tri-cyph-prjctn-graph') YIELD graphName;

CALL gds.graph.create.cypher(
    'tri-cyph-prjctn-graph',
    'MATCH (n) RETURN id(n) AS id',
    'MATCH (n)-->(m) RETURN id(n) AS source, id(m) AS target'
)

call gds.triangleCount.stream('tri-cyph-prjctn-graph') YIELD nodeId, triangleCount
RETURN toInteger(gds.util.asNode(nodeId).pID) AS pID, triangleCount
ORDER BY triangleCount DESC

match (n)-->(m)
MERGE (n)-[:LINK]->(m)

CALL gds.graph.drop('tri-graph');
CALL gds.graph.create(
  'tri-graph',
  'Point',
  { LINK: { orientation: 'UNDIRECTED' } }
)

CALL gds.graph.drop('tri-graph');
CALL gds.graph.create.cypher(
    'tri-graph',
    'MATCH (n) RETURN id(n) AS id',
    'MATCH (n)-[:LINK*]->(m) RETURN id(n) AS source, id(m) AS target'
)


CALL gds.alpha.triangles('tri-graph')
YIELD nodeA, nodeB, nodeC
RETURN
  gds.util.asNode(nodeA) AS nodeA,
  gds.util.asNode(nodeB) AS nodeB,
  gds.util.asNode(nodeC) AS nodeC

  call gds.triangleCount.stream('tri-graph') YIELD nodeId, triangleCount
RETURN toInteger(gds.util.asNode(nodeId).pID) AS pID, triangleCount
ORDER BY triangleCount DESC

//
CALL gds.alpha.articleRank.stream('tri-graph')
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).pID AS pId,score
ORDER BY score DESC
