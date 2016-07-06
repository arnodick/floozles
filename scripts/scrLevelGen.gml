// Goes from left to right of room making blocks until the length of the room has been covered.
for (i = 1; i < argument0; i += 1)
{
    // Generate blocks.
    // If player is entering left side of room, spawn a block with the player on top at the leftmost column.
    if i == 1 and argument2 == 1 and !instance_exists(oPlayerPerson)
    {
        rand = 1;
        instance_create (i * 64, playerSpawnY, oPlayerPerson);
    }
    // Stop 3 blocks forming in a row when spawning on right side.
    else if i == argument0 - 3 and argument2 == 0 and blockCount == 1
    {
        rand = 0;
    }
    // If player is entering right side of room, spawn a block with the player on top at the rightmost column.
    else if i == argument0 - 2 and argument2 == 0 and !instance_exists(oPlayerPerson)
    {
        rand = 1
        instance_create (i * 64 + 32, playerSpawnY, oPlayerPerson);
    }
    else
    {
        rand = irandom(1);
    }
    // If no block is being created at this X coordinate, but a block was made one column to the left of this X coord, then put a single block tile one column back.
    if rand == 0 and blockCount == 1
    {
        tile_add (bTile1Block, 0, 0, 192, 128, i * 64 - 128, 448, 1000000);
        tile_set_blend(tile_layer_find(1000000, i * 64 - 64, 480), argument1);
    }
    // If a block is beaing created at this X coordinate and a block was made one column to the left, create a double block tile.
    else if rand == 1 and blockCount == 1
    {
        tile_add (bTile2Block, 0, 0, 256, 128, i * 64 - 128, 448, 1000000);
        tile_set_blend(tile_layer_find(1000000, i * 64 - 64, 480), argument1);
        // Create a door somewhere past the halfway point of the room if this room is set to have a door.
        if i >= argument0/2 and argument3 == true and !instance_exists(oDoor)
        {
            instance_create (i * 64 - 16, 448, oDoor);
        }
    } 
    // Create a collision block if a wall was created
    if rand == 1 and blockCount < 2
    {
        instance_create (i * 64, 512, oWall);
        blockCount += 1;
        emptyCount = 0;
        // 1/4 chance of an NPC spawning on the block.
        if irandom(4) == 1
        {
            instance_create (i * 64, playerSpawnY, oNpcPerson);
        }
        // If player is entering from middle, spawn them above one of 3 possible columns in the middle fo the map.
        if i >= argument0/2 - 1 and argument2 == 2 and !instance_exists(oPlayerPerson)
        {
            instance_create (i * 64, 0, oPlayerPerson);
        }
    }
    // If no block was created, increment the empty space counter.
    else if emptyCount < 2
    {
        blockCount = 0;
        emptyCount += 1;
    }
    // If there has been 2 empty spaces in a row, automatically make a collision block.
    else
    {
        instance_create (i * 64, 512, oWall);
        blockCount = 1;
        emptyCount = 0;
        // 1/4 chance of an NPC spawning on the block.
        if irandom(4) == 1
        {
            instance_create (i * 64, playerSpawnY, oNpcPerson);
        }
        // If player is entering from middle, spawn them above one of 3 possible columns in the middle fo the map.
        if i >= argument0/2 - 1 and argument2 == 2 and !instance_exists(oPlayerPerson)
        {
            instance_create (i * 64, 0, oPlayerPerson);
        }
    }
}
