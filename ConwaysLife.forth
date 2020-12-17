{ Chapter 4 Exercises }
{ Requires RND!!!! and Test_File_IO_Tools!!! and Graphics}
INCLUDE "C:\Users\Chris\Documents\University\Year 3\Labs\D3\RND.f"
INCLUDE "C:\Users\Chris\Documents\University\Year 3\Labs\D3\FileIO.forth"

variable square_array_size
variable nb-num
variable num_0
variable num_1
variable num_2
variable num_3
variable num_4
variable num_5
variable num_6
variable num_7
variable num_8
variable alives
variable deads
variable deaths
variable births
variable m-1
variable m2
variable m+1
variable n-1
variable n2
variable n+1

variable generation

200 square_array_size !
0 nb-num !
0 num_0 !
0 num_1 !
0 num_2 !
0 num_3 !
0 num_4 !
0 num_5 !
0 num_6 !
0 num_7 !
0 num_8 !
0 alives !
0 deads !
0 births !
0 deaths !
0 m-1 !
0 m2 !
0 m+1 !
0 n-1 !
0 n2 !
0 n+1 !

0 generation !

					{ Setup Functions + routines }

: MAKE_NB_ARRAY square_array_size @ dup * ALLOCATE DROP DUP
    square_array_size @ dup * 0 FILL ;

: MAKE_LD_ARRAY square_array_size @ dup * 1 + ALLOCATE DROP DUP
    square_array_size @ dup * 1 + 0 FILL ;

make_nb_array
make_ld_array
constant array_nb_loc
constant array_ld_loc

					{ Array Manipulations }

: ARRAY_XY_nb! square_array_size @ * + array_nb_loc + C! ; { ld = life-death array, nb = neighbour array }

: ARRAY_XY_nb@ square_array_size @ * + array_nb_loc + C@ ;  { XY indicates that the position is given by coordinates }
	
: ARRAY_nb! array_nb_loc + C! ;								{ Otherwise, the position is given by a single index }

: ARRAY_nb@ array_nb_loc + C@ ;

: ARRAY_XY_ld! square_array_size @ * + array_ld_loc + C! ;

: ARRAY_XY_ld@ square_array_size @ * + array_ld_loc + C@ ;

: ARRAY_ld! array_ld_loc + C! ;

: ARRAY_ld@ array_ld_loc + C@ ;

					{ Subroutines }

: UPDATE-LD   { Determines whether a cell lives or dies based on number of neighbours and current state }
	0 births !
	0 deaths !
	square_array_size @ dup * 0 do
    	i ARRAY_nb@
		case
		0 of i ARRAY_ld@ case
			0 of 0 i ARRAY_ld! endof
			1 of 0 i ARRAY_ld! deaths @ 1 + deaths ! endof
			endcase
		endof
		1 of i ARRAY_ld@ case
			0 of 0 i ARRAY_ld! endof
			1 of 0 i ARRAY_ld! deaths @ 1 + deaths !  endof
			endcase 
		endof
		2 of i ARRAY_ld@ case
			0 of 0 i ARRAY_ld! endof
			1 of 1 i ARRAY_ld! endof
			endcase
		endof
		3 of i ARRAY_ld@ case
			0 of 1 i ARRAY_ld! births @ 1 + births ! endof
			1 of 1 i ARRAY_ld! endof
			endcase 
		endof
		4 of i ARRAY_ld@ case
			0 of 0 i ARRAY_ld! endof
			1 of 0 i ARRAY_ld! deaths @ 1 + deaths !  endof
			endcase
		endof
		5 of i ARRAY_ld@ case
			0 of 0 i ARRAY_ld! endof
			1 of 0 i ARRAY_ld! deaths @ 1 + deaths !  endof
			endcase 
		endof
		6 of i ARRAY_ld@ case
			0 of 0 i ARRAY_ld! endof
			1 of 0 i ARRAY_ld! deaths @ 1 + deaths !  endof
			endcase
		endof
		7 of i ARRAY_ld@ case
			0 of 0 i ARRAY_ld! endof
			1 of 0 i ARRAY_ld! deaths @ 1 + deaths !  endof
			endcase 
		endof
		8 of i ARRAY_ld@ case
			0 of 0 i ARRAY_ld! endof
			1 of 0 i ARRAY_ld! deaths @ 1 + deaths !  endof
			endcase 
		endof
		endcase
	loop
;

: CHECK-SURROUNDING-SQUARES { Goes through provided coords and checks if cell is alive or not }
							{ Check for absorbing edges by identifying -1s }
	0 nb-num ! 
	-1 m-1 @ = IF ELSE -1 n-1 @ = IF ELSE
	m-1 @ n-1 @ ARRAY_XY_LD@ 1 = IF nb-num @ 1 + nb-num ! THEN THEN THEN
	-1 n-1 @ = IF ELSE
	m2  @ n-1 @ ARRAY_XY_LD@ 1 = IF nb-num @ 1 + nb-num ! THEN THEN 
	-1 m+1 @ = IF ELSE -1 n-1 @ = IF ELSE
	m+1 @ n-1 @ ARRAY_XY_LD@ 1 = IF nb-num @ 1 + nb-num ! THEN THEN THEN
	-1 m-1 @ = IF ELSE -1 n+1 @ = IF ELSE
	m-1 @ n+1 @ ARRAY_XY_LD@ 1 = IF nb-num @ 1 + nb-num ! THEN THEN THEN
	-1 n+1 @ = IF ELSE
	m2  @ n+1 @ ARRAY_XY_LD@ 1 = IF nb-num @ 1 + nb-num ! THEN THEN 
	-1 m+1 @ = IF ELSE -1 n+1 @ = IF ELSE
	m+1 @ n+1 @ ARRAY_XY_LD@ 1 = IF nb-num @ 1 + nb-num ! THEN THEN THEN
	-1 m-1 @ = IF ELSE
	m-1 @ n2  @ ARRAY_XY_LD@ 1 = IF nb-num @ 1 + nb-num ! THEN THEN 
	-1 m+1 @ = IF ELSE
	m+1 @ n2  @ ARRAY_XY_LD@ 1 = IF nb-num @ 1 + nb-num ! THEN THEN 
	nb-num @ m2 @ n2 @ ARRAY_XY_nb!
;
	

: UPDATE-NB-EC	{ Calculates number of living neighbours and updates nb array with wrap around edges}

	square_array_size @ 0 do
		square_array_size @ 0 do
			I CASE
			0 OF 0 m2 ! 1 m+1 ! square_array_size @ 1 - m-1 ! ENDOF
			square_array_size @ 1 - OF square_array_size @ 1 - m2 ! square_array_size @ 2 - m-1 ! 0 m+1 ! ENDOF
			I dup m2 ! dup 1 + m+1 ! 1 - m-1 ! 
			ENDCASE
			
			J CASE
			0 OF 0 n2 ! 1 n+1 ! square_array_size @ 1 - n-1 ! ENDOF
			square_array_size @ 1 - OF square_array_size @ 1 - n2 ! square_array_size @ 2 - n-1 ! 0 n+1 ! ENDOF
			J dup n2 ! dup 1 + n+1 ! 1 - n-1 ! 
			ENDCASE	 
			
			CHECK-SURROUNDING-SQUARES
		LOOP
	LOOP

;

: UPDATE-NB	{ Calculates number of living neighbours and updates nb array with hard (not wrapped) edges}
			{ Set any out of bounds indexes to -1 }
	square_array_size @ 0 do
		square_array_size @ 0 do
			I CASE
			0 OF 0 m2 ! 1 m+1 ! -1 m-1 ! ENDOF
			square_array_size @ 1 - OF square_array_size @ 1 - m2 ! square_array_size @ 2 - m-1 ! -1 m+1 ! ENDOF
			I m2 ! I 1 + m+1 ! I 1 - m-1 ! 
			ENDCASE
			
			J CASE
			0 OF 0 n2 ! 1 n+1 ! -1 n-1 ! ENDOF
			square_array_size @ 1 - OF square_array_size @ 1 - n2 ! square_array_size @ 2 - n-1 ! -1 n+1 ! ENDOF
			J n2 ! J 1 + n+1 ! J 1 - n-1 ! 
			ENDCASE	 
			
			CHECK-SURROUNDING-SQUARES
		LOOP
	LOOP

;

					{ Callable Functions }

: SHOW-NB-ARRAY  	{ Shows the number of living neighbours array }	
    	square_array_size @ dup * 0 DO
       		square_array_size @ 0 DO
            	array_nb_loc I J + + c@ 3 .R
        	LOOP cr
   	 square_array_size @ +LOOP 
;

: SHOW-LD-ARRAY cr	{ Shows the live-dead array }
    square_array_size @ dup * 0 do
        square_array_size @ 0 do
            array_ld_loc I J + + c@ 3 .R
        LOOP cr
    square_array_size @ +loop 
;


: RANDOM_0-8 		{ Fills neighbour array with random 0-8 numbers and sets live-dead array accordingly }
	cr 
	square_array_size @ dup * 0 do
	9 RND dup i ARRAY_nb! 
	case
	0 of num_0 @ 1+ num_0 ! endof
	1 of num_1 @ 1+ num_1 ! endof
	2 of num_2 @ 1+ num_2 ! endof
	3 of num_3 @ 1+ num_3 ! endof
	4 of num_4 @ 1+ num_4 ! endof
	5 of num_5 @ 1+ num_5 ! endof
	6 of num_6 @ 1+ num_6 ! endof
	7 of num_7 @ 1+ num_7 ! endof
	8 of num_8 @ 1+ num_8 ! endof
	endcase
	loop
	UPDATE-LD
	update-nb-ec

;

: RANDOM 		{ Fills live-dead array with 0s and 1s according to a X/10 probability (currently 3/10) }
	0
	square_array_size @ dup * 0 do
	10 RND 
	case
	0 of 0 i ARRAY_ld! endof
	1 of 0 i ARRAY_ld! endof
	2 of 0 i ARRAY_ld! endof
	3 of 0 i ARRAY_ld! endof
	4 of 0 i ARRAY_ld! endof
	5 of 0 i ARRAY_ld! endof
	6 of 0 i ARRAY_ld! endof
	7 of 1 i ARRAY_ld! endof
	8 of 1 i ARRAY_ld! endof
	9 of 1 i ARRAY_ld! endof
	endcase
	loop
	update-nb-ec
	{ show-ld-array }
;

: OCCUPANCY 		{ Counts number of living/dead }
	0 0 0 0 0 0 0 0 0 num_0 ! num_1 ! num_2 ! num_3 ! num_4 ! num_5 ! num_6 ! num_7 ! num_8 !
	0 alives !
	0 deads !
	square_array_size @ dup * 0 do
	i ARRAY_nb@ 
	case
	0 of num_0 @ 1+ num_0 ! endof
	1 of num_1 @ 1+ num_1 ! endof
	2 of num_2 @ 1+ num_2 ! endof
	3 of num_3 @ 1+ num_3 ! endof
	4 of num_4 @ 1+ num_4 ! endof
	5 of num_5 @ 1+ num_5 ! endof
	6 of num_6 @ 1+ num_6 ! endof
	7 of num_7 @ 1+ num_7 ! endof
	8 of num_8 @ 1+ num_8 ! endof
	endcase
	i Array_ld@
	case
	0 of deads @ 1 + deads ! endof
	1 of alives @ 1 + alives ! endof
	endcase
	loop
	{ show-ld-array }
;

: Generate-data { puts data on the stack in the correct order ready for writing to file }
	num_0 @ num_1 @ num_2 @ num_3 @ num_4 @ num_5 @ num_6 @ num_7 @ num_8 @
	square_array_size @ dup *
	deaths @ births @ deads @ alives @ generation @
	write-data
;

: NEXT-we { Next generation using wrapped edges }
	update-ld
	update-nb-ec
	generation @ 1 + generation !
	occupancy 
	Generate-data

;

: NEXT-ae { Next generation using hard edges }
	update-ld
	update-nb
	generation @ 1 + generation !
	occupancy 
	Generate-data

;



variable xindex
variable yindex 
: unpack-input  { Reads a preset array from a txt file into the live-dead array }
	loadinput
	0 xindex ! 0 yindex !
    input-size @ dup . 0 do 
    unpacked-loc @ I + c@ { find value in unpacking array }
        case
            48 of 0 xindex @ yindex @ ARRAY_XY_ld! xindex @ 1+ xindex ! endof
            49 of 1 xindex @ yindex @ ARRAY_XY_ld! xindex @ 1+ xindex ! endof
            13 of 0 xindex ! yindex @ 1+ yindex ! endof
        endcase
    loop ." input unpacked " 
	update-nb-ec
	;
	


: ASCII-SHOW { Shows wrapped edges life sim in ascii values in the console }
	begin
	next-we
	show-ld-array 
	wipe 
    key? { stops on key press }
	until
;