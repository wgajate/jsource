NB. script to run all tests for a machine
NB. rough version and not complete

NB. todo - macos and windows

3 : 0''
select. UNAME
case. 'Linux' do.
 j=:     'libj.so'
 javx=:  'libjavx.so'
 javx2=: 'libjavx2.so'
case. 'Darwin' do.
 j=:     'libj.dylib'
 javx=:  'libjavx.dylib'
 javx2=: 'libjavx2.dylib'
case. 'Win' do.
 j=:     'j.dll'
 javx=:  'javx.dll'
 javx2=: 'javx2.dll'
end.
)

output=: jpath'~temp/run_tests.txt'

NB.!while testing - 'RUN 3{.ddall' runit 'libj.so'
runit=: 4 : 0
output fappend~ LF,LF,'************************************************************  ',x,'  ',y,LF
t=. 'echo "load''git/jsource/test/tsu.ijs''\necho CMD" | jbld/j64/bin/jconsole -lib JX >>"OUT"'
t=. t rplc 'CMD';x;'JX';y;'OUT';hostpathsep output
spawn_jtask_ t
)

runall=: 3 : 0
ferase output
'RUN ddall'     runit j
'RUN ddall'     runit javx
'RUN ddall'     runit javx2

'runpacman''''' runit j
'runpacman''''' runit javx
'runpacman''''' runit javx2

'runjd'''''     runit j
'runjd'''''     runit javx
'runjd'''''     runit javx2

check''
)

NB. report important (error) lines in output
check=: 3 : 0
d=. <;._2 fread output
d=. d-.<'0 failed'
b=. 'g'=;{.each d
b=. b+.;+./each(<'failed') E.each d
b=. b+.;+./each(<'error')  E.each d
;(+./b){'all ok';'errors (fread output) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
)