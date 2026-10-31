# Hotel Reservation System — database design

My case study records guest, room, reservation.

## Users

- Front-desk staff managing guest bookings
- Managers reviewing room occupancy

## Main operations

- Record guest and room details
- Create and review reservations
- Summarize reservations by room type

## Entities

| Entity | Information stored |
| --- | --- |
| guest | Stores synthetic guest contact details. |
| room | Stores hotel room identifiers, categories, and nightly rates. |
| reservation | Connects one guest to one room for a date interval. |

## guest

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| guest_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| phone | TEXT |  | No |
- Unique key: (email).

## room

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| room_id | BIGINT | PK | Yes |
| room_number | TEXT | Unique | Yes |
| room_type | TEXT |  | Yes |
| nightly_rate | NUMERIC(18,2) |  | Yes |
| active | BOOLEAN |  | Yes |
- Unique key: (room_number).

## reservation

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| reservation_id | BIGINT | PK | Yes |
| guest_id | BIGINT | FK | Yes |
| room_id | BIGINT | FK | Yes |
| check_in | DATE |  | Yes |
| check_out | DATE |  | Yes |
| status | TEXT |  | Yes |
| created_at | TIMESTAMPTZ |  | Yes |
- guest_id → guest.guest_id
- room_id → room.room_id

## Relationships and business rules

- Each guest email identifies at most one guest.
- Each room number identifies at most one room.
- Every reservation references an existing guest.
- Every reservation references an existing room.
- Check-out must be later than check-in.
- At most one confirmed reservation may have the same room, check-in date, and check-out date; enforce with a partial unique constraint for status confirmed.

## Assumptions

- Check-in and check-out are hotel-local calendar dates; check-out is exclusive.
- A reservation is for one guest and one room. This simplified rule prevents duplicate confirmed reservations for the same room and exact date interval; it does not prevent partially overlapping intervals.
- Reservation statuses are pending, confirmed, or cancelled; status transitions are outside the database-enforcement scope.
- Normalization example: use Reservation as the root relation. Keep guest name and email only in Guest, and room number, type, and rate only in Room; Reservation stores guest_id, room_id, check_in, check_out, and status rather than repeating those attributes.
- All example records and benchmark data are synthetic.

