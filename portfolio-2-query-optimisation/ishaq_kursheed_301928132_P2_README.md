# Hotel Reservation System — SQL queries

## 1. Show related reservation, guest records (up to 20).

```sql
SELECT t0."reservation_id" AS "reservation_reservation_id",
       t0."check_in" AS "reservation_check_in",
       t1."guest_id" AS "guest_guest_id",
       t1."full_name" AS "guest_full_name"
FROM portfolio."reservation" t0
JOIN portfolio."guest" t1 ON t0."guest_id" = t1."guest_id"
ORDER BY t0."reservation_id", t1."guest_id"
LIMIT 20;
```

| reservation_reservation_id | reservation_check_in | guest_guest_id | guest_full_name |
| --- | --- | --- | --- |
| 301 | 2026-11-10 | 101 | Maya Chen |

## 2. Find reservation records where check_in matches "2026-11-10" (up to 20).

```sql
SELECT * FROM portfolio."reservation"
WHERE "check_in" IS NOT DISTINCT FROM '2026-11-10'
ORDER BY "reservation_id"
LIMIT 20;
```

| reservation_id | guest_id | room_id | check_in | check_out | status | created_at |
| --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | 2026-11-10 | 2026-11-12 | confirmed | 2026-10-31T20:00:00+00:00 |

## 3. Count reservation records for each guest_id (up to 20 groups).

```sql
SELECT "guest_id", count(*) AS record_count
FROM portfolio."reservation"
GROUP BY "guest_id"
ORDER BY record_count DESC, "guest_id" NULLS LAST
LIMIT 20;
```

| guest_id | record_count |
| --- | --- |
| 101 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 0.878 | 0.895, 0.873, 0.878 | Sort → Seq Scan | 112 |
| After index | 0.18 | 0.212, 0.18, 0.18 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 0.878 ms to 0.18 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=0.872..0.874 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.021..0.837 rows=20 loops=1)
Planning Time: 0.355 ms
Execution Time: 0.895 ms
```

### Before index, run 2

```text
Sort (actual time=0.85..0.852 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.02..0.815 rows=20 loops=1)
Planning Time: 0.349 ms
Execution Time: 0.873 ms
```

### Before index, run 3

```text
Sort (actual time=0.856..0.858 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.02..0.82 rows=20 loops=1)
Planning Time: 0.348 ms
Execution Time: 0.878 ms
```

### After index, run 1

```text
Sort (actual time=0.167..0.168 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.032..0.132 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.015 rows=20 loops=1)
Planning Time: 0.634 ms
Execution Time: 0.212 ms
```

### After index, run 2

```text
Sort (actual time=0.134..0.136 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.032..0.1 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.015 rows=20 loops=1)
Planning Time: 0.556 ms
Execution Time: 0.18 ms
```

### After index, run 3

```text
Sort (actual time=0.134..0.136 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.033..0.099 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.015 rows=20 loops=1)
Planning Time: 0.616 ms
Execution Time: 0.18 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run ishaq_kursheed_301928132_P2_Queries.sql, then ishaq_kursheed_301928132_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/ishaq_kursheed_301928132_P2_QueryResults.png) · [Index comparison](screenshots/ishaq_kursheed_301928132_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

