// Manually create triangle graph with 3 triangles for 3 levels
MATCH (n) DETACH DELETE n;  // DELETE existing data
// CREATE :Nodes (triangle intersections)
CREATE  (zero:Point {pID: 0}), 
(one:Point {pID: 1}),     (two:Point {pID: 2}), 
(three:Point {pID: 3}),   (four:Point {pID: 4}), 
(five:Point {pID: 5}),    (six:Point {pID: 6}), 
(seven:Point {pID: 7}),   (eight:Point {pID: 8}), 
(nine:Point {pID: 9}),    (ten:Point {pID: 10}),  
(eleven:Point {pID: 11}), (twelve:Point {pID: 12}) 

// CREATE :RELATIONSHIPS (lines between intersections)
CREATE (zero)-[:DOWN]->(one), 
  (zero)-[:DOWN]->(two), 
  (zero)-[:DOWN]->(three), 
  (zero)-[:DOWN]->(four)
CREATE (one)-[:ACROSS]->(two),  (one)-[:DOWN]->(five)
CREATE (two)-[:ACROSS]->(three), (two)-[:DOWN]->(six)
CREATE (three)-[:ACROSS]->(four), (three)-[:DOWN]->(seven)
CREATE (four)-[:DOWN]->(eight)
CREATE (five)-[:ACROSS]->(six), (five)-[:DOWN]->(nine)
CREATE (six)-[:ACROSS]->(seven), (six)-[:DOWN]->(ten)
CREATE (seven)-[:ACROSS]->(eight), (seven)-[:DOWN]->(eleven)
CREATE (eight)-[:DOWN]->(twelve)
CREATE (nine)-[:ACROSS]->(ten)
CREATE (ten)-[:ACROSS]->(eleven)
CREATE (eleven)-[:ACROSS]->(twelve)
