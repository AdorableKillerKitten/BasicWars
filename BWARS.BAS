DECLARE SUB drawCursor (menuPos)
DECLARE SUB printMenu ()
DECLARE SUB drawGrid ()
DECLARE SUB drawUnit (x, y)

DIM SHARED gamestate
DIM SHARED menuPos
DIM SHARED px!
DIM SHARED py!
DIM SHARED cursorx!
DIM SHARED cursory!
DIM SHARED units(1 TO 20)
DIM SHARED unitSelect

menuPos = 0
gamestate = 0 OR 128
px! = 25
py! = 25
offset! = 10
cursorx! = 20
cursory! = 20
stepsize = 20
unitSelect = 0

CLS
SCREEN 7, , 1, 0
COLOR 1

WHILE px! < 300

        CLS
        drawGrid
        drawUnit cursorx, cursory
        IF (gamestate = 129) THEN
                printMenu
                drawCursor menuPos
        END IF

        LET k$ = INKEY$
        LET C = -1
        IF LEN(k$) THEN C = ASC(k$)
       
        SELECT CASE C

                CASE 100
                        IF gamestate AND 1 = 1 THEN
                                cursorx! = cursorx! + stepsize
                        END IF
               
                CASE 115
                        IF gamestate = 128 THEN
                                cursory! = cursory! + stepsize
                ELSE

                       menuPos = (menuPos + 1) AND 1
               
                END IF
       
        CASE 97
                cursorx = cursorx! - stepsize
       
        CASE 119
                IF gamestate = 128 THEN
                       
                        cursory! = cursory! - stepsize
                ELSE
               
                menuPos = (menuPos + 1) AND 1
               
                END IF
       
        CASE 13
                px! = cursorx! + 5
                py! = cursory! + 5
        CASE 27
               
                END
       
        CASE 32

        gamestate = (NOT (gamestate) AND 1) OR 128


        END SELECT
       
        LINE (px!, py!)-(px! + offset!, py! + offset!), 5, BF
        
        WAIT &H3DA, 8
        PCOPY 1, 0
WEND

SUB drawCursor (menuPos)

upRightX = 190
upRightY = 33
size = 7
jump = 16

LINE (upRightX, upRightY + jump * menuPos)-(upRightX + size, upRightY + size + jump * menuPos), 9, BF
END SUB

SUB drawGrid
FOR i = 0 TO 300 STEP 20
        LINE (i, 0)-(i, 180)
        LINE (0, i)-(300, i)
NEXT

END SUB

SUB drawUnit (x, y)
LINE (x, y)-(x + 20, y + 20), 2, B
         
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

