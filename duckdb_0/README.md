DuckDB implementation of the queries from the [LDBC Social Network Benchmark](https://arxiv.org/abs/2001.02299).

0. Start a duckDB docker and map the current directory.
```bash
docker run -v $(pwd):ldbc_cmd -v <data dir>:ldbc_data -it --name duckdb-ldbc datacatering/duckdb:v1.1.1
```
It should be a executable /duckdb at root dir.


1. Download/Generate the data, initialize the schema.

```bash
python /ldbc_cmd/download-benchmark-data.py
cat /ldbc_cmd/schema.sql | ./duckdb ldbc.duckdb
```

2. load the data.
```bash
SF=1
DATAPATH=/ldbc_data/out_sf${SF}_bi_gzip
/ldbc_cmd/generate_load_sql.sh $SF $DATAPATH
cat updated-snb-load-sf${SF}.sql | ./duckdb ldbc.duckdb
```


3. Execute the query:
```bash
cat /ldbc_cmd/querys/bi-1.sql | ./duckdb ldbc.duckdb
```