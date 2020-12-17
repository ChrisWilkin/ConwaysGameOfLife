variable test-file-id                             { Create Variable to hold file id handle }
variable input-size
variable unpacked-loc

: make-test-file                                  { Create a test file to read / write to  }
  s" C:\Users\Chris\Documents\University\Year 3\Labs\D3\LifeswData_400x400a_3.dat" r/w create-file drop  { Create the file } 
  test-file-id !
;

 
: open-test-file                                  { Open the file for read/write access    }
  s" C:\Users\Chris\Documents\University\Year 3\Labs\D3\Spaceship.txt" r/w open-file drop    { Not needed if we have just created     }
  dup test-file-id ! dup . file-size drop drop input-size !          { File loc, data size,         }                                
;

: close-test-file                                 { Close the file pointed to by the file  }
  test-file-id @                                  { handle.                                }
  close-file drop
; 


: test-file-size                                  { Leave size of file on top of stack as  }
  test-file-id @                                  { a double prescision integer if the     }
  file-size drop                                  { file is open.                          }
;


							{ READING A FILE }
: make-unpacking-array input-size @ ALLOCATE drop dup input-size @ 0 FILL unpacked-loc ! ;
{ creates block of memory large enough to unpack file and fills with zeroes, saves location }

: read-input-file unpacked-loc @ input-size @ test-file-id @ read-line drop drop drop ;

							{ Writing to a file }

: write-file-header 
  s" Gen, Live, Dead, Birth, Death, 8, 7, 6, 5, 4, 3, 2, 1, 0, " test-file-id @ write-line drop { Writes single lines of text to a file }
 ;


: Write-blank-data                                         { Write an empty line to the file       }
  s"  " test-file-id @ write-file drop
;


: Write-data    { 0, - ,8, array-len, deaths, births, dead, alive, generation }
	(.) test-file-id @ write-file drop
	Write-blank-data
	(.) test-file-id @ write-file drop
	Write-blank-data
	(.) test-file-id @ write-file drop
	Write-blank-data
	(.) test-file-id @ write-file drop
	Write-blank-data
	(.) test-file-id @ write-file drop
	Write-blank-data
	swap 100 * over / (.) test-file-id @ write-file drop 
	Write-blank-data
  	swap 100 * over / (.) test-file-id @ write-file drop
	Write-blank-data
	swap 100 * over / (.) test-file-id @ write-file drop 
	Write-blank-data
	swap 100 * over / (.) test-file-id @ write-file drop
	Write-blank-data
	swap 100 * over / (.) test-file-id @ write-file drop
	Write-blank-data
	swap 100 * over / (.) test-file-id @ write-file drop
	Write-blank-data
	swap 100 * over / (.) test-file-id @ write-file drop 
	Write-blank-data
	swap 100 * over / (.) test-file-id @ write-file drop 
	Write-blank-data
	swap 100 * over / (.) test-file-id @ write-line drop

;



								{ CALLABLE FUNTIONS }             

: loadinput
	open-test-file
	make-unpacking-array
	read-input-file
	close-test-file
;

