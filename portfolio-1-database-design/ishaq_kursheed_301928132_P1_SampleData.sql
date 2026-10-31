-- Fictional sample records for Hotel Reservation System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone") VALUES (101, 'Maya Chen', 'maya.chen@example.test', '+1-555-0101');
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "active") VALUES (201, '204', 'standard', 145, TRUE);
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "created_at") VALUES (301, 101, 201, '2026-11-10', '2026-11-12', 'confirmed', '2026-10-31T20:00:00Z');
COMMIT;
