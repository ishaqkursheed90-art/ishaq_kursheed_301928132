-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. guest pk duplicate. Expected: pk_guest, SQLSTATE 23505.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone")
VALUES (101, 'Ira Moss', 'ira.moss@example.test', '+1-555-0102');

-- 2. guest email duplicate. Expected: uq_guest_0, SQLSTATE 23505.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone")
VALUES (1001, 'Ira Moss', 'maya.chen@example.test', '+1-555-0102');

-- 3. guest id null. Expected: guest_id, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone")
VALUES (NULL, 'Ira Moss', 'ira1@example.test', '+1-555-0102');

-- 4. guest name null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone")
VALUES (1002, NULL, 'ira2@example.test', '+1-555-0102');

-- 5. guest email null. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone")
VALUES (1003, 'Ira Moss', NULL, '+1-555-0102');

-- 6. room pk duplicate. Expected: pk_room, SQLSTATE 23505.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (201, '305', 'deluxe', 220, TRUE);

-- 7. room number duplicate. Expected: uq_room_0, SQLSTATE 23505.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (1201, '204', 'deluxe', 220, TRUE);

-- 8. room id null. Expected: room_id, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (NULL, '306', 'standard', 145, TRUE);

-- 9. room number null. Expected: room_number, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (1202, NULL, 'standard', 145, TRUE);

-- 10. room type null. Expected: room_type, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (1203, '307', NULL, 145, TRUE);

-- 11. room rate null. Expected: nightly_rate, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (1204, '308', 'standard', NULL, TRUE);

-- 12. room active null. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (1205, '309', 'standard', 145, NULL);

-- 13. reservation pk duplicate. Expected: pk_reservation, SQLSTATE 23505.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (301, 101, 201, '2026-12-01', '2026-12-03', 'cancelled', '2026-10-31T20:01:00Z');

-- 14. reservation guest fk missing. Expected: fk_reservation_0, SQLSTATE 23503.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (1301, 9991, 201, '2026-12-01', '2026-12-03', 'cancelled', '2026-10-31T20:02:00Z');

-- 15. reservation room fk missing. Expected: fk_reservation_1, SQLSTATE 23503.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (1302, 101, 9992, '2026-12-01', '2026-12-03', 'cancelled', '2026-10-31T20:03:00Z');

-- 16. reservation id null. Expected: reservation_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (NULL, 101, 201, '2026-12-01', '2026-12-03', 'cancelled', '2026-10-31T20:04:00Z');

-- 17. reservation guest null. Expected: guest_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (1303, NULL, 201, '2026-12-01', '2026-12-03', 'cancelled', '2026-10-31T20:05:00Z');

-- 18. reservation room null. Expected: room_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (1304, 101, NULL, '2026-12-01', '2026-12-03', 'cancelled', '2026-10-31T20:06:00Z');

-- 19. reservation checkin null. Expected: check_in, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (1305, 101, 201, NULL, '2026-12-03', 'cancelled', '2026-10-31T20:07:00Z');

-- 20. reservation checkout null. Expected: check_out, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (1306, 101, 201, '2026-12-01', NULL, 'cancelled', '2026-10-31T20:08:00Z');

-- 21. reservation status null. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (1307, 101, 201, '2026-12-01', '2026-12-03', NULL, '2026-10-31T20:09:00Z');

-- 22. reservation created null. Expected: created_at, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (1308, 101, 201, '2026-12-01', '2026-12-03', 'cancelled', NULL);

-- 23. reservation dates invalid. Expected: reservation_dates_valid, SQLSTATE 23514.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (1309, 101, 201, '2026-12-04', '2026-12-03', 'cancelled', '2026-10-31T20:10:00Z');

-- 24. reservation confirmed interval duplicate. Expected: confirmed_interval_unique, SQLSTATE 23505.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at")
VALUES (1310, 101, 201, '2026-11-10', '2026-11-12', 'confirmed', '2026-10-31T20:11:00Z');
