function getLast(n)
    local messages = {}
    for i = math.max(1, #Inbox - n + 1), #Inbox do
        table.insert(messages, Inbox[i].From .. ": " .. Inbox[i].Data)
    end
    return table.concat(messages, "\n")
end

function m(n)
    local messages = {}
    for i = math.max(1, #Inbox - n + 1), #Inbox do
        table.insert(messages, Inbox[i].From .. ": " .. Inbox[i].Data)
    end
    return table.concat(messages, "\n")
end