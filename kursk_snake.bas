$NOPREFIX
OPTION EXPLICIT

TYPE position
    x AS SINGLE
    y AS SINGLE
END TYPE

DIM canvas AS LONG
canvas = NEWIMAGE(400, 400, 32)

SCREEN canvas
TITLE "SNAKE KURSK"

DIM px, py, gs, tc, ax, ay, xv, yv, tail, i
DIM trail(1000) AS position
px = 10
py = 10
gs = 20
tc = 20
ax = 15
ay = 15
tail = 1

FOR i = 0 TO tail - 1
    trail(i).x = px
    trail(i).y = py
NEXT

DO
    DIM k AS LONG
    k = KEYHIT
    SELECT CASE k
        CASE 18432 'up
            xv = 0
            yv = -1
        CASE 20480 'down
            xv = 0
            yv = 1
        CASE 19200 'left
            xv = -1
            yv = 0
        CASE 19712 'right
            xv = 1
            yv = 0
    END SELECT

    px = px + xv
    py = py + yv

    IF px < 0 THEN px = tc - 1
    IF px > tc - 1 THEN px = 0
    IF py < 0 THEN py = tc - 1
    IF py > tc - 1 THEN py = 0

    'bg
    LINE (0, 0)-(WIDTH, HEIGHT), RGB32(0), BF

    'snake
    FOR i = 0 TO tail - 1
        LINE (trail(i).x * gs, trail(i).y * gs)-STEP(gs - 2, gs - 2), RGB32(55, 161, 61), BF
        IF trail(i).x = px AND trail(i).y = py THEN tail = 5
    NEXT

    trail(tail).x = px
    trail(tail).y = py
    FOR i = 0 TO tail - 1
        trail(i) = trail(i + 1)
    NEXT

    'apple
    IF (ax = px AND ay = py) OR tail < 5 THEN
        tail = tail + 1
        ax = INT(RND * tc)
        ay = INT(RND * tc)
    END IF

    LINE (ax * gs, ay * gs)-STEP(gs - 2, gs - 2), RGB32(255, 0, 0), BF

    DISPLAY
    LIMIT 10
LOOP

