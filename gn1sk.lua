-- gn1sk.lua
-- Script for X-Plane 12 Garmin G1000 PFD (g1000n1)
SimVar("sim/GPS/g1000n1_softkey1")
SimVar("sim/GPS/g1000n1_softkey2")
SimVar("sim/GPS/g1000n1_softkey3")
SimVar("sim/GPS/g1000n1_softkey4")
SimVar("sim/GPS/g1000n1_softkey5")
SimVar("sim/GPS/g1000n1_softkey6")
SimVar("sim/GPS/g1000n1_softkey7")
SimVar("sim/GPS/g1000n1_softkey8")
SimVar("sim/GPS/g1000n1_softkey9")
SimVar("sim/GPS/g1000n1_softkey10")
SimVar("sim/GPS/g1000n1_softkey11")
SimVar("sim/radios/stby_nav1_fine_down")
SimVar("sim/radios/stby_nav2_fine_down")
SimVar("sim/radios/stby_nav1_coarse_up")
SimVar("sim/radios/stby_nav2_coarse_up")
SimVar("sim/GPS/g1000n1_nav_ff")

SimVar("X:SOFTKEY_N1_NO")
SimVar("X:ALT_100_1000")
SimVar("X:NAV_PFD")

SimWrite("X:SOFTKEY_N1_NO", 1)
SimWrite("X:ALT_100_1000", 100)
SimWrite("X:NAV_SK", 0)

function NAV_SK_TOGGLE()
    local stat

    stat = SimRead("X:NAV_SK")
    if stat == 0 then
        stat = 1
    else
        stat=0
    end
    SimWrite("X:NAV_SK", stat)
end


function ALT_TOGGLE()
    local step

    step = SimRead("X:ALT_100_1000")
    if step == 1000 then
        step = 100
    else
        step=1000
    end
    SimWrite("X:ALT_100_1000", step)
end

function ALT_SET(sel)
    local step
    
    step = SimRead("X:ALT_100_1000")

    if step == 100 then 
        if sel == -1 then
            SimCommand("sim/GPS/g1000n1_alt_inner_down")
        elseif sel == 1 then
            SimCommand("sim/GPS/g1000n1_alt_inner_up")
        end
    elseif step == 1000 then
        if sel == -1 then
            SimCommand("sim/GPS/g1000n1_alt_outer_down")
        elseif sel == 1 then
            SimCommand("sim/GPS/g1000n1_alt_outer_up")
        end
    end
end




function PUSH_SOFTKEY()
    local sk

    sk = SimRead("X:SOFTKEY_N1_NO")

    if sk == 1 then
        SimCommand("sim/GPS/g1000n1_softkey1")
    elseif sk == 2 then
        SimCommand("sim/GPS/g1000n1_softkey2")
    elseif sk == 3 then
        SimCommand("sim/GPS/g1000n1_softkey3")
    elseif sk == 4 then
        SimCommand("sim/GPS/g1000n1_softkey4")
    elseif sk == 5 then
        SimCommand("sim/GPS/g1000n1_softkey5")
    elseif sk == 6 then
        SimCommand("sim/GPS/g1000n1_softkey6")
    elseif sk == 7 then
        SimCommand("sim/GPS/g1000n1_softkey7")
    elseif sk == 8 then
        SimCommand("sim/GPS/g1000n1_softkey8")
    elseif sk == 9 then
        SimCommand("sim/GPS/g1000n1_softkey9")
    elseif sk == 10 then
        SimCommand("sim/GPS/g1000n1_softkey10")
    elseif sk == 11 then
        SimCommand("sim/GPS/g1000n1_softkey11")
    end
end

function PUSH_NAV1()
    SimCommand("sim/GPS/g1000n1_nav_ff")
end

function SW_SOFTKEY(sel)
    local sk
    local sk_new

    sk = SimRead("X:SOFTKEY_N1_NO")
    sk_new = sk + sel
    if sk_new ==12 then
        sk_new = 1
    elseif sk_new == 0 then
        sk_new = 11
    end
    
        SimWrite("X:SOFTKEY_N1_NO", sk_new)
end

function SW_NAV1(sel)
        
    if sel == -1 then
        SimCommand("sim/radios/stby_nav1_fine_down")
    elseif sel == 1 then
        SimCommand("sim/radios/stby_nav1_coarse_up")
    end
    
end

function SW_NAV_SK(sel)
    local nav_or_sk

    nav_or_sk = SimRead("X:NAV_SK")

    if nav_or_sk == 0 then
        SW_SOFTKEY(sel)
    elseif nav_or_sk ==1 then
        SW_NAV1(sel)
    end
end

function PUSH_KEY()
local nav_or_sk

    nav_or_sk = SimRead("X:NAV_SK")
    if nav_or_sk == 0 then
        PUSH_SOFTKEY()
    elseif nav_or_sk == 1 then
        PUSH_NAV1()
    end
end 
