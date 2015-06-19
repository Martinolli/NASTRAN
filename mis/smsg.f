      SUBROUTINE SMSG (NO,P1,P2)        
C        
C     MESSAGE WRITER FOR SUBSTRUCTURE DIAGNOSTICS, 61XX SERIES        
C        
      INTEGER         P1,P2(2),P3(2),POS(2),NEG(2),PNG(2)        
      CHARACTER       UFM*23        
      COMMON /XMSSG / UFM        
      COMMON /SYSTEM/ SYSBUF,K        
      DATA    POS   , NEG/4HWARN,4HING ,4HFATA,4HL   /        
      DATA    NMSG  / 8  /, NMSG1 / 11 /        
C        
      L = IABS(NO)        
      MSGNO  = L + 6100        
      IF (L.LT.1 .OR. L.GT.NMSG) GO TO 99        
      IF (NO) 30,30,40        
   30 PNG(1) = NEG(1)        
      PNG(2) = NEG(2)        
      GO TO 50        
   40 PNG(1) = POS(1)        
      PNG(2) = POS(2)        
      GO TO 50        
C        
C        
      ENTRY SMSG1 (NO,P1,P2,P3)        
C     ========================        
C        
      L = IABS(NO)        
      IF (L.LE.NMSG .OR. L.GT.NMSG1) GO TO 99        
C        
   50 GO TO (1,2,3,4,5,6,7,8,9,10,11,12), L        
    1 WRITE (K,201) PNG,MSGNO        
      WRITE (K,101) P1,P2        
      GO TO 100        
    2 WRITE (K,201) PNG,MSGNO        
      WRITE (K,102) P1,P2        
      GO TO 100        
    3 WRITE (K,201) PNG,MSGNO        
      WRITE (K,103) P1,P2        
      GO TO 100        
    4 WRITE (K,201) PNG,MSGNO        
      WRITE (K,104) P2        
      GO TO 100        
    5 WRITE (K,201) PNG,MSGNO        
      WRITE (K,105) P2        
      GO TO 100        
    6 WRITE (K,200) PNG,MSGNO        
      WRITE (K,106) P1,P2        
      GO TO 100        
    7 WRITE (K,200) PNG,MSGNO        
      WRITE (K,107) P1,P2        
      GO TO 100        
    8 WRITE (K,200) PNG,MSGNO        
      WRITE (K,108) P1,P2        
      GO TO 100        
    9 WRITE (K,109) P3,P1,P2        
      GO TO 100        
   10 WRITE (K,110) P3,P1,P2        
      GO TO 100        
   11 WRITE (K,111) P3,P1,P2        
      GO TO 100        
   12 WRITE (K,112)        
      GO TO 100        
   99 WRITE (K,120) NO,P1,P2        
  100 IF (NO .GT. 0) RETURN        
      IF (L .LE. NMSG) CALL SOFCLS        
      WRITE (K,130)        
      CALL ERRTRC ('SMSG    ',130)        
      RETURN        
C        
  101 FORMAT (' REQUESTED SOF ITEM DOES NOT EXIST.  ITEM ',A4,        
     1        ', SUBSTRUCTURE ',2A4)        
  102 FORMAT (' REQUESTED SUBSTRUCTURE DOES NOT EXIST.  ITEM ',A4,      
     1        ', SUBSTRUCTURE ',2A4)        
  103 FORMAT (' REQUESTED SOF ITEM HAS INVALID NAME.  ITEM ',A4,        
     1        ', SUBSTRUCTURE ',2A4)        
  104 FORMAT (' ATTEMPT TO CREATE DUPLICATE SUBSTRUCTURE NAME ',2A4)    
  105 FORMAT (' ATTEMPT TO RE-USE SUBSTRUCTURE ',2A4,' IN A REDUCE ',   
     1       ' OR COMBINE OPERATION.  USE EQUIV SUBSTRUCTURE COMMAND')  
  106 FORMAT (' UNEXPECTED END OF GROUP ENCOUNTERED WHILE READING ITEM '
     1,       A4,', SUBSTRUCTURE ',2A4)        
  107 FORMAT (' UNEXPECTED END OF ITEM ENCOUNTERED WHILE READING ITEM ',
     1        A4,', SUBSTRUCTURE ',2A4)        
  108 FORMAT (' INSUFFICIENT SPACE ON SOF FOR ITEM ',A4,', SUBSTRUCTURE'
     1,       1X,2A4)        
  109 FORMAT (A23,' 6211, MODULE ',2A4,' - ITEM ',A4,        
     1       ' OF SUBSTRUCTURE ',2A4,' HAS ALREADY BEEN WRITTEN.')      
  110 FORMAT (A23,' 6632, MODULE ',2A4,' - NASTRAN MATRIX FILE FOR I/O',
     1       ' OF SOF ITEM ',A4,', SUBSTRUCTURE ',2A4,', IS PURGED.')   
  111 FORMAT (A23,' 6215, MODULE ',2A4,' - ITEM ',A4,        
     1       ' OF SUBSTRUCTURE ',2A4,' PSEUDO-EXISTS ONLY.')        
  112 FORMAT (' ')        
  120 FORMAT (' NO MESSAGE FOR MESSAGE NO.',I5,' PARAMETERS = ',2I10,   
     1        10X,2A10)        
  130 FORMAT (//,' FATAL ERROR')        
  200 FORMAT (' *** SYSTEM ',2A4,' MESSAGE',I5)        
  201 FORMAT (' *** USER ',2A4,' MESSAGE',I5)        
      END        