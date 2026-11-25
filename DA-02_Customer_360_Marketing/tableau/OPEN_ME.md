# Tableau workbook
`DA02_Customer360_Attribution.twbx` – 4 data sources (the CSVs in `data/processed`, packaged inside), 15 worksheets, 4 dashboards: **Customer 360, RFM Segments, Marketing Attribution, Campaign Performance**.

Open in Tableau Desktop / Tableau Public. If Tableau reports a missing file, use *Edit Data Source → Edit connection* and point to `../data/processed/<file>.csv`.
Then tidy the layout, set currency formats, and *File → Save* (this re-saves it as a Tableau-written `.twbx`). Re-run `python/customer_analysis.py` first if you change the data.
