local RSGCore = exports['rsg-core']:GetCoreObject()

-- Fungsi helper untuk cek job dalam array
local function isJobInCategory(job, categoryJobs)
    if not job then return false end
    
    if type(categoryJobs) == "string" then
        return job == categoryJobs
    elseif type(categoryJobs) == "table" then
        for _, jobName in ipairs(categoryJobs) do
            if job == jobName then
                return true
            end
        end
    end
    return false
end

-- Register server callback untuk mengambil data players
RSGCore.Functions.CreateCallback('rsg-scoreboard:getPlayerData', function(source, cb)
    local players = RSGCore.Functions.GetPlayers()
    local src = source
    
    local data = {
        totalPlayers = 0,
        medics = 0,
        lawmen = 0,
        wagons = 0,
        saloons = 0,
        ranches = 0,
        ownJob = nil,
        ownJobName = "None",
        ownJobGrade = "",
        ownDuty = false,
        playerId = src,
        serverName = "KERABAT COUNTY"
    }

    for _, id in pairs(players) do
        local Player = RSGCore.Functions.GetPlayer(id)
        if Player then
            data.totalPlayers = data.totalPlayers + 1
            local job = Player.PlayerData.job and Player.PlayerData.job.name
            local grade = Player.PlayerData.job and Player.PlayerData.job.grade.name or ""
            local onduty = Player.PlayerData.job and Player.PlayerData.job.onduty or false

            -- Count job types berdasarkan on duty status
            if onduty then
                if isJobInCategory(job, Config.Jobs.Medic) then 
                    data.medics = data.medics + 1 
                end
                
                if isJobInCategory(job, Config.Jobs.Lawman) then 
                    data.lawmen = data.lawmen + 1 
                end
                
                if isJobInCategory(job, Config.Jobs.Wagon) then 
                    data.wagons = data.wagons + 1 
                end
                
                if isJobInCategory(job, Config.Jobs.Saloon) then 
                    data.saloons = data.saloons + 1 
                end
                
                if isJobInCategory(job, Config.Jobs.Ranch) then 
                    data.ranches = data.ranches + 1 
                end
            end

            -- Get player's own job
            if id == src then 
                data.ownJob = job
                data.ownJobGrade = grade
                data.ownDuty = onduty
                
                -- Format job name dengan grade dan duty status
                if job then
                    if grade and grade ~= "" then
                        data.ownJobName = grade
                    else
                        data.ownJobName = "Worker"
                    end
                    
                    if onduty then
                        data.ownJobName = data.ownJobName .. " (ON DUTY)"
                    else
                        data.ownJobName = data.ownJobName .. " (OFF DUTY)"
                    end
                else
                    data.ownJobName = "Unemployed"
                end
            end
        end
    end

    cb(data)
end)

-- Event handler untuk request data
RegisterNetEvent('rsg-scoreboard:requestData', function()
    local src = source
    
    RSGCore.Functions.TriggerCallback('rsg-scoreboard:getPlayerData', src, function(data)
        TriggerClientEvent('rsg-scoreboard:updateData', src, data)
    end)
end)