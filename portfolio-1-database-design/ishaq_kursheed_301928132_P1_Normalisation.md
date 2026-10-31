# Hotel Reservation System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| guest_id | reservation records (list) |
| --- | --- |
| 101 | [301] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| reservation.reservation_id | reservation.guest_id | reservation.room_id | reservation.status | guest.guest_id | guest.full_name | room.room_id | room.room_number |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | confirmed | 101 | Maya Chen | 201 | 204 |

Key: reservation_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## reservation_example

| reservation.reservation_id | reservation.guest_id | reservation.room_id | reservation.status | guest.guest_id | guest.full_name | room.room_id | room.room_number |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | confirmed | 101 | Maya Chen | 201 | 204 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## guest

| guest_id | full_name | email | phone |
| --- | --- | --- | --- |
| 101 | Maya Chen | maya.chen@example.test | +1-555-0101 |

## room

| room_id | room_number | room_type | nightly_rate | active |
| --- | --- | --- | --- | --- |
| 201 | 204 | standard | 145 | true |

## reservation

| reservation_id | guest_id | room_id | check_in | check_out | status | created_at |
| --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | 2026-11-10 | 2026-11-12 | confirmed | 2026-10-31T20:00:00+00:00 |

## Dependencies

- guest: (guest_id) → full_name, email, phone
- room: (room_id) → room_number, room_type, nightly_rate, active
- reservation: (reservation_id) → guest_id, room_id, check_in, check_out, status, created_at

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
