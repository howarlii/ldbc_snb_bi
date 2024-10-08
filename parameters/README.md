# Parameters

This directory contains the query substistution parameters (`bi-*.csv`)

The headers of the parameters are specified as a pipe-separated CSV file. It makes use of the syntax of the [Neo4j CSV import tool](https://neo4j.com/docs/operations-manual/4.2/tools/neo4j-admin-import/#import-tool-header-format) to specify the type of each parameter. For example, the header

```
date:DATE|lengthThreshold:INT|languages:STRING[]
```

indicates that there are 3 parameters, `date` (a date value), `lengthThreshold` (a 64-bit integer), and `languages` (a string array).

The expected headers for each `bi-*.csv` files are specified in the `headers.csv` file.

## SF30,000 parameters

The parameters for SF30,000 were re-generated in autumn 2023 before conducting the TuGraph audit (LDBC_SNB_BI_20231203_SF30000_tugraph).
We included the old parameters as `parameters-sf30000-deprecated` but these should *not* be used.
