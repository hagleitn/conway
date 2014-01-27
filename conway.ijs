require'viewmat' 
require'gl2'
coclass 'conway'
coinsert'jgl2'

NB. arrage original matrix in a 3x3 pattern
enlarge =: (*&3@#) $ [ ,"1^:2 [

NB. original size + 1 item in each direction
spec =: 2 2 $ 2 # (-&1@%&3@#) , (+&2@%&3@#)

NB. keep original matrix plus "edges" (conway on torus) 
torus =: (spec ([;.0) [) @ enlarge

NB. pick middle element from 3x3
middle =: (<1 1)&{

NB. Conway rules: cells live on if they have 3 or 4 neighbors
live =: { & 0 0 1 1 0 0 0 0 0 @ countneighbor

NB. Conway rules: dead cells come alive if they have exactly 3 neighbors
dead =: =&3 @ countneighbor

NB. pics whether a cell is dead or alive in the next generation
applyrules =: (dead ` live) @. middle

NB. computes number of neighbors
countneighbor =: (+/^:2) - middle

NB. Applies rules to every 3x3 sub-matrix (including 'edges')
next =: (1 1,:3 3) & (applyrules;._3) @ torus

NB. Generate random (1s + 0s) in nxn matrix
random =: (2#[) $ (?@#&2@^&2)

NB. simple view with isigraph
DISP =: 0 : 0 
pc disp;
minwh 400 400;cc gra isigraph;
pas 10 10; pcenter;
)

NB. paint verb
disp_gra_paint =: 3 : 0 
glclear''
viewmatcc_jviewmat_ GAME;'gra'
)

NB. open window and start animation
start =: 3 : 0
500 start y
:
GAME =: random y
wd DISP
wd'pshow'
sys_timer_z_ =: iterate_conway_
wd'timer ',":x
)

NB. stop animation close window
stop =: 3 : 0
wd'pclose'
wd'timer 0'
erase 'sys_timer_z_'
)

NB. timer callback
iterate =: 3 : 0
GAME =: next GAME
glpaint''
)

NB. export some verbs
conwaystart_z_ =: start_conway_
conwaystop_z_ =: stop_conway_
conwayrandom_z_ =: random_conway_
conwaynext_z_ =: next_conway_
