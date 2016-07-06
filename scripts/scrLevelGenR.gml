// Checks every 64 pixels and either make a block at or leave blank the coordinate at i times 64.
for (i = argument0 - 2; i >= 0; i -= 1)
{
    if i == argument0 - 2
    {
        instance_create (i * 64, 512, oWall);
        blockCount += 1;
        emptyCount = 0;
        instance_create (i * 64 + 32, playerSpawnY, oPlayerPerson);
    }
    else
    {
        rand = irandom(1);
        // If no block is being created at this X coordinate, but a block was made one column to the left of this X coord, then put a single block tile one column back.
        if rand == 0 and blockCount == 1
        {
            // Code for moving platforms
            /*
            if irandom(1) == 1
            {
                temp = instance_nearest( (i - 1) * 64, 512, oWall );
                instance_deactivate_object(temp);
                instance_create( ((i - 1) * 64) - 8, 512 - 12, oWallMoving );
            }
            else
            {*/
                tile_add (bTile1Block, 0, 0, 192, 128, i * 64, 448, 1000000);
                tile_set_blend(tile_layer_find(1000000, i * 64, 480), argument1);
            //}
        }
        // If a block is beaing created at this X coordinate
        else if rand == 1 and blockCount == 1
        {
            //tile_add (bTileL, 0, 0, 64, 64, i * 64 - 64, 512, 1000000);
            tile_add (bTile2Block, 0, 0, 256, 128, i * 64 - 64, 448, 1000000);
            tile_set_blend(tile_layer_find(1000000, i * 64 - 64, 480), argument1);
        }
        
        if rand == 1 and blockCount < 2
        {
            instance_create (i * 64, 512, oWall);
            blockCount += 1;
            emptyCount = 0;
            if irandom(4) == 1
            {
                instance_create (i * 64, playerSpawnY, oNpcPerson);
            }
        }
        else if emptyCount < 2
        {
            blockCount = 0;
            emptyCount += 1;
        }
        else
        {
            instance_create (i * 64, 512, oWall);
            blockCount = 1;
            emptyCount = 0;
            if irandom(4) == 1
            {
                instance_create (i * 64, playerSpawnY, oNpcPerson);
            }
        }
    }
}
