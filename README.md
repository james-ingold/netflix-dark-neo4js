# netflix-dark-neo4js

[A megathread on this repository](#)

Learn Neo4j with Netflix's Dark TV Series

## Deployment

1. Run neo4j in docker

```bash
docker run \
    --name neo4j \
    -p7474:7474 -p7687:7687 \
    -d \
    -v $HOME/neo4j/data:/data \
    -v $HOME/neo4j/logs:/logs \
    -v $HOME/neo4j/import:/var/lib/neo4j/import \
    -v $HOME/neo4j/plugins:/plugins \
    --env NEO4J_AUTH=neo4j/securepassword \
    --env NEO4JLABS_PLUGINS='["apoc"]' \
    --env apoc.import.file.enabled=true \
    neo4j:latest
```

2. Seed the database Run import/dark-import.cypher

## Inspirations

[Game of Thrones Datasets and
Visualizations](https://github.com/jeffreylancaster/game-of-thrones)

[Game of Thrones Visualizations with
Neo4j](https://github.com/tocttou/got-visual)

[Neo4j Examples](https://github.com/neo4j-examples/)
