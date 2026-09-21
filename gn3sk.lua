SimVar("sim/GPS/g1000n3_softkey1")
SimVar("sim/GPS/g1000n3_softkey2")
SimVar("sim/GPS/g1000n3_softkey3")
SimVar("sim/GPS/g1000n3_softkey4")
SimVar("sim/GPS/g1000n3_softkey5")
SimVar("sim/GPS/g1000n3_softkey6")
SimVar("sim/GPS/g1000n3_softkey7")
SimVar("sim/GPS/g1000n3_softkey8")
SimVar("sim/GPS/g1000n3_softkey9")
SimVar("sim/GPS/g1000n3_softkey10")
SimVar("sim/GPS/g1000n3_softkey11")

SimVar("sim/instruments/barometer_down")
SimVar("sim/instruments/barometer_up")
SimVar("sim/radios/obs_HSI_down")
SimVar("sim/radios/obs_HSI_up")

SimVar("X:SOFTKEY_N3_NO")
SimVar("X:NAV_SK3")
SimVar("X:CRS_BARO")

SimWrite("X:SOFTKEY_N3_NO", 1)
SimWrite("X:NAV_SK3", 0)
SimWrite("X:CRS_BARO", 0)

function NAV_SK3_TOGGLE()
    local stat

    stat = SimRead("X:NAV_SK3")
    if stat == 0 then
        stat = 1
    else
        stat=0
    end
    SimWrite("X:NAV_SK3", stat)
end



function SW_SOFTKEY_CDI()
    SimCommand("sim/GPS/g1000n3_softkey6")
end

function PUSH_SOFTKEY()
    local sk

    sk = SimRead("X:SOFTKEY_N3_NO")

    if sk == 1 then
        SimCommand("sim/GPS/g1000n3_softkey1")
    elseif sk == 2 then
        SimCommand("sim/GPS/g1000n3_softkey2")
    elseif sk == 3 then
        SimCommand("sim/GPS/g1000n3_softkey3")
    elseif sk == 4 then
        SimCommand("sim/GPS/g1000n3_softkey4")
    elseif sk == 5 then
        SimCommand("sim/GPS/g1000n3_softkey5")
    elseif sk == 6 then
        SimCommand("sim/GPS/g1000n3_softkey6")
    elseif sk == 7 then
        SimCommand("sim/GPS/g1000n3_softkey7")
    elseif sk == 8 then
        SimCommand("sim/GPS/g1000n3_softkey8")
    elseif sk == 9 then
        SimCommand("sim/GPS/g1000n3_softkey9")
    elseif sk == 10 then
        SimCommand("sim/GPS/g1000n3_softkey10")
    elseif sk == 11 then
        SimCommand("sim/GPS/g1000n3_softkey11")
    end
end

function SW_SOFTKEY(sel)
    local sk
    local sk

    sk = SimRead("X:SOFTKEY_N3_NO")
    sk_new = sk + sel
    if sk_new ==12 then
        sk_new = 1
    elseif sk_new == 0 then
        sk_new = 11
    end
    
        SimWrite("X:SOFTKEY_N3_NO", sk_new)
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

    nav_or_sk = SimRead("X:NAV_SK3")

    if nav_or_sk == 0 then
        SW_SOFTKEY(sel)
    elseif nav_or_sk ==1 then
        SW_NAV1(sel)
    end
end

function PUSH_NAV1()
    SimCommand("sim/GPS/g1000n1_nav_ff")
end

function PUSH_KEY()
local nav_or_sk

    nav_or_sk = SimRead("X:NAV_SK3")
    if nav_or_sk == 0 then
        PUSH_SOFTKEY()
    elseif nav_or_sk == 1 then
        PUSH_NAV1()
    end
end 

-- Switch Knob between CRS and BARO

function CRS_BARO_TOGGLE()
    local stat

    stat = SimRead("X:CRS_BARO")
    if stat == 0 then
        stat = 1
    else
        stat=0
    end
    SimWrite("X:CRS_BARO", stat)
end

function SW_BARO(sel)
    
    if sel == -1 then
        SimCommand("sim/instruments/barometer_down")
    elseif sel == 1 then
        SimCommand("sim/instruments/barometer_up")
    end 
end

function SW_CRS(sel)
        
    if sel == -1 then
        SimCommand("sim/radios/obs_HSI_down")
    elseif sel == 1 then
        SimCommand("sim/radios/obs_HSI_up")
    end
end

function SW_CRS_BARO(sel)
    local crs_or_baro

    crs_or_baro = SimRead("X:CRS_BARO")

    if crs_or_baro == 0 then
        SW_BARO(sel)
    elseif crs_or_baro ==1 then
        SW_CRS(sel)
    end
end
