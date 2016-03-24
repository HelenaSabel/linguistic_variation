function menu() {
    var lis = document.getElementsByClassName('has-sub');
    for (var i = 0; i <lis.length; i++) {
        lis[i].addEventListener('click', tap, false);
    }
}

function tap(){
    this.classList.toggle('tap');
    var taps = document.getElementsByClassName('tap');
    for (var i = 0; i <taps.length; i++) {
        taps[i].addEventListener('click', destroy, false);
    }
}

function destroy() {
    this.classList.toggle('has-sub');
}

window.onload = menu;

