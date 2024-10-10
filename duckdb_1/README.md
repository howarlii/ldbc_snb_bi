# Instruction manual

`load.py` can be used to benchmark the DuckPGQ implementation.

To do this:

1. Clone [LDBC SNB Datagen Spark](https://github.com/ldbc/ldbc_snb_datagen_spark)
   1. Load the datasets in this repository
2. Generate the parameters and place them in the parameters folder.
3. Install duckDB python package `pip install duckdb`.
4. Run `python load.py -s <scale factor> -w <workload (bi or interactive)> -q <subquery> -l <_only_ load database (1 or 0)> -a <number of lanes> -f <csv or parquet> -t <number of threads> -e <log results (1 or 0)> - `

Currently only support BI query q19, q20.