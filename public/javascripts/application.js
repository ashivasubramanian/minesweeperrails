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
	result = $.getJSON(reveal_boards_path, {"row":row, "column":column}, revealCell);
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
	$(mouseOverControl).text(data.mine_count);
	$(mouseOverControl).css("color", data.cell_colour);
	$(mouseOverControl).css("background-color", "white");
}

function highlightCell(control) {
	var current_control = document.getElementById("board").rows[row].cells[column];
	unhighlightCell(current_control);
	$(control).css("border", "1px white solid");
}

function unhighlightCell(control) {
	$(control).css("border", "1px black solid");
}

function determineAction(event) {
	if (mouseOverControl != undefined) {
		for (i = 0; i < document.getElementById("board").rows.length; i++) {
			var single_row = document.getElementById("board").rows[i];
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
		unhighlightCell(document.getElementById("board").rows[row].cells[column]);
		column--;
		highlightCell(document.getElementById("board").rows[row].cells[column]);
	} else if (event.keyCode == 39) { // Right arrow
		unhighlightCell(document.getElementById("board").rows[row].cells[column]);
		column++;
		highlightCell(document.getElementById("board").rows[row].cells[column]);
	} else if (event.keyCode == 38) { // Up arrow
		unhighlightCell(document.getElementById("board").rows[row].cells[column]);
		row--;
		highlightCell(document.getElementById("board").rows[row].cells[column]);
	} else if (event.keyCode == 40) { //Down arrow
		unhighlightCell(document.getElementById("board").rows[row].cells[column]);
		row++;
		highlightCell(document.getElementById("board").rows[row].cells[column]);
	}
	mouseOverControl = document.getElementById("board").rows[row].cells[column];
}

function findRowAndColumnValues() {
	if (mouseOverControl != undefined) {
		for (i = 0; i < document.getElementById("board").rows.length; i++) {
			var single_row = document.getElementById("board").rows[i];
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
	document.forms[0].method = 'get';
	document.forms[0].action = new_board_path + "?mode=" + this.value;
	document.forms[0].submit();
}
