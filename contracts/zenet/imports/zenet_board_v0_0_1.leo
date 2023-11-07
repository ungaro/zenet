program zenet_board_v0_0_1.aleo {



    record Board {
        owner: address,
        gates: u64,
        cell_state: u32,
        cell_occ: u32,
        p1: address,
        p2: address
    }

 record InvisiblePieces {
        owner: address,
        gates: u64,
        positions: u32
    }


    // // This struct allows us to pass the state and occupant of a cell



    // Returns true if the resulting board after the opponent's move is consistent
    // with the current player's invisible pieces. For example, the opponent might
    // have moved a piece to a cell where there is an invisible piece that belongs
    // to the current player.
    transition validate_board2(board: Board) -> bool {
       return true;
     }

    function validate_board(board: Board, ip: InvisiblePieces) -> bool {
        if board.owner == board.p1 {
            return board.cell_state.and(board.cell_occ.and(ip.positions)) == 0u32;
        } else {
            return board.cell_state.and(ip.positions.and(board.cell_occ.not())) == 0u32;
        }
     }


/*
    function add_invisible_pieces(board: Board, ip: InvisiblePieces) ->   Cells {
        let cell_state: u32 = board.cell_state.or(ip.positions);
        let cell_occ: u32 = board.cell_occ;
        if board.owner == board.p2 {
            cell_occ = board.cell_occ.or(ip.positions);
        }
        return Cells {
            state: cell_state,
            occupant: cell_occ
        };     }

*/



/*
    function add_invisible_pieces(board: Board, ip: InvisiblePieces) -> zenet_cell_v0_0_1.leo/Cells.record {
        let cell_state: u32 = board.cell_state.or(ip.positions);
        let cell_occ: u32 = board.cell_occ;
        if board.owner == board.p2 {
            cell_occ = board.
            cell_occ.or(ip.positions);
        }

        let temp_cells : Cells =  get_cell(cell_state,cell_occ);
        return temp_cells;
     }

    // Adds the current player's invisible pieces to the board, so that 
    // the current player can make their move. These invisible pieces
    // will be removed afterwards, before sending the board to the 
    // opponent.
    function add_invisible_pieces(board: zenet_board_v0_0_1.leo/Board.record, ip: zenet_board_v0_0_1.leo/InvisiblePieces.record) -> Cells {
        let cell_state: u32 = board.cell_state.or(ip.positions);
        let cell_occ: u32 = board.cell_occ;
        if board.owner == board.p2 {
            cell_occ = board.cell_occ.or(ip.positions);
        }
        return Cells {
            state: cell_state,
            occupant: cell_occ
        };
     }
*/


 // Returns a new board state that has been started.
    // Fails if this board has been started before.
    //transition start_board(
    transition get_board(
        // The record of the board to start. A board can only be started once.
        owner:address,
        cell_state:u32,
        cell_occ:u32,
        player: address,
        opponent: address,
    ) -> Board {
        // Ensure this board hasn't been used to start a game before.
        //assert(!board.game_started);

        return Board {
            owner: player,
            gates: 0u64,
            cell_state: cell_state, // 00 0000000000 0000000000 1111111111
            cell_occ: cell_occ, // 00 0000000000 0000000000 1010101010
            p1: player,
            p2: opponent,
        };
    }

    transition get_ip(
        // The record of the board to start. A board can only be started once.
        owner:address,
        gates:u64,
        positions:u32,
 
    ) -> InvisiblePieces {
        // Ensure this board hasn't been used to start a game before.
        //assert(!board.game_started);

        return  InvisiblePieces {
                        owner: owner,
                        gates: gates,
                        positions: positions
                    };
    }







   function get_cell_type(i: u8) -> u8 {
        if i == 15u8 {          // Cell #15 = House of Second Life (Invisibility)
            return 1u8;         
        } else if i == 26u8 {   // Cell #26 = House of Beauty
            return 2u8;
        } else if i == 27u8 {   // Cell #27 = House of Waters
            return 3u8;
        } else if i == 28u8 {   // Cell #28 = House of Three Judges
            return 4u8;
        } else if i == 29u8 {   // Cell #29 = House of Two Judges
            return 5u8;
        } else if i == 30u8 {   // Cell #30 = House of Horus
            return 6u8;
        } else {
            return 0u8;
        }
    }


/*
            cell_state: 1023u32, // 00 0000000000 0000000000 1111111111
            cell_occ: 682u32, // 00 0000000000 0000000000 1010101010
*/

/*
    record InvisiblePieces {
        owner: address,
        gates: u64,
        positions: u32
    }

    // This struct allows us to pass the state and occupant of a cell
    // with a single variable.
    struct Cells {
        state: u32,
        occupant: u32,
    }




    inline get_cell_type(i: u8) -> u8 {
        if i == 15u8 {          // Cell #15 = House of Second Life (Invisibility)
            return 1u8;         
        } else if i == 26u8 {   // Cell #26 = House of Beauty
            return 2u8;
        } else if i == 27u8 {   // Cell #27 = House of Waters
            return 3u8;
        } else if i == 28u8 {   // Cell #28 = House of Three Judges
            return 4u8;
        } else if i == 29u8 {   // Cell #29 = House of Two Judges
            return 5u8;
        } else if i == 30u8 {   // Cell #30 = House of Horus
            return 6u8;
        } else {
            return 0u8;
        }
    }


    // Returns true if the resulting board after the opponent's move is consistent
    // with the current player's invisible pieces. For example, the opponent might
    // have moved a piece to a cell where there is an invisible piece that belongs
    // to the current player.
    function validate_board(board: Board, ip: InvisiblePieces) -> bool {
        if board.owner == board.p1 {
            return board.cell_state.and(board.cell_occ.and(ip.positions)) == 0u32;
        } else {
            return board.cell_state.and(ip.positions.and(board.cell_occ.not())) == 0u32;
        }
     }




    // Function to get the occupant of the i-th cell according to the following convention:
    // i-th cell is empty: returns 0u8
    // i-th cell is occupied by player 1: returns 1u8
    // i-th cell is occupied by player 2: returns 2u8
    function get_cell_occupant_external(cells: Cells, i: u8) -> u8 {
        let is_occupied: bool = get_bit(cells.state, i);
        if is_occupied {
            return get_bit(cells.occupant, i) ? 2u8 : 1u8;
        } else {
            return 0u8;
        }
    }


    inline get_cell_occupant(cells: Cells, i: u8) -> u8 {
        let is_occupied: bool = get_bit(cells.state, i);
        if is_occupied {
            return get_bit(cells.occupant, i) ? 2u8 : 1u8;
        } else {
            return 0u8;
        }
    }

    // Function to set the occupant of a cell. Takes care of setting both the 'state' and
    // 'occupant' fields accordingly.
    inline set_cell_occupant(cells: Cells, cell: u8, occ: u8) -> Cells {
        // if occ==1u8 (player1) then bit=0, if occ==2u8 (player2) then bit=1;
        let bit: bool = occ == 2u8;
        return Cells {
            state: set_bit(cells.state, cell, true), // the cell is now occupied by a player, thus state = 1
            occupant: set_bit(cells.occupant, cell, bit),
        };
    }


    // Function to clear a cell.
    function clear_cell(cells: Cells, cell: u8) -> Cells {
        return Cells {
            state: set_bit(cells.state, cell, false),
            occupant: set_bit(cells.occupant, cell, false),
        };
    }

    // Function to clear a cell.
    inline clear_cell_inline(cells: Cells, cell: u8) -> Cells {
        return Cells {
            state: set_bit(cells.state, cell, false),
            occupant: set_bit(cells.occupant, cell, false),
        };
    }



    // Returns true if the piece that the current player chose to move
    // in fact belongs to the current player.
    function piece_is_valid(origin_cell: u8, owner: address, p1: address, p2: address, cells: Cells) -> bool {
        let player: u8 = get_cell_occupant(cells, origin_cell);
        if player == 1u8 {
            return owner == p1;
        } else if player == 2u8 {
            return owner == p2;
        } else {
            return false;
        }
    }

    // In Zenet, an opponent's protected piece cannot be the target of a move,
    // which means that it cannot be exchanged for the current player's piece.
    // This function returns true if the piece located at a given cell is protected.
    function piece_is_protected(cells: Cells, cell: u8) -> bool {
        // Pieces on cells 26 through 30 are always protected
        if (26u8 <= cell && cell <= 30u8) {
            return true;    
        }
        // If the cell is empty, it makes no sense to ask for protectedness, so
        // we return false.
        let occ: u8 = get_cell_occupant(cells, cell);
        if occ == 0u8 {
            return false;
        }
        // If any of the two adjacent cells contain a piece from the same
        // player, then the piece is protected.
        let prev_cell_occ: u8 = get_cell_occupant(cells, cell - 1u8);
        let next_cell_occ: u8 = get_cell_occupant(cells, cell + 1u8);
        if (prev_cell_occ == occ || next_cell_occ == occ) {
            return true;
        } else {
            return false;
        }
    }







    // This function moves a piece from one cell to another.
    function move_piece(cells: Cells, origin_cell: u8, target_cell: u8) -> Cells {
        let occ: u8 = get_cell_occupant(cells, origin_cell);
        cells = set_cell_occupant(cells, target_cell, occ);
        cells = clear_cell_inline(cells, origin_cell);
        return cells;
    }

    // This function exchanges the positions of two pieces.
    function exchange_pieces(cells: Cells, origin_cell: u8, target_cell: u8) -> Cells {
        let origin_cell_occ: u8 = get_cell_occupant(cells, origin_cell);
        let target_cell_occ: u8 = get_cell_occupant(cells, target_cell);
        cells = set_cell_occupant(cells, origin_cell, target_cell_occ);
        cells = set_cell_occupant(cells, target_cell, origin_cell_occ);
        return cells;
     }


    // Adds the current player's invisible pieces to the board, so that 
    // the current player can make their move. These invisible pieces
    // will be removed afterwards, before sending the board to the 
    // opponent.
    function add_invisible_pieces(board: Board, ip: InvisiblePieces) -> Cells {
        let cell_state: u32 = board.cell_state.or(ip.positions);
        let cell_occ: u32 = board.cell_occ;
        if board.owner == board.p2 {
            cell_occ = board.cell_occ.or(ip.positions);
        }
        return Cells {
            state: cell_state,
            occupant: cell_occ
        };
     }

    function clear_invisible_pieces(cells: Cells, ip_positions: u32) -> Cells {
        let cell_state: u32 = cells.state.and(ip_positions.not());
        let cell_occ: u32 = cells.occupant.and(ip_positions.not());
        return Cells {
            state: cell_state,
            occupant: cell_occ
        };
    }
*/
}