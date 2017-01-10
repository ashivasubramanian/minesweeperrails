// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(document).ready(doEventBinding);
var row = 0;
var column = 0;
var mouseOverControl;

function doEventBinding() {
	jQuery("#board_mode_name").bind("change", changeMode); 
	jQuery("#board td").bind("mouseover", highlight);
	jQuery("#board td").bind("mouseout", unhighlight);
	jQuery(document).bind("keydown", determineAction);
}

function highlight() {
	mouseOverControl = this;
	findRowAndColumnValues();
	highlightCell(this);
}

function unhighlight() {
	unhighlightCell(this);
}

function highlightCell(control) {
	var current_control = jQuery("#board")[0].rows[row].cells[column];
	unhighlightCell(current_control);
	jQuery(control).css("border", "1px white solid");
}

function unhighlightCell(control) {
	jQuery(control).css("border", "1px black solid");
}

function determineAction(event) {
	board = jQuery('#board')[0];
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
		for (i = 0; i < jQuery("#board")[0].rows.length; i++) {
			var single_row = jQuery("#board")[0].rows[i];
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
	jQuery(jQuery('form')[0]).attr('method', 'get');
	jQuery(jQuery('form')[0]).attr('action', new_game_path + "?mode=" + this.value);
	jQuery(jQuery('form')[0]).submit();
}
