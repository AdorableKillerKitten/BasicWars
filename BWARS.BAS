DECLARE SUB drawTileMap ()
DECLARE SUB drawCell (x!, y!, col!)
DECLARE SUB moveGrid ()
DECLARE SUB moveAnimation (offset!)
DECLARE SUB inputHandler ()
DECLARE SUB drawCursor (menuPos)
DECLARE SUB printMenu ()
DECLARE SUB drawGrid ()
DECLARE SUB drawUnit (x, y)

DIM SHARED tile1(20, 20)
DIM SHARED mGrid(5, 5)
DIM SHARED gamestate
DIM SHARED menuPos
DIM SHARED px!
DIM SHARED py!
DIM SHARED cursorx!
DIM SHARED cursory!
DIM SHARED units(1 TO 20)
DIM SHARED unitSelect
DIM SHARED stepsize
DIM SHARED pxT
DIM SHARED pyT


FOR i = 1 TO 5

FOR k = 1 TO 5

READ z
mGrid(i, k) = z

NEXT
NEXT

FOR i = 1 TO 20
FOR k = 1 TO 20
READ z
tile1(i, k) = z
NEXT
NEXT

menuPos = 0
gamestate = 0 OR 128
px! = 25
py! = 25
pxT = px!
pyT = py!
offset! = 10
cursorx! = 20
cursory! = 20
stepsize = 20
unitSelect = 0
row% = 0
col% = 0
CLS
SCREEN 7, , 1, 0
COLOR 1
drawTileMap
PCOPY 1, 3
WHILE 1:

        CLS
        PCOPY 3, 1
        drawGrid
        IF (gamestate AND 8) = 8 THEN
        moveGrid
               
        END IF

        drawUnit cursorx, cursory
        IF (gamestate = 129) THEN
                printMenu
                drawCursor menuPos
        END IF

        inputHandler
        moveAnimation offset!

        WAIT &H3DA, 8
        PCOPY 1, 0
WEND


DATA 0,0,1,0,0
DATA 0,1,1,1,0
DATA 1,1,1,1,1
DATA 0,1,1,1,0
DATA 0,0,1,0,0

DATA 2, 2, 2, 2, 2, 10, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
DATA 2, 10, 2, 2, 2, 10, 2, 10, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
DATA 2, 10, 2, 2, 2, 10, 2, 10, 2, 14, 2, 2, 2, 14, 2, 2, 14, 2, 10, 2
DATA 2, 10, 2, 10, 2, 2, 2, 10, 2, 10, 2, 10, 2, 10, 2, 2, 10, 2, 10, 2
DATA 2, 2, 2, 10, 2, 10, 2, 2, 2, 10, 2, 10, 2, 10, 2, 2, 10, 2, 10, 2
DATA 10, 2, 2, 10, 2, 10, 2, 14, 2, 10, 2, 10, 2, 10, 2, 2, 10, 2, 2, 2
DATA 10, 2, 14, 2, 2, 10, 2, 10, 2, 2, 2, 2, 2, 2, 10, 2, 2, 2, 2, 2
DATA 10, 2, 10, 2, 10, 2, 2, 10, 2, 2, 2, 2, 2, 2, 10, 2, 2, 2, 2, 2
DATA 2, 2, 10, 2, 10, 2, 2, 10, 2, 2, 2, 14, 2, 2, 10, 2, 2, 2, 2, 2
DATA 2, 2, 10, 2, 10, 2, 2, 2, 2, 2, 2, 10, 2, 2, 2, 2, 2, 10, 2, 2
DATA 2, 2, 2, 14, 2, 2, 10, 2, 2, 10, 2, 10, 2, 10, 2, 10, 2, 10, 2, 2
DATA 2, 2, 2, 10, 2, 2, 10, 2, 2, 10, 2, 10, 2, 10, 2, 10, 2, 10, 2, 2
DATA 2, 2, 2, 10, 2, 2, 10, 2, 2, 10, 2, 2, 2, 10, 2, 10, 2, 2, 2, 2
DATA 2, 2, 2, 10, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
DATA 2, 2, 2, 2, 2, 2, 2, 10, 2, 2, 2, 2, 2, 2, 2, 10, 2, 14, 2, 2
DATA 2, 2, 10, 2, 2, 14, 2, 10, 2, 2, 14, 2, 2, 14, 2, 10, 2, 10, 2, 2
DATA 2, 2, 10, 2, 2, 10, 2, 10, 2, 2, 10, 2, 2, 10, 2, 10, 2, 10, 2, 2
DATA 2, 2, 10, 2, 2, 10, 2, 2, 2, 2, 10, 2, 2, 10, 2, 2, 2, 2, 2, 2
DATA 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
DATA 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2

SUB dispMovArea




END SUB

SUB drawCell (x, y, col)

LINE (x * 20, y * 20)-(x * 20 + 20, y * 20 + 20), col, B

END SUB

SUB drawCursor (menuPos)

upRightX = 190
upRightY = 33
size = 7
jump = 16

LINE (upRightX, upRightY + jump * menuPos)-(upRightX + size, upRightY + size + jump * menuPos), 0, BF
END SUB

SUB drawGrid
FOR i = 0 TO 300 STEP 20
        LINE (i, 0)-(i, 180), 15
        LINE (0, i)-(300, i), 15
NEXT

END SUB

SUB drawTileMap
x = 0
y = 0
start:
WHILE x < 300:
FOR i = 0 TO 20
FOR k = 1 TO 20
        PSET (x + k, i + y), tile1(i, k)
NEXT
NEXT
x = x + 20
WEND
y = y + 20
x = 0
IF y < 180 THEN GOTO start
END SUB

SUB drawUnit (x, y)
LINE (x, y)-(x + 20, y + 20), 2, B
         
END SUB

SUB inputHandler
        LET k$ = INKEY$
        LET C = -1
        IF LEN(k$) THEN C = ASC(k$)
      
        SELECT CASE C

                CASE 100
                        IF (gamestate AND 1) = 0 THEN
                                cursorx! = cursorx! + stepsize
                        END IF
              
                CASE 115
                        IF (gamestate AND 1) = 0 THEN
                                cursory! = cursory! + stepsize
                ELSE

                       menuPos = (menuPos + 1) AND 1
              
                END IF
      
        CASE 97
                IF (gamestate AND 1) = 0 THEN
                cursorx = cursorx! - stepsize
                END IF
      
        CASE 119
                IF (gamestate AND 1) = 0 THEN
                      
                        cursory! = cursory! - stepsize
                ELSE
              
                menuPos = (menuPos + 1) AND 1
              
                END IF
      
        CASE 13
                IF gamestate = 128 THEN
                pxT = cursorx! + 5
                pyT = cursory! + 5
                ELSE IF gamestate = 129 AND menuPos = 0 THEN gamestate = gamestate OR 8
                END IF
        CASE 27
              
                END
      
        CASE 32

        IF (gamestate AND 1) = 1 THEN
        gamestate = gamestate AND 254
        ELSE
        gamestate = gamestate OR 1
        END IF


        END SELECT

END SUB

SUB inputHandlewr

END SUB

SUB moveAnimation (offset!)
IF px! < pxT THEN px! = px! + 2
IF px! > pxT THEN px! = px! - 2
IF px! = pxT THEN

IF py! > pyT THEN py! = py! - 2
IF py! < pyT THEN py! = py! + 2
END IF
LINE (px!, py!)-(px! + offset!, py! + offset!), 5, BF
END SUB

SUB moveGrid
        row% = px! / 20
        col% = (py! / 20)
        FOR i = 1 TO 5
        FOR k = 1 TO 5
        IF mGrid(i, k) = 1 THEN drawCell (row% - 3 + i), (col% - 3 + k), 4
        NEXT
        NEXT


END SUB

SUB printMenu


upRightX = 205
upRightY = 20
bWidth = 71
bHeight = 58

tStartURX! = 28
tStartURY! = 5
tOffset = 2
bx = upRightX + 1 + bWidth
by = upRightY + 1 + bHeight
LINE (upRightX, upRightY)-(upRightX + bWidth, upRightY + bHeight), 0, BF
LINE (upRightX - 1, upRightY - 1)-(bx, by), 15, B
LINE (upRightX - 2, upRightY - 1)-(bx + 1, by + 1), 15, B
PRINT upRightX + bWidth
LOCATE tStartURY!, tStartURX!
COLOR 15, 0
PRINT "move"
LOCATE tStartURY! + tOffset, tStartURX!
PRINT "attack"
LOCATE tStartURY + tOffset * 2, tStartURX!
PRINT "Exit"
COLOR 1, 0
PAINT (upRightX + 5, upRightY + 5), 1, 15
END SUB

