// Return data that does not have the property origTri
MATCH (n:Point) WHERE NOT exists(n.origTri) RETURN n
