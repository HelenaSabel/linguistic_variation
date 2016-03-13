"use strict";

function criteria() {
    var show = document.getElementsByClassName('dinamic')[0];
    show.addEventListener('mouseover', popUp, false);
}


function popUp(event) {
    if (! this.id) {
        var criterion = document.createElement("div");
        var div = document.getElementsByClassName('criterios')[0];
        var divContent = div.cloneNode(true);
        var y = event.pageY;
        var random = "n" + Math.random();
        this.id = random;
        criterion.appendChild(divContent);
        criterion.classList.add('popup');
        criterion.style.fontSize = "smaller";
        criterion.style.backgroundColor = "#EFEEA9";
        criterion.style.position = "absolute";
        criterion.style.top = y + "px";
        criterion.style.right = "15px";
        criterion.style.border = "1px solid #2B3966";
        criterion.style.borderWidth = "2px";
        criterion.style.color = "#3D2301";
        criterion.style.margin = "0";
        criterion.style.padding = ".5em";
        criterion.dataset.pointer = random;
        criterion.addEventListener('mouseleave', destroy, false);
        document.body.appendChild(criterion);
        var inputs = criterion.querySelectorAll('input[type="radio"]');
        for (var i = 0; i < inputs.length; i++) {
            inputs[i].addEventListener('click', giveId, false);
        }
        var boxes = criterion.querySelectorAll('input[type="checkbox"]');
        for (var i = 0; i < inputs.boxes; i++) {
            boxes[i].addEventListener('change', changecriteria, false);
        }
    }
}

function destroy() {
    var popup = document.getElementById(this.dataset.pointer);
    popup.removeAttribute("id");
    document.body.removeChild(this);
}

function giveId() {
    var id = this.getAttribute('value');
    var ams = document.getElementsByClassName('am');
    var expans = document.getElementsByClassName('expansion');
    var regs = document.getElementsByClassName('reg');
    var origs = document.getElementsByClassName('orig');
    
    switch (id) {
        
        case 'abb':
        for (var i = 0; i < ams.length; i++) {
            ams[i].style.display = 'inline-block';
        }
        for (var i = 0; i < expans.length; i++) {
            expans[i].style.display = 'none';
        }
        
        break;
        
        case 'expan':
        for (var i = 0; i < ams.length; i++) {
            ams[i].style.display = 'none';
        }
        for (var i = 0; i < expans.length; i++) {
            expans[i].style.display = 'inline-block';
        }
        
        break;
        
        case 'reg':
        for (var i = 0; i < regs.length; i++) {
            regs[i].style.display = 'inline-block';
        }
        for (var i = 0; i < origs.length; i++) {
            origs[i].style.display = 'none';
        }
        
        break;
        
        case 'orig':
        for (var i = 0; i < regs.length; i++) {
            regs[i].style.display = 'none';
        }
        for (var i = 0; i < origs.length; i++) {
            origs[i].style.display = 'inline-block';
        }
    }
}

function changecriteria() {
    
    var id = this.getAttribute('value');
    var dels = document.querySelectorAll('del');
    var adds = document.querySelectorAll('ins');
    var apostrophes = document.getElementsByClassName('supplied');
    
    switch (id) {
        case 'del':
        
        if (this.checked == true) { for (var i = 0; i < dels.length; i++) {
                dels[i].classList.remove('hide');
                
                if (dels[i].classList.contains('underdot')) {
                    var letters = dels[i].textContent.split('');
                    var output = '';
                    for (var j = 0; j < letters.length; j++) {
                        output += (letters[j] + '&#803;');
                    }
                    dels[i].innerHTML = output;
                }
                if (dels[i].classList.contains('multiple-overstrike')) {
                    var letters = dels[i].textContent.split('');
                    var output2 = '';
                    for (var y = 0; y < letters.length; j++) {
                        output += (letters[y] + '&#824;');
                    }
                    dels[i].innerHTML = output2;
                }
                
                if (dels[i].classList.contains('scrape')) {
                    dels[i].style.opacity = '0.9';
                }
            }
        } else { for (var i = 0; i < dels.length; i++) {
                dels[i].classList.add('hide');
            }
        }
        
        break;
        
        case 'add':
        
        if (this.checked == true) {
            
            for (var i = 0; i < adds.length; i++) {
                adds[i].classList.add('enhance');
            }
        } else { for (var i = 0; i < adds.length; i++) {
                adds[i].classList.remove('enhance')
            }
        }
        
        break;
        
        case 'apostrophe':
        
        if (this.checked == false) {
            
            for (var i = 0; i < apostrophes.length; i++) {
                apostrophes[i].classList.add('hide');
            }
        } else {
            for (var i = 0; i < apostrophes.length; i++) {
                apostrophes[i].classList.remove('hide');
            }
        }
    }
}

window.onload = criteria;