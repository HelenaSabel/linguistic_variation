function tooltip() {
    var myspans = document.querySelectorAll('[data-exp]');
    for (var i = 0; i < myspans.length; i++) {
        myspans[i].addEventListener('click', popup, false);
    }
}


function popup(event) {
    if (! this.id) {
        var overlay = document.createElement("div");
        var x = event.pageX;
        var y = event.pageY;
        var random = "n" + Math.random();
        
        this.id = random;
        if (this.dataset.exp) {
            overlay.innerHTML = this.dataset.exp;
        }
        overlay.style.backgroundColor = "#D49107";
        overlay.style.position = "absolute";
        overlay.style.left = x + "px";
        overlay.style.top = y + "px";
        overlay.style.border = "1px solid #2B3966";
        overlay.style.borderWidth = "2px";
        overlay.style.color = "#3D2301";
        overlay.style.margin = "0";
        overlay.style.padding = ".5em";
        overlay.dataset.pointer = random;
        overlay.addEventListener('click', destruir, false);
        document.body.appendChild(overlay);
    }
}

function destruir() {
    var myspan = document.getElementById(this.dataset.pointer);
    myspan.removeAttribute("id");
    document.body.removeChild(this);
}

window.addEventListener('load', tooltip, false);