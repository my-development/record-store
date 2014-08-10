record-store
============

This sample program helps manage a little record store inventory. 

The program will be able to do following 3 things: 
1) load delivery manifests from text files
2) search inventory
3) remove items from the inventory by purchase

Each item in the inventory is described by the artist's name, the album title, 
the release year of the album, and the media format.


Requirment to run this program:
1) Ruby 2.0
2) Rails 3.2.X
3) mysql gem
4) create a databse call "record_store"
5) ruby schema.rb to create the tables 
   #please comment out line 34 for first time "Schema.down"

Commands to run this program:
1) load inventroy file:
   ruby load_inventory.rb <file_name>  # valid file type is csv and pipe
    example: 
    ruby load_inventory.rb music_bucket.pipe
    ruby load_inventory.rb sound_supplier.csv
   
   file format:
   csv: 
    The comma-separated format has one line per inventory item, with the columns in the following order:
    Artist,Title,Format,Release year
   Pipe:
    The pipe-delimited format has the columns in the following order:
    Quanitity | Format | Release year | Artist | Title
   
2) Create new media format of the album:
   ruby new_format.rb <new_media>
   
3) Seach albums by artist, album and release year
   ruby search_inventory.rb <field column> <value>
   Artist: <artist name>
   Album: <album title>
   Released: <release year>
   Format: CD Quantity: <cd quantity>) InventoryId: <cd inventory identifier>
   Format: Tape Quantity: <tape quantity> InventoryId: <tape inventory identifier>
   Format: Vinyl Quantity: <vinyl quantity> InventoryId: <vinyl inventory identifier>

    example:
      ruby search_inventory.rb artist 'Pink Floyd'
       output:
         Artist: Pink Floyd
         Album: The Wall
         Released: 1979
          Format: Vinyl Quantity: 5 InventoryId: 9

         Artist: Pink Floyd
         Album: The Dark Side of the Moon
         Released: 1973
          Format: CD Quantity: 6 InventoryId: 10

         Artist: Pink Floyd
         Album: Meddle
         Released: 1971
          Format: Vinyl Quantity: 2 InventoryId: 5
      ruby search_inventory.rb album 'Meddle'
       output:
         Artist: Pink Floyd
         Album: Meddle
         Released: 1971
          Format: Vinyl Quantity: 2 InventoryId: 5
      ruby search_inventory.rb release_year 1988
       output:  
        Artist: Paula Abdul
        Album: Forever Your Girl
        Released: 1988
          Format: CD Quantity: 1 InventoryId: 1
      
4)Purchase a album:
   ruby purchase.rb <InventoryId>
    example:
      ruby purchase.rb 9
       output:
         Removed 1 vinyl of The Wall from the inventory
