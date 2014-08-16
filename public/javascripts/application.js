// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(doEventBinding);
var row = 0;
var column = 0;
var mouseOverControl;

function doEventBinding() {
	$("#board_mode_name").bind("change", changeMode); 
	$("#board td").bind("click", reveal);
	$("#board td").bind("mouseover", highlight);
	$("#board td").bind("mouseout", unhighlight);
	$(document).bind("keydown", determineAction);
}

function reveal() {
	result = $.getJSON(reveal_games_path, {"row":row, "column":column}, revealCell);
}	

function highlight() {
	mouseOverControl = this;
	findRowAndColumnValues();
	highlightCell(this);
}

function unhighlight() {
	unhighlightCell(this);
}

function revealCell(data) {
	mine_count = data.cell.mine_count;
	if (mine_count == -1)
	{
		alert("You clicked on a mine!! GAME OVER!!");
		$($('form')[0]).attr('method', 'get');
		$($('form')[0]).submit();
	}
	$(mouseOverControl).text(mine_count);
	$(mouseOverControl).css("color", data.cell.cell_colour);
	$(mouseOverControl).css("background-color", "white");
}

function highlightCell(control) {
	var current_control = $("#board")[0].rows[row].cells[column];
	unhighlightCell(current_control);
	$(control).css("border", "1px white solid");
}

function unhighlightCell(control) {
	$(control).css("border", "1px black solid");
}

function determineAction(event) {
	board = $('#board')[0];
	if (mouseOverControl != undefined) {
		for (i = 0; i < board.rows.length; i++) {
			var single_row = board.rows[i];
			for (j = 0 ; j < single_row.cells.length; j++) {
				var single_cell = single_row.cells[j];
				if (single_cell == mouseOverControl) {
					row = i;
					column = j;
					break;
				}
			}
		}
	}
	if (event.keyCode == 32) { //space
		reveal();
	} else if (event.keyCode == 37) { //Left arrow
		unhighlightCell(board.rows[row].cells[column]);
		column--;
		highlightCell(board.rows[row].cells[column]);
	} else if (event.keyCode == 39) { // Right arrow
		unhighlightCell(board.rows[row].cells[column]);
		column++;
		highlightCell(board.rows[row].cells[column]);
	} else if (event.keyCode == 38) { // Up arrow
		unhighlightCell(board.rows[row].cells[column]);
		row--;
		highlightCell(board.rows[row].cells[column]);
	} else if (event.keyCode == 40) { //Down arrow
		unhighlightCell(board.rows[row].cells[column]);
		row++;
		highlightCell(board.rows[row].cells[column]);
	}
	mouseOverControl = board.rows[row].cells[column];
}

function findRowAndColumnValues() {
	if (mouseOverControl != undefined) {
		for (i = 0; i < $("#board")[0].rows.length; i++) {
			var single_row = $("#board")[0].rows[i];
			for (j = 0 ; j < single_row.cells.length; j++) {
				var single_cell = single_row.cells[j];
				if (single_cell == mouseOverControl) {
					row = i;
					column = j;
					break;
				}
			}
		}
	}
}

function changeMode() {
	$($('form')[0]).attr('method', 'get');
	$($('form')[0]).attr('action', new_game_path + "?mode=" + this.value);
	$($('form')[0]).submit();
}
