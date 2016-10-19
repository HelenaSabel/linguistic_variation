/* Most of the code was copied from lgToggle.js by David J. Birnbaum at http://repertorium.obdurodon.org */


function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() +(days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    } else var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}



function language () {
    var siglas = document.getElementsByClassName('language');
    for (i = 0; i < siglas.length; i++) {
        siglas[i].addEventListener('click', changeLang, false);
    }
    var lang = readCookie('lg');
    if (lang) {
        createCookie('lg', lang, 30);
        changeLang();
    } else {
        var LNG = window.navigator.language.substring(0, 2);
        if (LNG == 'gl') {
            var lang = LNG;
        } else if (LNG == 'es') {
            var lang = 'gl';
        } else if (LNG == 'pt') {
            var lang = LNG;
        } else {
            var lang = 'en';
        }        
            createCookie('lg', lang, 30);
            changeLang();
    }
}



function changeLang() {
    if (typeof this.id === 'undefined') {
        var id = readCookie('lg')
    } else {
        var id = this.id;
    }
    createCookie('lg', id, 30);
    var pts = document.getElementsByClassName('pt');
    var ptsLength = pts.length;
    var ens = document.getElementsByClassName('en');
    var ensLength = ens.length;
    var gls = document.getElementsByClassName('gl');
    var glsLength = gls.length;
    var initialSiglas = document.querySelectorAll('.languages > a > span');
    var initialSiglasLength = initialSiglas.length;
    for (i = 0; i < initialSiglasLength; i++) {
        if (initialSiglas[i].id == id) {
            initialSiglas[i].style.textShadow = '1px 2px 3px rgba(127, 100, 28, 1)';
        } else {
            initialSiglas[i].style.textShadow = 'none';
        }
    }
    switch (id) {
        case 'pt':
        for (var i = 0; i < ensLength; i++) {
            ens[i].style.display = 'none';
        }
        for (var i = 0; i < glsLength; i++) {
            gls[i].style.display = 'none';
        }
        for (var i = 0; i < ptsLength; i++) {
            pts[i].style.display = 'inline';
        }
        break;
        case 'en':
        for (var i = 0; i < ptsLength; i++) {
            pts[i].style.display = 'none';
        }
        for (var i = 0; i < glsLength; i++) {
            gls[i].style.display = 'none';
        }
        for (var i = 0; i < ensLength; i++) {
            ens[i].style.display = 'inline';
        }
        break;
        case 'gl':
        for (var i = 0; i < ensLength; i++) {
            ens[i].style.display = 'none';
        }
        for (var i = 0; i < ptsLength; i++) {
            pts[i].style.display = 'none';
        }
        for (var i = 0; i < glsLength; i++) {
            gls[i].style.display = 'inline';
        }
    }
}

window.addEventListener('load', language, false);