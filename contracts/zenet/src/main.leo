import zenet_board_v0_0_1.leo;
//import zenet_bitwise_v0_0_1.leo;
//import zenet_dice_v0_0_1.leo;
import zenet_cell_v0_0_1.leo;
import vrf_v0_0_1.leo;

program zenet.aleo {

    mapping dicerolls: u8 => u8;

    // Auxiliary function that returns true if i-th bit of 'number' is '1'
    inline get_bit_inline(number: u32, i: u8) -> bool {
        let mask: u32 = 1u32 << i-1u8;
        return number.and(mask) > 0u32;
    }

    // Auxiliary function that sets the i-th bit of 'number' to 'bit'
    inline set_bit_inline(number: u32, i: u8, bit: bool) -> u32{
        let mask: u32 = 1u32 << i-1u8;
        if bit {
            return number.or(mask);
        } else {
            return number.and(mask.not());
        }
    }

    // Zenet boards are represented by 32-bit, unsigned integers. The board
    // contains 30 cells, so a u32 works just fine.
    // There are two u32 fields: 
    // cell_state: represents whether or not a given cell is occupied or not:
    //   - cell_state = 0 -> free
    //   - cell_state = 1 -> occupied
    // cell_occ: represents who is the occupant: 
    //   - cell_occ = 0 -> player 1
    //   - cell_occ = 1 -> player 2
    

    // Given that the ownership of the board is passed back and forth between 
    // both players, we use a separate record to keep track of each player's
    // invisible pieces. The 'positions' field is also a 32-bit integer:
    //  - positions = 1 -> there's an invisible piece at that position
    //  - positions = 0 -> there's no invisible piece at that position


    // Used to get the opponent's address
    function get_opponent(board: zenet_board_v0_0_1.leo/Board.record) -> address {
        if board.owner == board.p1 {
            return board.p2;
        } else {
            return board.p1;
        }
    }


    transition get_random_bit() -> bool {
        // Authenticate proposer.


        // Return a new record for the proposal.
        return true
        then finalize();
    }
    // Create a new proposal in the "tickets" mapping.
    finalize get_random_bit() {

        let current_value: u8 = Mapping::get_or_use(dicerolls, 0u8, 0u8);
let result:u8 = 0u8;



      // Update the appropriate entry with the given move.
        if (ChaCha::rand_bool()==true) {
           result+=1u8;
        }
      // Update the appropriate entry with the given move.
        if (ChaCha::rand_bool()==true) {
           result+=1u8;
        }

      // Update the appropriate entry with the given move.
        if (ChaCha::rand_bool()==true) {
           result+=1u8;
        }
              // Update the appropriate entry with the given move.
        if (ChaCha::rand_bool()==true) {
           result+=1u8;
        }
        Mapping::set(dicerolls, 0u8,result);
    }



transition roll_dice(player1:u8) -> u8 {
    
    //let dice : bool = zenet_dice_v0_0_1.leo/get_random_bit();
    //return dice;
return 0u8 then finalize();
}

 finalize roll_dice() {
let a:u8 = 0u8 + 1u8;
       //Mapping::set(tickets, id, 0u64);

 }
    // Creates a new Board record and sets the owner to the caller, which from
    // now on will be known as player 1. It returns two InvisiblePieces records,
    // one for each player. Both are initialized to 0u32 (there are no invisible
    // pieces at the start).
    // The initial position of the pieces is as follows, where '0' means empty, '1'
    // means player 1 and '2' means player 2:
    // 
    // | 1 | 2 | 1 | 2 | 1 | 2 | 1 | 2 | 1 | 2 |
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 
    // 
    // The corresponding values of 'cell_state' and 'cell_occ' are
    //
    //   - cell_state:
    //
    //  LSB
    //   |
    //   v
    // | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 |
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |    =   1010101010b = 682
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    //                                       ^
    //                                       |
    //                                      MSB
    //
    //   - cell_occ:
    //
    // | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |    =   1111111111b = 1023
    // | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    // 
    transition new(
        opponent: address
    ) -> (zenet_board_v0_0_1.leo/Board.record, zenet_board_v0_0_1.leo/InvisiblePieces.record, zenet_board_v0_0_1.leo/InvisiblePieces.record) {




        //vrf_v0_0_1.leo/init_game_hash();
        //vrf_v0_0_1.leo/get_random();

/*
leo run get_random \
  "{ \
  user: aleo1cd3v453y0n0ntl2gw7l3fpksp2ae9s46rzlt87mup2gth0asygzq9k5q0l, \
  game_hash: 7571057015730941990143459213534650058818343735290421916417010434384442343523field, \
  random_value: 1field, \
  current_turn: 0field \
  }" \
  "{ \
  user: aleo1k4pdvq6gh8duzqd3g4p852p2j7xn76dhfmx0ds9lj6sg96g7k5xqsxvc5y, \
  game_hash: 7571057015730941990143459213534650058818343735290421916417010434384442343523field, \
  user_secret_hash: 1916866650744865271241509820990367882428103130043613420607863419653524065772field \
  }" \
  101field
*/

        let opponent_address: address = opponent;
        let state: Board = zenet_board_v0_0_1.leo/get_board(self.caller,1023u32,682u32,self.caller,opponent_address);
        let ip1: InvisiblePieces = zenet_board_v0_0_1.leo/get_ip(self.caller,0u64,0u32);
        let ip2: InvisiblePieces = zenet_board_v0_0_1.leo/get_ip(opponent_address,0u64,0u32);


 //    cell_state: 1023u32, // 00 0000000000 0000000000 1111111111
        //    cell_occ: 682u32, // 00 0000000000 0000000000 1010101010

        return ( state,ip1,ip2);
    }




    // This function is used to execute a move. It consumes two records:
    //   - Board: the current state of the board as generated by the last player to play
    //   - InvisiblePieces: the current positions for the invisible pieces of the current player
    //
    // It also produces two new records:
    //   - Board: the board after executing the move. If the move was invalid, the board
    //                     will remain the same. The owner of this record is the player whose turn is next 
    //   - InvisiblePieces: the updated InvisiblePieces record after executing the move.
    //
    transition move(
        origin_cell: u8, 
        dice: u8, 
        board: zenet_board_v0_0_1.leo/Board.record, 
        ip: zenet_board_v0_0_1.leo/InvisiblePieces.record
    ) -> (zenet_board_v0_0_1.leo/Board.record, zenet_board_v0_0_1.leo/InvisiblePieces.record) {
        // Validates that the board coming from the opponent is consistent with the invisible
        // pieces of the current player (if any). The owner of this record is the player that executed this move.
        assert (zenet_board_v0_0_1.leo/validate_board(board, ip));
//        let cells: Cells = get_invisible_pieces(board, ip);

        let cells: Cells = zenet_cell_v0_0_1.leo/get_cell(8u32,10u32);

        assert(1u8 <= dice && dice <= 5u8);
        let target_cell: u8 = origin_cell + dice;
        let player: u8 = zenet_cell_v0_0_1.leo/get_cell_occupant_external(cells, origin_cell);
        assert(player == 1u8 || player == 2u8);

        let target_cell_occupant: u8 = zenet_cell_v0_0_1.leo/get_cell_occupant_external(cells, target_cell);
        assert(target_cell_occupant != player);

        let target_empty: bool = target_cell_occupant == 0u8; 
        let protected: bool = zenet_cell_v0_0_1.leo/piece_is_protected(cells, target_cell);
        let valid_move: bool = !target_empty && !protected || target_empty && !protected;
        assert( valid_move );

        cells = zenet_cell_v0_0_1.leo/move_or_exchange_piece(cells, origin_cell, target_cell,target_empty);
        
        let ip_positions: u32 = ip.positions;


        if get_bit_inline(ip_positions, origin_cell) {
                ip_positions = set_bit_inline(ip_positions, origin_cell, false);
                ip_positions = set_bit_inline(ip_positions, target_cell, true);
        }



        // By default, the next player is the current player.
        let next_player: address = board.owner;
        //let ip_positions: u32 = ip.positions;

        // If dice is 2 or 3, the opponent plays next. If it's 1, 4 or 5, the current player plays again.
        if dice == 2u8 || dice == 3u8 {
            next_player = get_opponent(board);
        }

        let state: Board = zenet_board_v0_0_1.leo/get_board(self.caller,1023u32,682u32, self.caller, board.p2);
        let ip_temp: InvisiblePieces = zenet_board_v0_0_1.leo/get_ip(ip.owner,ip.gates, ip_positions);
        //    cell_state: 1023u32, // 00 0000000000 0000000000 1111111111
        //    cell_occ: 682u32, // 00 0000000000 0000000000 1010101010

        return ( state,ip_temp);
    }

}