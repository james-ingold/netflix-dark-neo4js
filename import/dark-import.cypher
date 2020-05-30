create constraint on (c:Character) assert c.id is unique;
create constraint on (y:Year) assert y.id is unique;
create index on :Character(name);
create index on :Family(name);

create (`1921`:`Year` {id: 1921}), (`1953`:`Year` {id: 1953}), (`1986`:`Year` {id: 1986}), (`2019`:`Year` {id: 2019}), (`2052`:`Year` {id: 2052}), (`2085`:`Year` {id: 2085}),
(`Kahnwald`:`Family` {name: 'Kahnwald'}), (`Nielsen`:`Family` {name: 'Nielsen'}), (`Doppler`:`Family` {name: 'Doppler'}),
(`Tiedeman`:`Family`, {name: 'Tiedeman'}),
(`SicMundus`:`SicMundus` {name: 'Sic Mundus'});

CALL apoc.load.json("file:///characters.json") YIELD value 
UNWIND value.characters AS character
with apoc.map.clean(character, [],['',[''],[],null]) as data
MERGE (c:Character {name:data.name})
SET
c += apoc.map.clean(data, [],['',[''],[],null])
// Build relations
// arrays
// looping through arrays and adding the relationship
FOREACH (name in data.married | MERGE (m:Character {name:name}) MERGE (m)-[:MARRIED]->(c))
FOREACH (name in data.parentOf | MERGE (m:Character {name:name}) MERGE (c)-[:PARENT_OF]<-(m))
FOREACH (name in data.siblings | MERGE (m:Character {name:name}) MERGE (m)-[:SIBLING_OF]->(c))
FOREACH (name in data.killedBy | MERGE (m:Character {name:name}) MERGE (c)-[:KILLED_BY]<-(m))
FOREACH (id in data.years | MERGE (y:Year {id:id}) MERGE (c)-[:WHEN]->(y))
FOREACH (name in case data.lastname when null then [] else [data.lastname] end | MERGE (f:Family {name:name}) MERGE (c)-[:FAMILY]->(f))

//sic mundus
FOREACH (name in case data.sicMundus when null then [] else [data.sicMundus] end | MERGE (s:SicMundus) MERGE (c)-[:SIC_MUNDUS_MEMBER]->(s))
//

return c.name;
