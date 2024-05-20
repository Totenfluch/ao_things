GameState = GameState or {}
OwnerMove = ""
PlayerMove = ""
Player = ""

PrevPlayer = ""


Handlers.add(
    "Play",
    Handlers.utils.hasMatchingTag("Action", "Play"),
    function(msg)
        local player = msg.From
        local move = msg.Data
        if msg.Data ~= "s" and msg.Data ~= "r" and msg.Data ~= "p" then
            Handlers.utils.reply("Error: Input must be 's', 'r', or 'p'.")(msg)
            return
        end

        if player == ao.id then
            OwnerMove = move
        else
            PlayerMove = move
            Player = player
        end

        if PlayerMove == "" or OwnerMove == "" then
            if player ~= ao.id then
                Handlers.utils.reply("Waiting for other player to make a move.")(msg)
            end
            ao.send({ Target = ao.id, Data = "Waiting for you to make a move."})
            return
        end

        if PlayerMove == OwnerMove then
            ao.send({ Target = Player, Data = "Tie!" .. PlayerMove .. " vs " .. OwnerMove})
            ao.send({ Target = Player, Data = "Tie!" .. PlayerMove .. " vs " .. OwnerMove})
        elseif (PlayerMove == "r" and OwnerMove == "s") or
            (PlayerMove == "s" and OwnerMove == "p") or
            (PlayerMove == "p" and OwnerMove == "r") then
            ao.send({ Target = Player, Data = "You Won!" .. PlayerMove .. " vs " .. OwnerMove})
            ao.send({ Target = ao.id, Data = "You Lost!" .. PlayerMove .. " vs " .. OwnerMove})
        else
            ao.send({ Target = Player, Data = "You Lost!" .. PlayerMove .. " vs " .. OwnerMove})
            ao.send({ Target = ao.id, Data = "You Won!" .. PlayerMove .. " vs " .. OwnerMove})
        end

        PlayerMove = ""
        OwnerMove = ""
        PrevPlayer = Player
        Player = ""
    end
)
