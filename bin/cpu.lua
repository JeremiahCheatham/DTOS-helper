function conky_mycpus()
    local numcpus = 1
    local listcpus = ""
    local file = io.popen("grep -c processor /proc/cpuinfo")
    if file then
        numcpus = file:read("*n")
        file:close()
    end
    if numcpus < 5 then
        for i = 1,numcpus
            do listcpus = listcpus.."${cpubar cpu"..tostring(i).." 10}\n"
        end
    elseif numcpus < 17 then
        for i = 1,numcpus,2
            do listcpus = listcpus.."${cpubar cpu"..tostring(i).." 10,125}${offset 10}${cpubar cpu"..tostring(i+1).." 10,125}\n"
        end
    else
        for i = 1,numcpus,4
            do listcpus = listcpus.."${cpubar cpu"..tostring(i).." 10,58}${offset 9}${cpubar cpu"..tostring(i+1).." 10,58}${offset 10}${cpubar cpu"..tostring(i+2).." 10,58}${offset 9}${cpubar cpu"..tostring(i+3).." 10,58}\n"
        end
    end

    return listcpus
end

conky_mycpus()
