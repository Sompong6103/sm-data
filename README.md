# sm-data

### What can be done?
> Can check the number of occupations online, every occupation

> You can check the player who is online.

### Requirement
> ESX => https://github.com/ESX-Org/es_extended

### Code examples

```lua
-- Client Side

TriggerEvent('sm-data:getData', 'Name of the desired job', function(results)
    print(results) -- Number that is online in the server.
    if results >= 2 then
        -- When when a career that needs more than 2 online will do this line
    else
        -- When when the required online career is less than 2, it will do this line.
    end
end)

TriggerEvent('sm-data:getData', 'allplayer', function(results) -- Check the number of players in the entire server.
    print(results) -- The number of results
end)

TriggerEvent('sm-data:getData', 'police', function(results) -- Check the number of police in the entire server.
    print(results) -- The number of results
end)

TriggerEvent('sm-data:getData', 'ambulance', function(results) -- Check the number of ambulance in the entire server.
    print(results) -- The number of results
end)
```


```lua
-- Server Side

TriggerClientEvent('sm-data:getData', source, 'Name of the desired job', function(results)
    print(results) -- Number that is online in the server.
    if results >= 2 then
        -- When when a career that needs more than 2 online will do this line
    else
        -- When when the required online career is less than 2, it will do this line.
    end
end)

TriggerClientEvent('sm-data:getData', source, 'police', function(results)
    print(results) -- The number of results
end)
```
