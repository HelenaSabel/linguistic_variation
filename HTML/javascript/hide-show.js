window.addEventListener('load', hide, false);

function hide() {
    var boxes = document.getElementsByTagName("input");
    for (i = 0; i < boxes.length; i++) {
        var box = boxes[i];
        box.addEventListener('change', show, false);
    }
}

function show() {
    
    
    var matchedElement = document.getElementsByClassName(this.className)[0];
    if (this.checked == true) {matchedElement.style.display = 'block';
    }
    else {matchedElement.style.display = 'none';}
}